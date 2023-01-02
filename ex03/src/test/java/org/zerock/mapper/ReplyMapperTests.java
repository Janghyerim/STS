package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java Config
//@ContextConfiguration(classes = {org.zerock.config.RootConfig.class
// })
@Log4j
public class ReplyMapperTests {
	
	//테스트 전에 해당 번호의 게시물이 존재하는지 반드시 확인 할 것.
	private Long[] bnoArr = {458768L, 458766L, 458765L, 458764L, 458763L};
	
	@Setter(onMethod_ = @Autowired) 
	private ReplyMapper mapper;
	
//	@Test  //오라클 디비 정보 등록 건
//	public void testCreate() {
//		IntStream.rangeClosed(1,10).forEach(i -> {
//			
//			ReplyVO vo = new ReplyVO();
//			
//			//게시물의 번호
//			vo.setBno(bnoArr[i % 5]);
//			vo.setReply("댓글 테스트" + i);
//			vo.setReplyer("replyer" + i);
//			
//			mapper.insert(vo);
//		});
//	}
	
//	@Test //조회 건
//	public void testRead() {
//		
//		Long targetRno = 5L;
//		
//		ReplyVO vo = mapper.read(targetRno);
//		
//		log.info(vo);
//	}
	
//	@Test //삭제 건
//	public void testDelete() {
//		
//		Long targetRno = 2L;
//		
//		mapper.delete(targetRno);
//	}
	
	
//	@Test //수정 건
//	public void testUpdate() {
//		
//		Long targetRno = 10L;
//		
//		ReplyVO vo = mapper.read(targetRno);
//		
//		//수정할 Reply정보를 vo에서 불러와서 ("Update Reply ");로 변경하는 구문
//		vo.setReply("Update Reply ");
//		
//		//업데이트 할때마다 카운트
//		int count = mapper.update(vo);
//		
//		//UPDATE COUNT : 1 출력
//		log.info("UPDATE COUNT : " + count);
//				
//	}
	
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		
		//458768L                                             원글 번호 위에 배열 [0]번째
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
//	@Test
//	public void testMapper() {
//		
//		log.info(mapper);
//	}
	
}
