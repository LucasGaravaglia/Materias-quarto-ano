import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.jgroups.*;

public class SimpleChat {
  private JChannel channel;
  private String user_name = System.getProperty("user.name", "n/a");

  private void start() throws Exception {
    channel = new JChannel();
    channel.connect("ChatCluster");
    eventLoop();
    channel.close();
  }

  private void eventLoop() {
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    while (true) {
      try {
        System.out.print("> ");
        System.out.flush();
        String line = in.readLine().toLowerCase();
        if (line.startsWith("quit") || line.startsWith("exit"))
          break;
        line = "[" + user_name + "] " + line;
        Message msg = new ObjectMessage(null, line);
        channel.send(msg);
      } catch (Exception e) {
      }
    }
  }

  public static void main(String[] args) throws Exception {
    new SimpleChat().start();
  }
}