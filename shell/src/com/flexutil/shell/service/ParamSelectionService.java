package com.flexutil.shell.service;

import com.flexutil.shell.entity.common.ParamSelectionPackage;

public class ParamSelectionService {//extends LookupFactoryServiceHelper{
	private static final long serialVersionUID = 4644061491004655141L;
	
	private ParamSelectionPackage psPackage;
	
		
	public ParamSelectionPackage getHeaderData(String menuOperation) throws Exception {
		psPackage = new ParamSelectionPackage();
		psPackage.setMenuOperation(menuOperation);
		
		/*if (menuOperation.equalsIgnoreCase(IParamMenu.PREWAP_WELL)) {
			psPackage.setWellNameList(this.getLookupFactory().getPreWAPWellList());
		}*/ 
		
		return psPackage;
	}
}
