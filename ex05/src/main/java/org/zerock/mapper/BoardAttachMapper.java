package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	 public void insert (BoardAttachVO vo);
	 public void delete (String uuid);
	 public List<BoardAttachVO> findByBno(Long bno);
	 //게시물의 삭제와 첨부파일
	 public void deleteAll(Long bno);
	 
	 public List<BoardAttachVO> getOldFiles(); 
}
