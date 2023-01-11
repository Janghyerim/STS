<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>
<style>
.uploadResult {
   width: 100%;
   background-color: gray;
}

.uploadResult ul {
   display: flex;
   flex-flow: row;
   justify-content: center;
   align-items: center;
}

.uploadResult ul li {
   list-style: none;
   padding: 10px;
}

.uploadResult ul li img {
   width: 100px;
}
</style>

<style>
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				
				<div class="panel-heading">Board Register</div>
				<div class="panel-body">
					<form role="form" action="/board/register" method="post">
						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title">
						</div>
						
						<div class="form-group">
							<label>Text area</label> 
							<textarea class="form-control" rows="3" name="content"></textarea>
						</div>
						
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name="writer">
						</div>
						<button type="submit" class="btn btn-default">Submit Button</button>
						<button type="reset" class="btn btn-default">Reset Button</button>
					</form>
				</div>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-->
	</div>
	<!--/.row-->
	
	<!-- 새로 추가하는 부분 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading">File Attach</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple>
					</div>
					
					<div class='uploadResult'>
						<ul>
						
						</ul>
					</div>
					
					
				</div>
				<!-- end panel-body -->
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-->
	</div>
	<!-- /.row -->
	
<script>

	/* submit button 클릭 했을 때 첨부파일 관련된 처리 할 수 있도록 기본동작 막는 법 */
	$(document).ready(function(e){
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			
			console.log("submit clicked");
			
			//브라우저에서 게시물 등록을 선택하면 이미 업로드된 항목들을 내부적으로 submit될 때 같이 전송되게 한다.
			var str = "";
			$(".uploadResult ul li").each(function(i, obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				console.log("===============================================");
				console.log(jobj.data("filename"));
				
				str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value ='" + jobj.data("filename") + "'>";
				str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value ='" + jobj.data("uuid") + "'>";
				str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value ='" + jobj.data("path") + "'>";
				str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value ='" + jobj.data("type") + "'>";
				
			});
			console.log(str);
			
			formObj.append(str).submit();
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false, 
				data: formData,
				type: 'POST',
				dataType: 'json',
					success: function(result){
						console.log(result);
						showUploadResult(result); //업로드 결과 처리 함수
					}
			}); //$.ajax
			
		});
		
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0){ return; }
			var uploadUL = $(".uploadResult ul");
			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				
				//게시물 등록과 첨부파일의 데이터베이스 처리
				//image type
				if(obj.image){
			          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			          str += "<li data-path='"+obj.uploadPath+"'"; 
			          str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			          str +" ><div>";
			          str += "<span> "+ obj.fileName+"</span>";
			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			          str += "<img src='/display?fileName="+fileCallPath+"'>";
			          str += "</div>";
			          str +"</li>";
			          }else{
				          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);    
				          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
  
			          str += "<li data-path='"+obj.uploadPath+"'";
			          str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			          str +" ><div>";
			          str += "<span> "+ obj.fileName+"</span>";
			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			          str += "<img src='/resources/img/attach.png'></a>";
			          str += "</div>";
			          str +"</li>";
			        }    

			});
			uploadUL.append(str);
		}
	});
	
</script>

<%@ include file="../includes/footer.jsp" %>