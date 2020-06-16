package native_code;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.Intent;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "heartbeat.fritz.ai/native";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler((call, result) -> {
          if (call.method.equals("takePhoto")) {
            readyCamera();
        

          }

        });
  }
  public void readyCamera() {
    //Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
      Intent intent = new Intent(MainActivity.this, camera.MainActivity.class);
    startActivity(intent);
 
 
  }
}