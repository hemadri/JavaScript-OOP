/**
 * 
 * @author Hussein Al-Helal
 * 
 * The class is defined as Spring singleton bean.
 * The class server two purposes:
 * 1. Allow all objects in non-spring scope (such as servlets) to access spring beans. This is done by implementing the ApplicationContextAware.
 * 2. Load the log4j configuration
 */
package com.flexutil.shell.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SpringApplicationContext implements ApplicationContextAware {
	
	/**
	 * Holds a reference to the spring context
	 */
	private static ApplicationContext CONTEXT;
	
	/**
	 * Stores the log4j configuration path
	 */
	
	
	/**
	 * Called by the spring container to provide the spring context. The method also configures the logging.
	 */
	public void setApplicationContext(ApplicationContext context)
			throws BeansException {
		
		//1. saves the context
		CONTEXT = context;
		
	}
	
	/**
	 * returns the spring bean for the given name
	 * @param beanName
	 * @return spring bean
	 */
	public static Object getBean (String beanName) {
		return CONTEXT.getBean(beanName);
	}
	
	public static String getRemoteAddress () {
		return ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getRemoteAddr();
	}

	public static HttpSession getSession() {
		return ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
	}
}
