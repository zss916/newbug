
package com.newbug.newbug.rim

import io.flutter.embedding.engine.FlutterEngine
import cn.rongcloud.im.wrapper.flutter.RCIMWrapperPlugin
import com.newbug.newbug.rim.customMessages.ConnectionMsg
import com.newbug.newbug.rim.customMessages.DataSyncMsg
import com.newbug.newbug.rim.customMessages.PrivateAlbumMsg
import com.newbug.newbug.rim.customMessages.PrivateMultipleMsg
import com.newbug.newbug.rim.customMessages.PublicAlbumMsg
import com.newbug.newbug.rim.customMessages.SystemActionMsg
import com.newbug.newbug.rim.customMessages.SystemTipMsg

class ImManager constructor() {

    companion object {
        val instance: ImManager by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { ImManager() }
    }

    fun initIM() {

    }


    /**
     * 注册自定义消息类型
     */
    fun addMsgContent(flutterEngine: FlutterEngine?) {
        val plugin = flutterEngine?.plugins?.get(RCIMWrapperPlugin::class.java) as RCIMWrapperPlugin
        // 给 messageContentClassList 添加注册类
        plugin.engine.messageContentClassList.add(ConnectionMsg::class.java)
        plugin.engine.messageContentClassList.add(SystemActionMsg::class.java)
        plugin.engine.messageContentClassList.add(DataSyncMsg::class.java)
        plugin.engine.messageContentClassList.add(PrivateAlbumMsg::class.java)
        plugin.engine.messageContentClassList.add(PrivateMultipleMsg::class.java)
        plugin.engine.messageContentClassList.add(PublicAlbumMsg::class.java)
        plugin.engine.messageContentClassList.add(SystemTipMsg::class.java)
    }
}