package com.aramco.rcd.database;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class ConnectionProperties  {
	Properties prop = new Properties();
	FileInputStream fis;
	 public ConnectionProperties(){
		 try{
		  fis = new FileInputStream("Connection.properties");
		  prop.load(fis);
		 }catch(IOException e){
		 }
	 }

	public String getOracleInstance(){
		String str = null; 
			   str = prop.getProperty("ORACLE_DB");
			   try {
			   fis.close();
		    } catch (IOException e) {
		    }
	  return str;
	}
	public String getDocumentumInstance(){
		String str = null;
			   str = prop.getProperty("DOCBASE");
			   try {
				fis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				
			}

		return str;
	}
	public String getSDEInstance(){
		String str = null;
		   str = prop.getProperty("SDE");
		   try {
			fis.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			
		}

	return str;
}
	 public String getOWInstance(){
			String str = null;
			   str = prop.getProperty("OW");
			   try {
				fis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				
			}

		return str;
	}
}
