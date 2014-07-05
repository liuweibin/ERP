package com.erp.core.web.util;

import java.util.Comparator;

import com.erp.core.model.AgentsUserTbl;


/**
 * 
 * @author hwg
 *
 */
public class FieldComparator implements Comparator{

	@Override
	public int compare(Object o1, Object o2) {
		AgentsUserTbl f1 = (AgentsUserTbl) o1;
		AgentsUserTbl f2 = (AgentsUserTbl) o2;
		 //int flag=f1.getId().compareTo(f2.getId());
		 if(f1.getId()>f2.getId()){
			 return 1;
		 }
		 else{
			 return -1;
		 }
	}

}
