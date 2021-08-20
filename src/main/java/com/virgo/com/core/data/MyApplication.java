package com.virgo.com.core.data;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class MyApplication implements ApplicationContextAware, DisposableBean {
    private static ApplicationContext context = null;

    public static ApplicationContext getApplicationContext() {
        //"applicaitonContext属性未注入, 请在applicationContext.xml中定义MyApplication.");
        return context;
    }

    //从静态变量applicationContext中取得Bean, 自动转型为所赋值对象的类型.
    public static <T> T getBean(String name){
        return (T) context.getBean(name);
    }

    //从静态变量applicationContext中取得Bean, 自动转型为所赋值对象的类型.
    public static <T> T getBean(Class<T> requiredType) {
        return context.getBean(requiredType);
    }

    @Override
    public void destroy() throws Exception {
        MyApplication.clearHolder();
    }

    public static void clearHolder() {
        context = null;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        MyApplication.context = applicationContext;
    }

}
