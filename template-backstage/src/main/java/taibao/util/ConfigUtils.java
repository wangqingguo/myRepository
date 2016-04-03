package com.weitu.permission.util;

import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.weitu.permission.annotation.TableSeg;

public class ConfigUtils {
	private final Logger logger = Logger.getLogger(ConfigUtils.class);
	/**
	 * 初始化数据库表字段到缓存
	 */
	public void initTableField() {
		// 记录总记录数
		Statement countStmt = null;
		ResultSet rs = null;
		Connection connection = null; // 表示数据库的连接对象
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Properties pro = PropertiesUtils.getjdbcProperties();
			Class.forName(pro.getProperty("jdbc.driverClass")); // 1、使用CLASS
			String url = pro.getProperty("jdbc.url");
			String db = url.substring(url.lastIndexOf("/")+1);
			if(db.indexOf("?")>-1){
				db=db.substring(0, db.indexOf("?"));
			}
			connection = DriverManager.getConnection(url, pro.getProperty("jdbc.username"),
					pro.getProperty("jdbc.password")); // 2、连接数据库
			//String packageName = "com.weitu.permission.entity";
			///查找平台中的类
			String packageName = "com.weitu.permission.entity";
			List<String> classNames = ClassUtil.getClassName(packageName, false);
			String tabs = "";
			if (classNames != null) {
				for (String className : classNames) {
					Class<?> clazz = Class.forName(className);
					boolean flag = clazz.isAnnotationPresent(TableSeg.class); // 某个类是不是存在TableSeg注解
					if (flag) {
						TableSeg table = (TableSeg) clazz.getAnnotation(TableSeg.class);
						tabs+="'"+table.tableName()+"',";
						map.put(table.tableName(), table.id());
					} 
				}
			}
			//查询com.weitu下所有文件夹
			List<String> classNamesQT =new ArrayList<String>();
			ClassLoader loader = Thread.currentThread().getContextClassLoader();
			String packagePath = packageName.replace(".", "/");
			URL url2 = loader.getResource("com/weitu");
			if (url != null) {
				String type = url2.getProtocol();
				if (type.equals("file")) {
					File file = new File(url2.getPath());
					File[] childFiles = file.listFiles();
					if(childFiles!=null&&childFiles.length>0){
						for(File f:childFiles){
							String fff=f.getPath();
							fff=fff.substring(fff.indexOf("com\\weitu\\"));
							if(fff!=null&&!"".equals(fff)){
								String packPath=fff.replace("\\", ".");
								System.out.println(packPath+".entity");
								List<String> classNamesChild = ClassUtil.getClassName(packPath+".entity", false);
								classNamesQT.addAll(classNamesChild);
							}
							
						}
					}
				}
			}
			// List<String> classNames = getClassName(packageName);
			//List<String> classNames = ClassUtil.getClassName(packageName, false);
			if (classNamesQT != null) {
				for (String className : classNamesQT) {
					Class<?> clazz = Class.forName(className);
					boolean flag = clazz.isAnnotationPresent(TableSeg.class); // 某个类是不是存在TableSeg注解
					if (flag) {
						TableSeg table = (TableSeg) clazz.getAnnotation(TableSeg.class);
						tabs+="'"+table.tableName()+"',";
						map.put(table.tableName(), table.id());
					} 
				}
			}
			tabs=Common.trimComma(tabs);
			//尽量减少对数据库/IO流操作,一次查询所有表的的字段
			String sql = "select TABLE_NAME,dbo.basepermission_table_colum_join(TABLE_NAME,'dbo') COLUMN_NAME from information_schema.columns where table_name in ("+tabs+") and table_schema = 'dbo'  GROUP BY TABLE_NAME" ;
			countStmt = connection.createStatement();
			rs = countStmt.executeQuery(sql);
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("field", rs.getString("COLUMN_NAME"));
				String ble =rs.getString("TABLE_NAME");//表名
				m.put("column_key", map.get(ble));//获取表的主键
				EhcacheUtils.put(ble, m);//某表对应的主键和字段放到缓存
			}
		} catch (Exception e) {
			logger.error(" 初始化数据失败,没法加载表字段到缓存 -->> "+e.fillInStackTrace());
			e.printStackTrace();
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
			}
			try {
				countStmt.close();
			} catch (Exception e) {
			}
		}
	}
}
