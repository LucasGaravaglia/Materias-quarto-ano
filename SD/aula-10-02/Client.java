import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client {

  private Client() {
  }

  public static void main(String[] args) {

    try {
      Registry registry = LocateRegistry.getRegistry("192.168.20.24", 2000);
      IHello stub = (IHello) registry.lookup("rmi://192.168.20.24:2000/Hello");
      String response = stub.sayHello();
      System.out.println("response: " + response);
    } catch (Exception e) {
      System.err.println("Client exception: " + e.toString());
      e.printStackTrace();
    }
  }
}
