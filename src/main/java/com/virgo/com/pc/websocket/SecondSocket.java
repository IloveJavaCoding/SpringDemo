package com.virgo.com.pc.websocket;

import com.virgo.com.core.util.TextUtil;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 带标识（客户端唯一码）连接
 */
@ServerEndpoint("/secondsocket/{code}")
public class SecondSocket {
    //记录每个客户端的实例: 每人仅一个
    private static final ConcurrentHashMap<String, Session> webSocketMap = new ConcurrentHashMap<>();

    /**
     * 连接建立成功调用的方法
     * @param session 可选的参数 session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("code") String code) {
        if(TextUtil.isEmpty(code)){
            return;
        }

        System.out.println("有新客户端加入：" + code);
        if (!webSocketMap.containsKey(code)) {
            webSocketMap.put(code, session);
        } else {
            //已经存在则替换到最新
            webSocketMap.replace(code, session);
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        Map<String, String> map = session.getPathParameters();
        String code = map.get("code");
        if (!TextUtil.isEmpty(code) || webSocketMap.containsKey(code)) {
            //如该客户端存在则移除
            webSocketMap.remove(code);
            System.out.println("客户端 " + code + " 已离线！");
        }
    }

    /**
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        Map<String, String> map = session.getPathParameters();
        String code = map.get("code");
        System.out.println("客户端 " + code + "：" + message);
    }

    /**
     * 发生错误时调用
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        Map<String, String> map = session.getPathParameters();
        String code = map.get("code");
        System.out.println("发生异常,:" + code +",断开连接!\n");
        webSocketMap.remove(code);
    }

    /**
     * 服务器发送给客户端的信息
     * @param code 目标客户端标识
     * @param message 要发送的信息
     */
    public static void sendMessage(String code, String message){
        if (webSocketMap.containsKey(code)) {
            Session session = webSocketMap.get(code);
            if(session!=null){
                try {
                    RemoteEndpoint.Async remoteEndpoint = session.getAsyncRemote();
                    remoteEndpoint.sendText(message);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
