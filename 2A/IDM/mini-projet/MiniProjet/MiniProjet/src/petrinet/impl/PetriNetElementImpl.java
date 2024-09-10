/**
 */
package petrinet.impl;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import petrinet.PetriNet;
import petrinet.PetriNetElement;
import petrinet.PetrinetPackage;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Petri Net Element</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * </p>
 * <ul>
 *   <li>{@link petrinet.impl.PetriNetElementImpl#getPetrinet <em>Petrinet</em>}</li>
 * </ul>
 *
 * @generated
 */
public abstract class PetriNetElementImpl extends MinimalEObjectImpl.Container implements PetriNetElement {
	/**
	 * The cached value of the '{@link #getPetrinet() <em>Petrinet</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getPetrinet()
	 * @generated
	 * @ordered
	 */
	protected PetriNet petrinet;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected PetriNetElementImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return PetrinetPackage.Literals.PETRI_NET_ELEMENT;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public PetriNet getPetrinet() {
		if (petrinet != null && petrinet.eIsProxy()) {
			InternalEObject oldPetrinet = (InternalEObject)petrinet;
			petrinet = (PetriNet)eResolveProxy(oldPetrinet);
			if (petrinet != oldPetrinet) {
				if (eNotificationRequired())
					eNotify(new ENotificationImpl(this, Notification.RESOLVE, PetrinetPackage.PETRI_NET_ELEMENT__PETRINET, oldPetrinet, petrinet));
			}
		}
		return petrinet;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public PetriNet basicGetPetrinet() {
		return petrinet;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void setPetrinet(PetriNet newPetrinet) {
		PetriNet oldPetrinet = petrinet;
		petrinet = newPetrinet;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, PetrinetPackage.PETRI_NET_ELEMENT__PETRINET, oldPetrinet, petrinet));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case PetrinetPackage.PETRI_NET_ELEMENT__PETRINET:
				if (resolve) return getPetrinet();
				return basicGetPetrinet();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case PetrinetPackage.PETRI_NET_ELEMENT__PETRINET:
				setPetrinet((PetriNet)newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case PetrinetPackage.PETRI_NET_ELEMENT__PETRINET:
				setPetrinet((PetriNet)null);
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case PetrinetPackage.PETRI_NET_ELEMENT__PETRINET:
				return petrinet != null;
		}
		return super.eIsSet(featureID);
	}

} //PetriNetElementImpl
