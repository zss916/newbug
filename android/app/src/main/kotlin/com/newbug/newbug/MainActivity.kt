package com.newbug.newbug
import com.newbug.newbug.rim.ImManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ImManager.instance.addMsgContent(flutterEngine)
    }
}
