package com.virgo.com.core.bean;

import com.virgo.com.core.util.LogUtil;
import com.virgo.com.pc.bean.BaseEntity;
import com.virgo.com.pc.entity.Miniofile;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

//用于返回grid table json数据
public class GridResponse {
    public final static int SUCCESS = 0;
    public final static int FAIL = -1;

    private static final String KEY_CODE = "code";//状态
    private static final String KEY_MESSAGE = "msg";
    private static final String KEY_DATA = "data";//数据
    public static final String KEY_ID = "id";//行id
    public static final String KEY_CELL= "cell";//当前行的所有单元格
    private static final String KEY_TOTAL = "total";//总页数
    private static final String KEY_PAGE = "page";//当前页
    private static final String KEY_RECORDS = "records";//查询出的记录数

    private final LinkedHashMap<String, Object> hashMap;// 扩展数据

    public GridResponse() {
        hashMap = new LinkedHashMap<>();
    }

    public void put(String key, Object value) {
        hashMap.put(key, value);
    }

    public void remove(String key) {
        hashMap.remove(key);
    }

    public void success(String msg) {
        put(KEY_MESSAGE, msg);
        put(KEY_CODE, SUCCESS);
    }

    public void fail(String msg) {
        put(KEY_MESSAGE, msg);
        put(KEY_CODE, FAIL);
    }

    public void setPage(int page) {
        put(KEY_PAGE, String.valueOf(page));
    }

    public void setTotal(int total) {
        put(KEY_TOTAL, String.valueOf(total));
    }

    public void setRecords(int records) {
        put(KEY_RECORDS, String.valueOf(records));
    }

    public void setData(Object data) {
        put(KEY_DATA, data);
    }

    public void setData2(List<Miniofile> list) {
        JSONArray array = new JSONArray();
        for (BaseEntity file: list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(GridResponse.KEY_ID, String.valueOf(file.getRowId()));
            JSONObject object = JSONObject.fromObject(file);
            jsonObject.put(GridResponse.KEY_CELL, object);
            array.add(jsonObject);
        }
        put(KEY_DATA, array);
    }

    public JSONObject toJson(){
        JSONObject jsonObject = new JSONObject();
        Iterator iterator = hashMap.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry next = (Map.Entry) iterator.next();
            jsonObject.put(next.getKey(), next.getValue());
        }

        LogUtil.debug(jsonObject.toString());
        return jsonObject;
    }
}
