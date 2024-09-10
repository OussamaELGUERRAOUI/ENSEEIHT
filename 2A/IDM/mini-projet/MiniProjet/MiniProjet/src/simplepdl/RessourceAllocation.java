/**
 */
package simplepdl;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Ressource Allocation</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link simplepdl.RessourceAllocation#getOccurrence <em>Occurrence</em>}</li>
 *   <li>{@link simplepdl.RessourceAllocation#getRessource <em>Ressource</em>}</li>
 *   <li>{@link simplepdl.RessourceAllocation#getWorkdefinition <em>Workdefinition</em>}</li>
 * </ul>
 *
 * @see simplepdl.SimplepdlPackage#getRessourceAllocation()
 * @model
 * @generated
 */
public interface RessourceAllocation extends EObject {
	/**
	 * Returns the value of the '<em><b>Occurrence</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Occurrence</em>' attribute.
	 * @see #setOccurrence(int)
	 * @see simplepdl.SimplepdlPackage#getRessourceAllocation_Occurrence()
	 * @model
	 * @generated
	 */
	int getOccurrence();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceAllocation#getOccurrence <em>Occurrence</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Occurrence</em>' attribute.
	 * @see #getOccurrence()
	 * @generated
	 */
	void setOccurrence(int value);

	/**
	 * Returns the value of the '<em><b>Ressource</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Ressource</em>' reference.
	 * @see #setRessource(Ressource)
	 * @see simplepdl.SimplepdlPackage#getRessourceAllocation_Ressource()
	 * @model required="true"
	 * @generated
	 */
	Ressource getRessource();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceAllocation#getRessource <em>Ressource</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Ressource</em>' reference.
	 * @see #getRessource()
	 * @generated
	 */
	void setRessource(Ressource value);

	/**
	 * Returns the value of the '<em><b>Workdefinition</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Workdefinition</em>' reference.
	 * @see #setWorkdefinition(WorkDefinition)
	 * @see simplepdl.SimplepdlPackage#getRessourceAllocation_Workdefinition()
	 * @model required="true"
	 * @generated
	 */
	WorkDefinition getWorkdefinition();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceAllocation#getWorkdefinition <em>Workdefinition</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Workdefinition</em>' reference.
	 * @see #getWorkdefinition()
	 * @generated
	 */
	void setWorkdefinition(WorkDefinition value);

} // RessourceAllocation
