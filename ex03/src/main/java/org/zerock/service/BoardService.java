package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService { 
	public void register(BoardVO board); // 글을 등록하는 역할
	
	public BoardVO get(Long bno); 
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
//	public List<BoardVO> getList(); // 전체 목록 조회
	
	public List<BoardVO> getList(Criteria cri);
	
	/* 추가 */         /* Criteria cri : 검색조건 추가할건데 검색조건을 Criteria에 넣어줄 것이기 때문에 */
	public int getTotal(Criteria cri);
}
