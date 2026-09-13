import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class Duke extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        Label helloWorldLabel = new Label("Hello World!");
        Scene scene = new Scene(helloWorldLabel);

        stage.setScene(scene);
        stage.show();
    }
}
