package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;//댓글 번호
	private Long bno;//원글 번호
	
	private String reply;
	private String replyer;
	
	private Date replyDate;
	private Date updateDate;
}
