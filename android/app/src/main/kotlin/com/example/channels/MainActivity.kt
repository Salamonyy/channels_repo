package com.example.channels
import kotlin.random.Random
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.widget.Toast;


class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "channel").setMethodCallHandler {
      call, result ->
        if(call.method == "getRandomNumber") {
          val rand = Random.nextInt(100)
          result.success(rand)
        }
       else if(call.method == "helloWorld") {
        val text = call.argument<String>("text") // hello world
        Toast.makeText(getActivity(), text,
        Toast.LENGTH_LONG).show();
          result.success(text)
        }
        else {
          result.notImplemented()
        }
    }
  }
}