package org.zerock.service;

import org.springframework.stereotype.Service;

@Service
public class SampleServiceImpl implements SampleService {  //Service 계층 설계

	@Override
	public Integer doAdd(String str1, String str2) throws Exception { //aop가 적용되고 나면 옆 라인에 아이콘 생성이 됨.
		
		return Integer.parseInt(str1) + Integer.parseInt(str2);
		
	}

}
