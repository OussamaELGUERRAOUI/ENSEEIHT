package org.jboss.resteasy.test.resource.basic.resource;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;

public interface MultiInterfaceResLocatorIntf1 {
    @GET
    @Produces("text/plain")
    @Path("hello1")
    String resourceMethod1();
}
