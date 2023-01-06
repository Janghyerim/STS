<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</head>
<body>

	<h1>Upload with Ajax</h1>
	
	<!--첨부파일 이름을 목록으로 처리-->
	<div class='uploadDiv'>
      <input type='file' name='uploadFile' multiple>
   	</div>
   
   	<div class='uploadResult'>
         <ul>
            
         </ul>
   	</div>
	
	<button id='uploadBtn'>Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script>
		//파일의 확장자나 크기 처리 
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
		//파일 업로드 후 다시 추가 할 수 있음.
		var cloneObj = $(".uploadDiv").clone();
	
		$(function(){
			$("#uploadBtn").on("click", function(e){
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				//add File Data to formData
				for(var i = 0; i < files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size) ){
						return false;
					}
					
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url:'/uploadAjaxAction',
					processData:false,
					contentType:false,
					data:formData,
					type:'POST',
					dataType:'json',
					success:function(result){
						
						console.log(result);
						
						showUploadedFile(result);
						
						//파일 업로드 후 다시 추가 할 수 있음.
						$(".uploadDiv").html(cloneObj.html());
						
					}
				}); //$.ajax
				
			});
		
			
		/* 목록을 보여주는 부분을 별도의 함수로 처리 */
		var uploadResult = $(".uploadResult ul");
			   
			 function showUploadedFile(uploadResultArr){
			  	
				 var str = "";
			  	
			    $(uploadResultArr).each(function(i, obj){
			    			
			    	if(!obj.image){
			    		str += "<li><img src = '/resources/img/attach.png'>" + obj.fileName + "</li>"; 
			    	}else{
			    		str += "<li>" + obj.fileName + "</li>";
			    	}
			 	});
			      
			    uploadResult.append(str);
			 }
	
		});
	</script>
		
	
	
	
</body>
</html>