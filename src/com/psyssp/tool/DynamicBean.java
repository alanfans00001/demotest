package com.psyssp.tool;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import net.sf.cglib.beans.BeanGenerator;
import net.sf.cglib.beans.BeanMap;

/**
 * 动态生成bean
 * 2015年9月17日 上午10:38:19
 * 
 * @auther liuc
 */
public class DynamicBean {

	private Object object = null; //动态生成类
	private BeanMap beanMap = null; //存放属性名称以及属性的类型
	
	/**
	 * 得到实体bean对象
	 * 2015年9月17日 上午10:46:33
	 * 
	 * @auther liuc
	 * @return
	 */
	public Object getObject() {
		return object;
	}

	/**
	 * 给bean属性赋值
	 * 2015年9月17日 上午10:43:45
	 * 
	 * @auther liuc
	 * @param property
	 * @param value
	 */
	public void setValue(Object property,Object value){
		beanMap.put(property, value);
	}
	
	/**
	 * 通过属性名得到属性值
	 * 2015年9月17日 上午10:46:04
	 * 
	 * @auther liuc
	 * @param property
	 * @return
	 */
	public Object getValue(String property){
		return beanMap.get(property);
	}
	
	
	public DynamicBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public DynamicBean(Map propertyMap){
		this.object = generteBean(propertyMap);
		this.beanMap = BeanMap.create(this.object);
	}

	private Object generteBean(Map propertyMap) {
		BeanGenerator  generator = new BeanGenerator();
		Set keySet = propertyMap.keySet();
		for(Iterator i = keySet.iterator();i.hasNext();){
			String key = (String)i.next();
			generator.addProperty(key, (Class) propertyMap.get(key));
		}
		return generator.create();
	}
	
	
	public static void main(String[] args) throws Exception{
		Map propertyMap = new HashMap();
		propertyMap.put("id", Class.forName("java.lang.Long"));
		propertyMap.put("name", Class.forName("java.lang.String"));
		propertyMap.put("address", Class.forName("java.lang.String"));
		
		
		DynamicBean bean = new DynamicBean(propertyMap);
		
		bean.setValue("id", 1L);
		bean.setValue("name", "saf");
		bean.setValue("address","789");
		
		Object object = bean.getObject();
		Class clazz = object.getClass();
		Method[] methods = clazz.getDeclaredMethods();
		for(Method m : methods){
			System.out.println(m.getName());
		}
	}
}
