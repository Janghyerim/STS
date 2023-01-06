package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria { //커맨드객체
	private int pageNum; // 페이지 번호
	private int amount; // 한 페이지당 몇 개의 데이터를 보여줄 것인지
	
	/* 추가 */
	private String type; /* 검색조건 */
	private String keyword; 
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	/* 추가 */
	public String[] getTypeArr() {  //getTypeArr() : MyBatis의 동적태그를 활용하기 위함
		
		return type == null ? new String[] {} : type.split(""); /* .split() : 자르는 작업 */
	}
}
