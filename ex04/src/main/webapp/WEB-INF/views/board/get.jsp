<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">Board Read</h1>  <!-- 상세보기 -->
   </div>
   <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default">
         <div class="panel-heading">Board Read Page</div>
         <div class="panel-body">
            <div class="form-group">
               <label>Bno</label> <input class="form-control" name="bno"
                  value='<c:out value="${ board.bno }" />' readonly="readonly" />
            </div>

            <div class="form-group">
               <label>Title</label> <input class="form-control" name="title"
                  value='<c:out value="${ board.title }" />' readonly="readonly" />
            </div>

            <div class="form-group">
               <label>Text area</label>
               <textarea class="form-control" rows="3" name="content"
                  readonly="readonly"><c:out value="${ board.content }" />
                  </textarea>
            </div>

            <div class="form-group">
               <label>Writer</label> <input class="form-control" name="writer"
                  value='<c:out value="${ board.writer }" />' readonly="readonly" />
            </div>
            <button data-oper='modify' class="btn btn-default">Modify</button>
            <button data-oper='list' class="btn btn-info">List</button>
            
            <form id="operForm" action="/board/modify" method="get">
               <input type="hidden" id="bno" name="bno" value='<c:out value="${ board.bno }" />'>
               <input type="hidden" name="pageNum" value='<c:out value="${ cri.pageNum }" />'>
               <input type="hidden" name="amount" value='<c:out value="${ cri.amount }" />'>
               <!-- 추가 -->
               <input type="hidden" name="keyword" value='<c:out value="${ cri.keyword }" />'>
               <input type="hidden" name="type" value='<c:out value="${ cri.type }" />'>
               
            </form>
         </div>
         <!-- end panel-body -->
      </div>
      <!-- end panel-body -->
   </div>
   <!--end col-12 -->
</div>
<!-- /.row -->

<div class='row'>
	<div class="col-lg-12">
		
		<!-- /.panel -->
		<div class="panel panel-default">
			<!-- <div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
			</div> -->
			
			<!-- 새로운 댓글처리 -->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
				
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2023-01-01 13:13</small>
							</div>
							<p>Good Job!</p>
						</div>
					</li>
					<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- ./panel .chat-panel -->
		</div>
	</div>
	<!-- ./end row -->
</div>

<!-- Modal Start -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name='reply' value='New Reply!!!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name='replyer' value='replyer'>
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name='replyDate' value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- ./modal-content -->
	</div>
	<!-- ./modal-dialog -->
</div>
<!-- ./modal end -->

<!-- reply.js 파일 추가 -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>  /* 댓글 순번대로 아래쪽으로 나오게 하는 코드 */
	$(document).ready(function(){
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			replyService.getList({bno:bnoValue,page: page|| 1}, function(list){
				
				var str="";
				if(list ==null ||list.length == 0){
					replyUL.html("");
					
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += " <div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
					str += " <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) +"</small></div>";
					str += "    <p>" + list[i].reply + "</p></div></li>";
				}
				replyUL.html(str);
			}); //end function
		} //end showList
		
		/* 새로운 댓글의 추가버튼 이벤트처리 */
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		//modal창 close버튼 실행 시 모달창 닫는 구문
		$("#modalCloseBtn").on("click", function(e){
			modal.modal('hide');
		});
		
		
		//모달창 띄우는 버튼 이벤트 처리
		$("#addReplyBtn").on("click", function(e){	
			
			//버튼4개 모달창에 나오는 부분
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			//모달 창 띄우는 스크립트
			$(".modal").modal("show");
		});
		
		//새로운 댓글 추가 처리
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
			
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				//목록 자동갱신되어 새로 등록한 글이 바로 보여지는 기능
				showList(1);
			});
		});
		
		//댓글 클릭 이벤트 처리 p.426
		//댓글 조회 클릭 이벤트 처리
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply){
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		//댓글의 수정/삭제 이벤트 처리
		//댓글의 수정
		modalModBtn.on("click", function(e){
			
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			
			replyService.update(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		//댓글의 삭제
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
	}); 

</script>

<script type="text/javascript">
	console.log("=================");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	//for replyService add test
	/* replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue},
		function(result){
			alert("RESULT : " + result);
		} 
	);*/
	
	/* 조회 추가  - 해당 게시물의 모든 댓글을 가져오는지 확인 하는 코드 */
	/* replyService.getList({bno:bnoValue, page:1}, function(list){
	
		for(var i=0, len = list.length||0; i<len; i++ ){
			console.log(list[i]);
		} */
	
		
	/* 8번 댓글 삭제 테스트 추가 */
	/* replyService.remove(8, function(count){
		
		console.log(count);
		
		if(count === "success"){
			alert("REMOVED");
		}
	},function(err){
		alert("ERROR.............");
	}); */
		
	
	/* 15번 댓글 수정 추가 */
	/* replyService.update({
		
		rno : 15,
		bno : bnoValue,
		reply: "Modified Reply.........."
	}, function(result){
		alert("수정 완료....");
	}); */
	
	
	/* 댓글의 번호만 전달 */
	replyService.get(10, function(data){
		console.log(data);
	});
	
</script>

<script type="text/javascript">
	$(document).ready(function(){
	   let operForm = $("#operForm"); // 폼 객체 받아오기. 
	   $("button[data-oper='modify']").on("click", function(e){
	      operForm.attr("action","/board/modify").submit();
	   });
	   
	   $("button[data-oper='list']").on("click", function(e){
	      operForm.find("#bno").remove(); // 클라이언트가 list로 이동하는 경우에는 특정 번호가 필요하지 않으므로 form 태그 내의 bno태그를 지운다.
	      operForm.attr("action", "/board/list")
	      operForm.submit();
	   });
	});
</script>


<%@ include file="../includes/footer.jsp" %>