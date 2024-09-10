package simplepdl.impl;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import petrinet.*;
import simplepdl.*;
import simplepdl.Process;
import simplepdl.WorkDefinition;
import simplepdl.WorkSequence;

public class SimplePDL2PetriNet {

	/** La petriNet Factory. */
	static private PetrinetFactory petrinetFactory = PetrinetFactory.eINSTANCE;
	/** La petriNet. */
	static private PetriNet petriNet = petrinetFactory.createPetriNet();
	/** La liste des places Ready. */
	static private Map<String, Place> ReadyMap = new HashMap<String, Place>();
	/** La liste des places Started. */
	static private Map<String, Place> StartedMap = new HashMap<String, Place>();
	/** La liste des places Finished. */
	static private Map<String, Place> FinishedMap = new HashMap<String, Place>();
	/** La liste des places Running. */
	static private Map<String, Place> RunningMap = new HashMap<String, Place>();
	/** La liste des transitions Start. */
	static private Map<String, Transition> StartMap = new HashMap<String, Transition>();
	/** La liste des transitions Finish. */
	static private Map<String, Transition> FinishMap = new HashMap<String, Transition>();

	/** Convertit un modèle SimplePDL en modèle PetriNet.
	 * @param args
	 */
	@SuppressWarnings("unused")
	public static void main(String[] args) {

		// Charger le package SimplePDL afin de l'enregistrer dans le registre d'Eclipse.
		SimplepdlPackage packageInstanceSimplePDL = SimplepdlPackage.eINSTANCE;
		
		// Charger le package PetriNet afin de l'enregistrer dans le registre d'Eclipse.
		PetrinetPackage packageInstancePetriNet = PetrinetPackage.eINSTANCE;
				
		// Enregistrer l'extension ".xmi" comme devant être ouverte à l'aide d'un objet "XMIResourceFactoryImpl"
		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());
				
		// Créer un objet resourceSetImpl qui contiendra une ressource EMF (le modèle)
		ResourceSet resSet = new ResourceSetImpl();
				
		// Créer le modèle de sorte (PetriNet.xmi)
		URI SortieURI = URI.createURI("out.xmi");
		Resource Sortie = resSet.createResource(SortieURI);
				
		// Créer un objet resourceSetImpl qui contiendra une ressource EMF (le modèle)
		ResourceSet resSetModel = new ResourceSetImpl();
		
		// Charger la ressource (notre modèle)
		URI modelURI = URI.createURI("SimplePDL.xmi");
		Resource resource = resSetModel.getResource(modelURI, true);
				
		// Récupérer le premier élément du modèle (élément racine)
		Process process = (Process) resource.getContents().get(0);

		// Nommer la PetriNet par le nom du process
		petriNet.setName(process.getName());

		// Ajouter la PetriNet à la sortie
		Sortie.getContents().add(petriNet);

		// Parcouir les éléments du process
		for (Object o : process.getProcesselement()) {

			// Si l'élément est une WorkSequence
			if (o instanceof WorkSequence) {
				// On le convertit en Arc
				WorkSequence2Arc((WorkSequence) o);
			// Si l'élément est une WorkDefinition
			} else if (o instanceof WorkDefinition) {
				// On le convertit en Place
				WorkDefinition2Place((WorkDefinition) o);
			} else if (o instanceof Ressource) {
				Ressource2Place((Ressource) o);
			}
		}
		
		 // Sauvegarde de la ressource de sortie
	    try {
	    	Sortie.save(Collections.EMPTY_MAP);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	}
	
	public static void Ressource2Place(Ressource ressource) {
		
		// Creation de la place pour ressource
		Place ressourcePlace = petrinetFactory.createPlace();
		
		// Modifier le nom de la place ressource
		ressourcePlace.setName(ressource.getName() + "_Ressource");
		
		// Ajuster les jetons de la place ressource
		ressourcePlace.setJeton(ressource.getQuantity());
		
		// Ajouter l'élément à la petrinet
		petriNet.getPetrinetelement().add(ressourcePlace);
		
		// Allocation des ressource pour les workdefintions
		for (RessourceAllocation a : ressource.getRessourceallocation()) {
			
			// Creation de l'arc liant 
			Arc ressource2Start = petrinetFactory.createArc();
			ressource2Start.setKind(ArcKind.NORMAL);
			ressource2Start.setWeight(a.getOccurrence());
			ressource2Start.setDirection(ArcDirection.P2T);
			ressource2Start.setSource(ressourcePlace);
			ressource2Start.setTarget(StartMap.get(a.getWorkdefinition().getName() + "_Start"));
			
			// Creation de l'arc liant 
			Arc finish2Ressource = petrinetFactory.createArc();
			finish2Ressource.setKind(ArcKind.NORMAL);
			finish2Ressource.setWeight(a.getOccurrence());
			finish2Ressource.setDirection(ArcDirection.T2P);
			finish2Ressource.setTarget(ressourcePlace);
			finish2Ressource.setSource(FinishMap.get(a.getWorkdefinition().getName() + "_Finish"));
		}
	}

	/** Convertit une WorkSequence en Arc
	 * @param workSeq
	 */
	public static void WorkSequence2Arc(WorkSequence workSeq) {

		// Creation du readArc
		Arc readArc = petrinetFactory.createArc();
		readArc.setKind(ArcKind.READ);
		readArc.setWeight(1);
		readArc.setDirection(ArcDirection.P2T);

		// le nom de la source et de la cible de la WorkSequence
		String sourceName = workSeq.getPredecessor().getName();
		String targetName = workSeq.getSuccessor().getName();

		if (workSeq.getLinkType() == WorkSequenceType.START_TO_START) {
			readArc.setSource(StartedMap.get(sourceName + "_Started"));
			readArc.setTarget(StartMap.get(targetName + "_Start"));
		} else if (workSeq.getLinkType() == WorkSequenceType.START_TO_FINISH) {
			readArc.setSource(StartedMap.get(sourceName + "_Started"));
			readArc.setTarget(FinishMap.get(targetName + "_Finish"));
		} else if (workSeq.getLinkType() == WorkSequenceType.FINISH_TO_START) {
			readArc.setSource(FinishedMap.get(sourceName + "_Finished"));
			readArc.setTarget(StartMap.get(targetName + "_Start"));
		} else if (workSeq.getLinkType() == WorkSequenceType.FINISH_TO_FINISH) {
			readArc.setSource(FinishedMap.get(sourceName + "_Finished"));
			readArc.setTarget(FinishMap.get(targetName + "_Finish"));
		}
	}

	/** Convertit une WorkDefinition en Place
	 * @param workDef
	 */
	public static void WorkDefinition2Place(WorkDefinition workDef) {

		// Le nom de la workDefinition qui va préciser le nom de chaque place
		String workDefName = workDef.getName();

		// Les places de la PetriNet
		Place workDefReady = petrinetFactory.createPlace();
		Place workDefStarted = petrinetFactory.createPlace();
		Place workDefFinished = petrinetFactory.createPlace();
		Place workDefRunning = petrinetFactory.createPlace();

		// Les transitions de la PetriNet
		Transition workDefStart = petrinetFactory.createTransition();
		Transition workDefFinish = petrinetFactory.createTransition();

		// Les arcs de la PetriNet
		Arc workDefReady2Start = petrinetFactory.createArc();
		Arc workDefStart2Started = petrinetFactory.createArc();
		Arc workDefStart2Running = petrinetFactory.createArc();
		Arc workDefRunning2Finish = petrinetFactory.createArc();
		Arc workDefFinish2Finished = petrinetFactory.createArc();

		// Ajuster les nom des places
		workDefReady.setName(workDefName + "_Ready");
		workDefStarted.setName(workDefName + "_Started");
		workDefFinished.setName(workDefName + "_Finished");
		workDefRunning.setName(workDefName + "_Running");

		// Ajuster les nom des transitions
		workDefStart.setName(workDefName + "_Start");
		workDefFinish.setName(workDefName + "_Finish");

		// Ajuster le jeton des places
		workDefReady.setJeton(1);
		workDefStarted.setJeton(0);
		workDefFinished.setJeton(0);
		workDefRunning.setJeton(0);

		// Ajuster la source et la cible des arcs, le type, la direction et le poids
		// L'arc de Ready à Start
		workDefReady2Start.setSource(workDefReady);
		workDefReady2Start.setTarget(workDefStart);
		workDefReady2Start.setKind(ArcKind.NORMAL);
		workDefReady2Start.setDirection(ArcDirection.P2T);
		workDefReady2Start.setWeight(1);

		// L'arc de Start à Started
		workDefStart2Started.setSource(workDefStart);
		workDefStart2Started.setTarget(workDefStarted);
		workDefStart2Started.setKind(ArcKind.NORMAL);
		workDefStart2Started.setDirection(ArcDirection.T2P);
		workDefStart2Started.setWeight(1);

		// L'arc de Start à Running
		workDefStart2Running.setSource(workDefStarted);
		workDefStart2Running.setTarget(workDefRunning);
		workDefStart2Running.setKind(ArcKind.NORMAL);
		workDefStart2Running.setDirection(ArcDirection.T2P);
		workDefStart2Running.setWeight(1);

		// L'arc de Running à Finish
		workDefRunning2Finish.setSource(workDefRunning);
		workDefRunning2Finish.setTarget(workDefFinish);
		workDefRunning2Finish.setKind(ArcKind.NORMAL);
		workDefRunning2Finish.setDirection(ArcDirection.P2T);
		workDefRunning2Finish.setWeight(1);

		// L'arc de Finish à Finished
		workDefFinish2Finished.setSource(workDefFinish);
		workDefFinish2Finished.setTarget(workDefFinished);
		workDefFinish2Finished.setKind(ArcKind.NORMAL);
		workDefFinish2Finished.setDirection(ArcDirection.T2P);
		workDefFinish2Finished.setWeight(1);

		// Ajouter tous les éléments à la PetriNet
		petriNet.getPetrinetelement().add(workDefReady);
		petriNet.getPetrinetelement().add(workDefStarted);
		petriNet.getPetrinetelement().add(workDefFinished);
		petriNet.getPetrinetelement().add(workDefRunning);
		petriNet.getPetrinetelement().add(workDefStart);
		petriNet.getPetrinetelement().add(workDefFinish);
		petriNet.getPetrinetelement().add(workDefReady2Start);
		petriNet.getPetrinetelement().add(workDefStart2Started);
		petriNet.getPetrinetelement().add(workDefStart2Running);
		petriNet.getPetrinetelement().add(workDefRunning2Finish);
		petriNet.getPetrinetelement().add(workDefFinish2Finished);

		// Ajouter les places et les transitions à la Map
		ReadyMap.put(workDefName + "_Ready", workDefReady);
		StartedMap.put(workDefName + "_Started", workDefStarted);
		FinishedMap.put(workDefName + "_Finished", workDefFinished);
		RunningMap.put(workDefName + "_Running", workDefRunning);
		StartMap.put(workDefName + "_Start", workDefStart);
		FinishMap.put(workDefName + "_Finish", workDefFinish);
	}
}
