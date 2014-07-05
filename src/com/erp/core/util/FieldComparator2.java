package com.erp.core.util;

import java.util.Comparator;

import com.erp.core.model.AgentsResourceTbl;


/**
 * 
 * @author hwg
 *
 */
public class FieldComparator2 implements Comparator{

	@Override
	public int compare(Object o1, Object o2) {
		AgentsResourceTbl f1 = (AgentsResourceTbl) o1;
		AgentsResourceTbl f2 = (AgentsResourceTbl) o2;
		 //int flag=f1.getId().compareTo(f2.getId());
		 if(f1.getId()>f2.getId()){
			 return 1;
		 }
		 else{
			 return -1;
		 }
	}
	
}

