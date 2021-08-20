package com.virgo.com.core.util;

import com.virgo.com.core.interfaces.ObjectSwitchHelper;
import org.apache.commons.io.IOUtils;

import java.io.*;
import java.net.URISyntaxException;
import java.util.Map;
import java.util.Properties;

public class PropertiesUtil extends ObjectSwitchHelper {
	private Properties properties;
	private String[] resourcesPaths;
	private String properiesName = "";

	public static PropertiesUtil create(String... resourcesPaths) {
		return new PropertiesUtil(resourcesPaths);
	}

	public PropertiesUtil(String... resourcesPaths) {
		load(resourcesPaths);
	}

	public void load(String... resourcesPaths) {
		this.resourcesPaths = resourcesPaths;
		properties = new Properties();
		for (String location : resourcesPaths) {
			InputStream is = null;
			try {
				is = new FileInputStream(getAbsolutePath(location));
				properties.load(is);
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				IOUtils.closeQuietly(is);
			}
		}
	}

	/**
	 * 更新与删除时指定文件名称
	 * 
	 * @param properiesName
	 */
	public void setOptProperiesName(String properiesName) {
		this.properiesName = properiesName;
	}

	@Override
	public Object get(String key) {
		if (properties.containsKey(key)) {
			return properties.getProperty(key);
		}
		return "";
	}

	public String getAbsolutePath(String filename) throws URISyntaxException {
		if (!FileUtil.isAbsolutePath(filename)) {
			filename = PropertiesUtil.class.getClassLoader().getResource(filename).toURI().getPath();
		}
		return filename;
	}

	@Override
	public void set(String key, Object value) {
		if (TextUtil.isEmpty(this.properiesName)) {
			this.properiesName = this.resourcesPaths[0];
		}
		InputStream is = null;
		OutputStream os = null;
		Properties p = new Properties();
		try {
			FileUtil.createFile(getAbsolutePath(this.properiesName));
			is = new FileInputStream(getAbsolutePath(this.properiesName));
			p.load(is);
			os = new FileOutputStream(getAbsolutePath(this.properiesName));
			p.setProperty(key, value + "");
			p.store(os, "====配置更新====");
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(is);
			IOUtils.closeQuietly(os);
		}
		this.properiesName = "";
	}
	
	public void set(Map<String, Object> dataMap) {
		if (TextUtil.isEmpty(this.properiesName)) {
			this.properiesName = this.resourcesPaths[0];
		}
		InputStream is = null;
		OutputStream os = null;
		Properties p = new Properties();
		try {
			FileUtil.createFile(getAbsolutePath(this.properiesName));
			is = new FileInputStream(getAbsolutePath(this.properiesName));
			p.load(is);
			os = new FileOutputStream(getAbsolutePath(this.properiesName));
			for (Map.Entry<String, Object> entry : dataMap.entrySet()) {
				p.setProperty(entry.getKey(), entry.getValue() + "");
			}
			p.store(os, "====配置更新====");
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(is);
			IOUtils.closeQuietly(os);
		}
		this.properiesName = "";
	}

	@Override
	public boolean remove(String key) {
		if (TextUtil.isEmpty(this.properiesName)) {
			this.properiesName = this.resourcesPaths[0];
		}
		InputStream is = null;
		OutputStream os = null;
		Properties p = new Properties();
		try {
			is = new FileInputStream(getAbsolutePath(this.properiesName));
			p.load(is);
			os = new FileOutputStream(getAbsolutePath(this.properiesName));
			p.remove(key);
			p.store(os, "");
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(is);
			IOUtils.closeQuietly(os);
		}
		this.properiesName = "";
		return false;
	}
}
