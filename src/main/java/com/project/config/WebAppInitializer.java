package com.project.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] { HibernateConfig.class, GeneralConfig.class }; // your root beans
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { WebMvcConfig.class }; // MVC beans, view resolver etc.
    }

    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) { registration.setMultipartConfig(new MultipartConfigElement(System.getProperty("java.io.tmpdir"), 10_485_760, 20_971_520, 1_048_576)); }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" }; // handle all requests
    }
}

