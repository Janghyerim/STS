package org.zerock.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample1Mapper {
	
	//mybatis를 실행하지 않고도 @insert어노테이션을 걸고 인터페이스에 쿼리문 작성이 가능하다.
	@Insert("insert into tbl_sample1 (col1) values (#{data}) ")
	public int insertCol1(String data);
	
}
