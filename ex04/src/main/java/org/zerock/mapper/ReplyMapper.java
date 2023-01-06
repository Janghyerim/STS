package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	//등록(Create)
	/* 추상메소드 등록 */
	public int insert(ReplyVO vo);
	
	//조회(Read)
	//특정 댓글 읽기
	public ReplyVO read(Long rno);
	
	//삭제(Delete)
	//wrapper클래스 사용 해도 정수로 반환되기 때문에 무방하다.
	public int delete(Long rno);
	
	//수정(Update)
	public int update(ReplyVO reply);
	
	
	//페이징 처리와 댓글의 목록  / Mybatis의  SQL문장에 다수의 파라미터를 전달 할 때는 전달되는 변수들에 꼭 @Param 어노테이션을 붙여줘야 한다.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno") Long bno);
	
}
