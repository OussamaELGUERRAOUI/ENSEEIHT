/**
 */
package petrinet;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Arc</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link petrinet.Arc#getWeight <em>Weight</em>}</li>
 *   <li>{@link petrinet.Arc#getKind <em>Kind</em>}</li>
 *   <li>{@link petrinet.Arc#getSource <em>Source</em>}</li>
 *   <li>{@link petrinet.Arc#getTarget <em>Target</em>}</li>
 *   <li>{@link petrinet.Arc#getDirection <em>Direction</em>}</li>
 * </ul>
 *
 * @see petrinet.PetrinetPackage#getArc()
 * @model
 * @generated
 */
public interface Arc extends PetriNetElement {
	/**
	 * Returns the value of the '<em><b>Weight</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Weight</em>' attribute.
	 * @see #setWeight(int)
	 * @see petrinet.PetrinetPackage#getArc_Weight()
	 * @model
	 * @generated
	 */
	int getWeight();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getWeight <em>Weight</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Weight</em>' attribute.
	 * @see #getWeight()
	 * @generated
	 */
	void setWeight(int value);

	/**
	 * Returns the value of the '<em><b>Kind</b></em>' attribute.
	 * The default value is <code>"normal"</code>.
	 * The literals are from the enumeration {@link petrinet.ArcKind}.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Kind</em>' attribute.
	 * @see petrinet.ArcKind
	 * @see #setKind(ArcKind)
	 * @see petrinet.PetrinetPackage#getArc_Kind()
	 * @model default="normal"
	 * @generated
	 */
	ArcKind getKind();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getKind <em>Kind</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Kind</em>' attribute.
	 * @see petrinet.ArcKind
	 * @see #getKind()
	 * @generated
	 */
	void setKind(ArcKind value);

	/**
	 * Returns the value of the '<em><b>Source</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link petrinet.Node#getLinkToSource <em>Link To Source</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Source</em>' reference.
	 * @see #setSource(Node)
	 * @see petrinet.PetrinetPackage#getArc_Source()
	 * @see petrinet.Node#getLinkToSource
	 * @model opposite="linkToSource"
	 * @generated
	 */
	Node getSource();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getSource <em>Source</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Source</em>' reference.
	 * @see #getSource()
	 * @generated
	 */
	void setSource(Node value);

	/**
	 * Returns the value of the '<em><b>Target</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link petrinet.Node#getLinkToTarget <em>Link To Target</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Target</em>' reference.
	 * @see #setTarget(Node)
	 * @see petrinet.PetrinetPackage#getArc_Target()
	 * @see petrinet.Node#getLinkToTarget
	 * @model opposite="linkToTarget"
	 * @generated
	 */
	Node getTarget();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getTarget <em>Target</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Target</em>' reference.
	 * @see #getTarget()
	 * @generated
	 */
	void setTarget(Node value);

	/**
	 * Returns the value of the '<em><b>Direction</b></em>' attribute.
	 * The default value is <code>"P2T"</code>.
	 * The literals are from the enumeration {@link petrinet.ArcDirection}.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Direction</em>' attribute.
	 * @see petrinet.ArcDirection
	 * @see #setDirection(ArcDirection)
	 * @see petrinet.PetrinetPackage#getArc_Direction()
	 * @model default="P2T"
	 * @generated
	 */
	ArcDirection getDirection();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getDirection <em>Direction</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Direction</em>' attribute.
	 * @see petrinet.ArcDirection
	 * @see #getDirection()
	 * @generated
	 */
	void setDirection(ArcDirection value);

} // Arc
