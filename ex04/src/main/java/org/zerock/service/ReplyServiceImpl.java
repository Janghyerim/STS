package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;  //하나만 쓸때는 단일 생성자라 자동주입이 되지만 2개 이상일 경우, @Setter메소드를 써줘야함.
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {  //새로운 댓글등록
		
		log.info("register....." + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);  //vo.getBno() : 원글 정보를 가져옴  / 글 등록할때는 1로 증가시키고, 글 삭제는 -1로 감소시킨다.
		
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get....." + rno);
		
		return mapper.read(rno);
	}
	
	
	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify....." + vo);
		
		return mapper.update(vo);
	}
	
	
	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove....." + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);  //vo.getBno() : 원글 정보를 가져옴  / 글 등록할때는 1로 증가시키고, 글 삭제는 -1로 감소시킨다.
		
		return mapper.delete(rno);
	}
	
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {  //전체댓글목록 + 페이징처리
		
		log.info("get Reply List of a Board " + bno);
		
		return mapper.getListWithPaging(cri, bno);	
	}
}
