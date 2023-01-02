<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@include file="../includes/header.jsp"%>
<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">Tables</h1>
   </div>
   <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default">
         <div class="panel-heading">
            Board List Page
            <button id='regBtn' type="button" class="btn btn-xs pull-right">Register
               New Board</button>
         </div>

         <!-- /.panel-heading -->
         <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
               <thead>
                  <tr>
                     <th>#번호</th>
                     <th>제목</th>
                     <th>작성자</th>
                     <th>작성일</th>
                     <th>수정일</th>
                  </tr>
               </thead>

               <c:forEach items="${list}" var="board">
                  <tr>
                     <td><c:out value="${board.bno}" /></td>
                     <!-- p.314 수정 -->
                     <%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>  --%>
                     <td><a class='move' href='<c:out value="${board.bno }" />'><c:out value="${board.title }" /></a></td>
                     <td><c:out value="${board.writer}" /></td>
                     <td><fmt:formatDate pattern="yyyy-MM-dd"
                           value="${board.regdate}" /></td>
                     <td><fmt:formatDate pattern="yyyy-MM-dd"
                           value="${board.updateDate}" /></td>
                  </tr>
               </c:forEach>
            </table>
            
            <!-- 추가 -->
            <div class='row'>
            	<div class="col-lg-12">
            		
            			<form id='searchForm' action="/board/list" method='get'>
            				<select name='type'>
            				    <!-- 해당 조건으로 검색 했을 때 selected라는 문자열을 출력하게 하여 화면에서 선택된 항목으로 보여지게끔 option 수정 -->
            					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected' : ''}"/>>--</option>
           						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : ''}"/>>제목</option>
           						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : ''}"/>>내용</option>
           						<option value="W" <c:out value="${pageMaker.cri.type eq 'W'? 'selected' : ''}"/>>작성자</option>
           						<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected' : ''}"/>>제목 or 내용</option>
           						<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'? 'selected' : ''}"/>>제목 or 작성자</option>
           						<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
            				</select>
            				<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>' />
            				<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
            				<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>' />
            				<button class='btn btn-default'>Search</button>
            			</form>
            	</div>
            </div>
            

            <div class='pull-right'>
               <ul class="pagination">
                  <c:if test="${pageMaker.prev}">
                       <li class="paginate_button previous"><a href="${ pageMaker.startPage-1 }">Previous</a>
                       </li>
                     </c:if>
         
                     <c:forEach var="num" begin="${pageMaker.startPage}"
                       end="${pageMaker.endPage}">
                       <li class="paginate_button ${ pageMaker.cri.pageNum == num ? "active":"" } "><a href="${ num }">${num}</a></li>
                     </c:forEach>
         
                     <c:if test="${pageMaker.next}">
                       <li class="paginate_button next"><a href="${ pageMaker.endPage + 1 }">Next</a></li>
                     </c:if>
               </ul>
            </div>
            <!--  end Pagination -->
         </div>
         
         <!-- a태그가 원래의 동작을 못하도록 자바스크립트 처리 -->
         <form id='actionForm' action='/board/list' method='get'>
            <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
            <input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
          <!-- 검색조건과 키워드에 대한 처리가 되면 검색 후 페이지를 이동해서 동일한 검색사항들이 계속 유지되는 기능 추가 -->
            <input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
            <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
         </form>
         
         
         
         <!-- Modal  추가 -->
         <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                     <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                  </div>
                  <div class="modal-body">처리가 완료되었습니다.</div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default"
                        data-dismiss="modal">Close</button>
                     <button type="button" class="btn btn-primary" data-dismiss="modal">Save
                        changes</button>
                  </div>
               </div>
               <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
         </div>
         <!-- /.modal -->


      </div>
      <!--  end panel-body -->
   </div>
   <!-- end panel -->
</div>
</div>
<!-- /.row -->
            
<script>
   $(function(){
      var result = '<c:out value="${result}"/>';
      
      checkModal(result);
      
      history.replaceState({}, null, null);
      
      function checkModal(result) {
         if (result === '' || history.state) {
            return;
         }
         
         if(parseInt(result) > 0) {
            $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
         }
         $("#myModal").modal("show");
      }
      
      
      $("#regBtn").on("click",function(){
         self.location = "/board/register";
      });
      
     /*  페이지 번호를 클릭하면 처리하는 부분 추가 */
      var actionForm = $("#actionForm");
     
      $(".paginate_button a").on("click", function(e) {
    	  e.preventDefault();  /* a 태그에 이벤트 줄때는 리턴이나 preventDefault값을 줘야된다. */
    	  
    	  console.log('click');
    	  actionForm.find("input[name='pageNum']").val($(this).attr("href"));
    	  actionForm.submit();
      });
      
      /* 게시물의 제목을 클릭했을 떄 이동하도록 이벤트 처리 */
      $(".move").on("click", function(e){
    	  e.preventDefault();
    	  
    	  actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
    	  actionForm.attr("action", "/board/get");
    	  actionForm.submit();
      }); 
      
      /* p.342 검색 버튼의 이벤트처리 */
      /* 검색은 1페이지를 하도록 수정하고, 화면에 검색조건과 키워드가 보이게 처리하는 작업 */
      var searchForm = $("#searchForm");
      
      $("#searchForm button").on("click", function(e){
    	  
    	  /* 폼객체  폼태그 하위에 옵션에 selected가되어져서 밸류값을 받아오는데 검색조건이 선택된게 아니라면  */
    	  if(!searchForm.find("option:selected").val()){ /* 빈문자열이면 false */ 
    		alert("검색종류를 선택하세요.");
    		return false;
    	  }
    	  
    	  if(!searchForm.find("input[name='keyword']").val()){
    		 alert("키워드를 입력하세요.");
    		 return false;
    	  }
    	  
    	  searchForm.find("input[name='pageNum']").val("1"); /* 1페이지가 실행되도록 처리 */
    	  e.preventDefault;
    	  
    	  searchForm.submit();
    	  
      });
      
      
      
   });
</script>
<%@include file="../includes/footer.jsp"%>