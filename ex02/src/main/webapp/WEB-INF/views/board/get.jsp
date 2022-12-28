<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">Board Read</h1>
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
            </form>
         </div>
      </div>
   </div>
</div>

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