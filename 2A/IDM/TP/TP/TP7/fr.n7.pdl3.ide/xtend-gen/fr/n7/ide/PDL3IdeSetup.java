/**
 * generated by Xtext 2.17.1
 */
package fr.n7.ide;

import com.google.inject.Guice;
import com.google.inject.Injector;
import fr.n7.PDL3RuntimeModule;
import fr.n7.PDL3StandaloneSetup;
import fr.n7.ide.PDL3IdeModule;
import org.eclipse.xtext.util.Modules2;

/**
 * Initialization support for running Xtext languages as language servers.
 */
@SuppressWarnings("all")
public class PDL3IdeSetup extends PDL3StandaloneSetup {
  @Override
  public Injector createInjector() {
    PDL3RuntimeModule _pDL3RuntimeModule = new PDL3RuntimeModule();
    PDL3IdeModule _pDL3IdeModule = new PDL3IdeModule();
    return Guice.createInjector(Modules2.mixin(_pDL3RuntimeModule, _pDL3IdeModule));
  }
}