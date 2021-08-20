package com.virgo.com.core.bean;

import com.virgo.com.core.util.LogUtil;
import net.sf.json.JSONObject;

/**
 * http 请求返回值
 */
public class Response {
    private static final String TAG = "Response";

    private static final String KEY_CODE = "code";//状态
    private static final String KEY_DATA = "data";//数据
    private static final String KEY_MESSAGE = "msg";

    public static final String CODE_ERROR = "ERROR";
    public static final String CODE_SUCCESS = "SUCCESS";

    //error type

    private static JSONObject toJson(String  code, String msg, Object data){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put(KEY_CODE, code);
        if(data != null){
            jsonObject.put(KEY_DATA, data);
        }
        jsonObject.put(KEY_MESSAGE, msg);

        LogUtil.debug(jsonObject.toString());
        return jsonObject;
    }


    public static JSONObject success(String msg) {
        return toJson(CODE_SUCCESS, msg, null);
    }

    public static JSONObject success(String msg, Object data) {
        return toJson(CODE_SUCCESS, msg, data);
    }

    public static JSONObject fail(String message) {
        return toJson(CODE_ERROR, message,null);
    }

    public static JSONObject fail(String message, Object data) {
        return toJson(CODE_ERROR, message,data);
    }
}
