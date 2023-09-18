package com.example.flutter_add_to_app.host;

import androidx.annotation.NonNull;
import android.os.Looper;
import android.os.Handler;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {

    private static String CHANNEL = "isMyVCPresented";
    private static String CHANNEL2 = "isMyVCPresented2";
    

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        MethodChannel methodChannel2 = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL2);
        // Delay for 2 seconds and then send the message to Flutter
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                methodChannel2.invokeMethod("messageFromAndroid", "Hello from Android!");
            }
        }, 2000);

        final Handler handler1 = new Handler(Looper.getMainLooper());
        handler1.postDelayed(new Runnable() {
            @Override
            public void run() {
                methodChannel.invokeMethod("messageFromAndroid2", "Hello from Android! - second object");
            }
        }, 5000);
        // Handler(Looper.getMainLooper()).postDelayed({
        //     methodChannel2.invokeMethod("messageFromAndroid", "Hello from Android!");
        // }, 2000);
        // Handler(Looper.getMainLooper()).postDelayed({
        //     methodChannel.invokeMethod("messageFromAndroid2", "Hello from Android! - second object");
        // }, 5000);
    }

}
