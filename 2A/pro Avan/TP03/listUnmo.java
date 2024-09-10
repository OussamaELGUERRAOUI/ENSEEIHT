import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class listUnmo {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<Integer>();
        list.add(2);
        list.add(3);
        list.add(5);
        list.add(7);

        System.out.println("Original List: " + list);

        list.remove( Integer.valueOf(5));
        System.out.println("After remove(5): " + list);

        List<Integer> list2 = Collections.unmodifiableList(list);
        System.out.println("Unmodifiable List: " + list2);

        try {
            list2.remove(3);
        } catch (UnsupportedOperationException e) {
            System.out.println("Exception: " + e);
        }


    }
}
 
