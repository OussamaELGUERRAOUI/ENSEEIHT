/*
 * generated by Xtext 2.17.1
 */
package fr.n7.ide

import com.google.inject.Guice
import fr.n7.PDL3RuntimeModule
import fr.n7.PDL3StandaloneSetup
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class PDL3IdeSetup extends PDL3StandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new PDL3RuntimeModule, new PDL3IdeModule))
	}
	
}