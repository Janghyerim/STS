package org.zerock.aop;

import java.util.Arrays;

import org.apache.ibatis.logging.LogException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect 
@Log4j
@Component //AOP와는 관련이 없지만, 스프링에서 bean으로 인식하기 위해 사용
public class LogAdvice {
	
	//약속된 기호를 가지고 대상 advice에 지정하는 것. SampleService에 있는 모든 클래스의 모든 메소드의 매개변수가 있던없던 상관없이 모든 대상을 pointcut하겠다.
	//AOP정규식표현법 참고.
	@Before( "execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("===================================");
	}
	
	
	@Before( "execution(* org.zerock.service.SampleService*.doAdd(String,String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
		
	}
	
	
//	//@AfterThrowing : 지정된 대상이 예외를 발생한 후에 동작하면서 문제를 찾을 수 있게 도와주는 코드
//	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing = "exception")
//	public void logException(Exception exception) {
//		
//		log.info("Exception.....!!!!!!!!");
//		log.info("exception: " + exception);
//		
//	}
	

	//@Around : 직접 대상 메소드를 실행할 수 있는 권한이 있고, 메소드의 실행 전과 후에 처리가 가능
	@Around( "execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime( ProceedingJoinPoint pjp) {
		
		long start = System.currentTimeMillis();
		
		log.info("Target : " + pjp.getTarget());
		log.info("Param : " + Arrays.toString(pjp.getArgs()));
		
		//invoke method @Around어노테이션 쓰려면 하기 구문은 반드시 작성되야 하는 기본 코드이다.
		Object result = null;
		
		try {
			result = pjp.proceed();
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		log.info("TIME : " + (end - start));
		
		return result;
		
	}
	
	@After( "execution(* org.zerock.service.SampleService*.*(..))")
	public void logAfter() {
		
		log.info("================================end");
		
	}
}
