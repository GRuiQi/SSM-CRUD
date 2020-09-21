package com.atguigu.crud.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ServerStartupListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        /*
        * 将Web应用名称路径保存到application范围中
        * ${pageContext.request.contextPath}
        * */
        ServletContext application = sce.getServletContext();
        String  path = application.getContextPath();
        System.out.println("application.getContextPath() : "+path);
        application.setAttribute("APP_PATH",path);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
