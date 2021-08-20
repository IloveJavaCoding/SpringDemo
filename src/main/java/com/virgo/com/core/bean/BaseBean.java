package com.virgo.com.core.bean;

import net.sf.json.JSONObject;

import java.io.Serializable;

public class BaseBean implements Serializable {
    private static final long serialVersionUID = 1L;

    public BaseBean() {
    }

    public String toJson(){
        JSONObject jsonObject = JSONObject.fromObject(this);
        return jsonObject.toString();
    }
}
