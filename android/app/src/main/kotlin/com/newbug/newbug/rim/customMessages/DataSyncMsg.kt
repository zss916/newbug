package com.newbug.newbug.rim.customMessages
import android.os.Parcel
import android.os.Parcelable
import android.util.Log
import io.rong.common.ParcelUtils
import io.rong.imlib.MessageTag
import io.rong.message.MediaMessageContent
import org.json.JSONException
import org.json.JSONObject
import java.io.UnsupportedEncodingException

@MessageTag(value = MessageIdentifiers.datasyn, flag = MessageTag.STATUS)
class DataSyncMsg  : MediaMessageContent {
    // 自定义消息变量，可以有多个
    private var content: String? = null

    private constructor()

    /**
     * 设置文字消息的内容。
     *
     * @param content 文字消息的内容。
     */
    fun setContent(content: String?) {
        this.content = content
    }

    /**
     * 构造函数。
     *
     * @param in 初始化传入的 Parcel。
     */
    constructor(`in`: Parcel?) {
        extra = ParcelUtils.readFromParcel(`in`)
        setContent(ParcelUtils.readFromParcel(`in`))
    }

    /**
     * 创建 MyTextContent(byte[] data) 带有 byte[] 的构造方法用于解析消息内容.
     */
    constructor(data: ByteArray?) {
        if (data == null) {
            return
        }
        var jsonStr: String? = null
        try {
            jsonStr = String(data, Charsets.UTF_8)
        } catch (e: UnsupportedEncodingException) {
            Log.e(TAG, "UnsupportedEncodingException ", e)
        }
        if (jsonStr == null) {
            Log.e(TAG, "jsonStr is null ")
            return
        }
        try {
            val jsonObj = JSONObject(jsonStr)
            // 消息携带用户信息时, 自定义消息需添加下面代码
            if (jsonObj.has("user")) {
                userInfo = parseJsonToUserInfo(jsonObj.getJSONObject("user"))
            }
            // 用于群组聊天, 消息携带 @ 人信息时, 自定义消息需添加下面代码
            if (jsonObj.has("mentionedInfo")) {
                mentionedInfo = parseJsonToMentionInfo(jsonObj.getJSONObject("mentionedInfo"))
            }
            // 将所有自定义变量从收到的 json 解析并赋值
            if (jsonObj.has("content")) {
                content = jsonObj.optString("content")
                Log.e(TAG, "content: $content")
            }
        } catch (e: JSONException) {
            Log.e(TAG, "JSONException " + e.message)
        }
    }

    fun getContent(): String? {
        return content
    }

    /**
     * 将本地消息对象序列化为消息数据。
     *
     * @return 消息数据。
     */
    override fun encode(): ByteArray? {
        val jsonObj = JSONObject()
        try {
            // 消息携带用户信息时, 自定义消息需添加下面代码
            if (jsonUserInfo != null) {
                jsonObj.putOpt("user", jsonUserInfo)
            }
            // 用于群组聊天, 消息携带 @ 人信息时, 自定义消息需添加下面代码
            if (jsonMentionInfo != null) {
                jsonObj.putOpt("mentionedInfo", jsonMentionInfo)
            }
            //  将所有自定义消息的内容，都序列化至 json 对象中
            jsonObj.put("content", content)
        } catch (e: JSONException) {
            Log.e(TAG, "JSONException " + e.message)
        }
        try {
            return jsonObj.toString().toByteArray(charset("UTF-8"))
        } catch (e: UnsupportedEncodingException) {
            Log.e(TAG, "UnsupportedEncodingException ", e)
        }
        return null
    }

    override fun describeContents(): Int {
        return 0
    }

    override fun writeToParcel(dest: Parcel, i: Int) {
        // 对消息属性进行序列化，将类的数据写入外部提供的 Parcel 中
        ParcelUtils.writeToParcel(dest, extra)
        ParcelUtils.writeToParcel(dest, getContent())
    }

    companion object {
        private const val TAG = "PrivateAlbumMsg"

        // 快速构建消息对象方法
        fun obtain(content: String?): DataSyncMsg {
            val msg = DataSyncMsg()
            msg.content = content
            return msg
        }

        @JvmField
        val CREATOR: Parcelable.Creator<DataSyncMsg?> = object : Parcelable.Creator<DataSyncMsg?> {
            override fun createFromParcel(source: Parcel): DataSyncMsg? {
                return DataSyncMsg(source)
            }

            override fun newArray(size: Int): Array<DataSyncMsg?> {
                return arrayOfNulls(size)
            }
        }
    }
}