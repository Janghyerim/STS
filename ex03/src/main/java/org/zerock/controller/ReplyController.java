package org.zerock.controller;


import java.util.List;


import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	/* JSON형식으로 url을 보내라는 뜻 */
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
											/* ReplyVO의 형변환 */
		
		log.info("ReplyVO : " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)  //200
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); //500
		//삼항 연산자 처리
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", 
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno) {
		
		log.info("getList.........");
		
		Criteria cri = new Criteria(page,10);
		
		log.info(cri);
		
		return new ResponseEntity<>(service.getList(cri,bno), HttpStatus.OK);
	}
	
	//댓글 조회 get
	@GetMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		
		log.info("get : " + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	//댓글 삭제 delete //value = "/{rno}" : 위와 같은 주소값으로는 구분이 안된다.
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		
		log.info("remove : " + rno);
		
		return service.remove(rno) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정 modify
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
			value = "/{rno}", 
			consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
						@RequestBody ReplyVO vo,
						@PathVariable("rno") Long rno){
		vo.setRno(rno);
		
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
			
			
}
