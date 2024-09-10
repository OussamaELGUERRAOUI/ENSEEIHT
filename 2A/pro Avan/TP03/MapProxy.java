import java.util.*;

public class MapProxy {
    public static void main(String[] args) throws Throwable {
        Random rand = new Random();
        Map<String, Integer> map = new HashMap<String, Integer>();
        System.out.println("Create an empty map : " + map);
        map.put("two", 2);
        map.put("three", 3);
        map.put("five", 5);
        map.put("seven", 7);
        System.out.println("Fill the map : " + map);
        map.remove("seven");
        System.out.println("Remove 7 from the map : " + map);
        String[] methodNames = {"put", "remove"};
        ProtectionHandler proxy = new ProtectionHandler(map, methodNames);
        System.out.println("Create a proxy object of map : " + map);
        if (rand.nextInt(1000) % 2 == 0) {
            proxy.invoke(map, HashMap.class.getMethod("put", new Class[]{Object.class, Object.class}), new Object[]{"eleven", 11});
        } else {
            proxy.invoke(map, Map.class.getMethod("remove", new Class[]{Object.class}), new Object[]{"eleven"});
        }
    }
    
}
