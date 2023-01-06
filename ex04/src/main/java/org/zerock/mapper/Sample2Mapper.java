package org.zerock.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample2Mapper {
	
	//mybatis를 실행하지 않고도 @insert어노테이션을 걸고 인터페이스에 쿼리문 작성이 가능하다.
	@Insert("insert into tbl_sample2 (col2) values (#{data})" )
	public int insertCol2(String data);
	//쿼리문 실행 시 메소드(insertCol2(String data);)를 이용하여 실행한다
}
