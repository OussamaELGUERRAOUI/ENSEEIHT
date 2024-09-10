/**
 */
package petrinet;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Petri Net Element</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link petrinet.PetriNetElement#getPetrinet <em>Petrinet</em>}</li>
 * </ul>
 *
 * @see petrinet.PetrinetPackage#getPetriNetElement()
 * @model abstract="true"
 * @generated
 */
public interface PetriNetElement extends EObject {
	/**
	 * Returns the value of the '<em><b>Petrinet</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Petrinet</em>' reference.
	 * @see #setPetrinet(PetriNet)
	 * @see petrinet.PetrinetPackage#getPetriNetElement_Petrinet()
	 * @model required="true"
	 * @generated
	 */
	PetriNet getPetrinet();

	/**
	 * Sets the value of the '{@link petrinet.PetriNetElement#getPetrinet <em>Petrinet</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Petrinet</em>' reference.
	 * @see #getPetrinet()
	 * @generated
	 */
	void setPetrinet(PetriNet value);

} // PetriNetElement
