import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Cliente {

    private Cliente() {
    }

    public static void main(String[] args) {

        try {
            // Registry registry = LocateRegistry.getRegistry("127.0.0.1", 2001);
            Registry registry = LocateRegistry.getRegistry("localhost", 2000);
            IHello stub = (IHello) registry.lookup("rmi://localhost:2000/Hello");
            String response = stub.sayHello();
            System.out.println("response: " + response);
        } catch (Exception e) {
            System.err.println("Client exception: " + e.toString());
            e.printStackTrace();
        }
    }

}
