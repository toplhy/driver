package com.lhy.driver.utils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

/**
 * Created by lhy on 2017/4/14.
 */
public class TemplateToHtml {

    /**
     * 将数据通过模板转化为html字符串
     * @param template
     * @param dataMap
     * @param request
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    public static String toHtml(String template, Map dataMap, HttpServletRequest request) throws IOException, TemplateException {
        Configuration configuration = new Configuration();
        configuration.setDefaultEncoding("UTF-8");
        configuration.setServletContextForTemplateLoading(request.getServletContext(),"/static/templates");
        Template t = configuration.getTemplate(template);
        StringWriter stringWriter = new StringWriter();
        BufferedWriter writer = new BufferedWriter(stringWriter);
        t.setEncoding("UTF-8");
        t.process(dataMap, writer);
        String htmlStr = stringWriter.toString();
        writer.flush();
        writer.close();
        return htmlStr;
    }
}
