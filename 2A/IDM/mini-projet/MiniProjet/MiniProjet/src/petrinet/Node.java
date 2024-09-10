/**
 */
package petrinet;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Node</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link petrinet.Node#getName <em>Name</em>}</li>
 *   <li>{@link petrinet.Node#getLinkToTarget <em>Link To Target</em>}</li>
 *   <li>{@link petrinet.Node#getLinkToSource <em>Link To Source</em>}</li>
 * </ul>
 *
 * @see petrinet.PetrinetPackage#getNode()
 * @model abstract="true"
 * @generated
 */
public interface Node extends PetriNetElement {
	/**
	 * Returns the value of the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Name</em>' attribute.
	 * @see #setName(String)
	 * @see petrinet.PetrinetPackage#getNode_Name()
	 * @model
	 * @generated
	 */
	String getName();

	/**
	 * Sets the value of the '{@link petrinet.Node#getName <em>Name</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Name</em>' attribute.
	 * @see #getName()
	 * @generated
	 */
	void setName(String value);

	/**
	 * Returns the value of the '<em><b>Link To Target</b></em>' reference list.
	 * The list contents are of type {@link petrinet.Arc}.
	 * It is bidirectional and its opposite is '{@link petrinet.Arc#getTarget <em>Target</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Link To Target</em>' reference list.
	 * @see petrinet.PetrinetPackage#getNode_LinkToTarget()
	 * @see petrinet.Arc#getTarget
	 * @model opposite="target"
	 * @generated
	 */
	EList<Arc> getLinkToTarget();

	/**
	 * Returns the value of the '<em><b>Link To Source</b></em>' reference list.
	 * The list contents are of type {@link petrinet.Arc}.
	 * It is bidirectional and its opposite is '{@link petrinet.Arc#getSource <em>Source</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Link To Source</em>' reference list.
	 * @see petrinet.PetrinetPackage#getNode_LinkToSource()
	 * @see petrinet.Arc#getSource
	 * @model opposite="source"
	 * @generated
	 */
	EList<Arc> getLinkToSource();

} // Node
