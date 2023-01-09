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
   	
   	<!-- 실제 원본 이미지 보여주는 영역 -->
   	<div class='bigPictureWrapper'>
   		<div class='bigPicture'>
   		</div>
   	</div>
   
   	<div class='uploadResult'>
         <ul>
            
         </ul>
   	</div>
	
	<button id='uploadBtn'>Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script>
	
	function showImage(fileCallPath){
		//alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+ encodeURI(fileCallPath) +"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	//빅 픽쳐 닫는 이벤트 처리
	$(".bigPictureWrapper").on("click", function(e) {
	      $(".bigPicture").animate({ width : '0%', height : '0%' }, 1000);
	      setTimeout(() => {
	         $(this).hide();
	      }, 1000); 
	   });

	
	//"x"표시에 대한 이벤트 처리
	$(".uploadResult").on("click", "span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log("targetFile");
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName: targetFile, type: type},
			dataType: 'text',
			type: 'POST',
				success: function(result){
					alert(result);
				}
		});  //$.ajax
		
	});

	
	$(document).ready(function(){
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
		/* get방식으로 처리할 때 공백,한글이름 오류방지를 위해 encodeURIComponent()를 이용해 URI호출에 적합한 문자열로 인코딩 처리 */
		var uploadResult = $(".uploadResult ul");
			   
			 function showUploadedFile(uploadResultArr){
			  	
				 var str = "";
			  	
			    $(uploadResultArr).each(function(i, obj){
			    			
			    	if(!obj.image){
			    		//첨부파일 다운되게 추가 및 변경
			    		var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			    		
			    		var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
			    		
			    		str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
			    				"<img src = '/resources/img/attach.png'>" + obj.fileName + "</a>"+
			    				"<span data-file = \'"+ fileCallPath +"\' data-type='file'> x </span>" + "</div></li>"; 
			    	
			    	//썸네일 이미지 보여주는 부분
			    	}else{
			    		//str += "<li>" + obj.fileName + "</li>";
			    		
			    		var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			    		
			    		//자바스크립트 코드에서 섬네일 클릭 시 showImage()가 호출될 수 있는 코드를 추가
			    		var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
			    		
			    		originPath = originPath.replace(new RegExp(/\\/g),"/");
			    		
			    		str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">" + 
			    				"<img src='/display?fileName="+fileCallPath+"'></a>" + 
			    						"<span data-file=\'" + fileCallPath +"\' data-type='image'> x </span>" + 
			    						"</li>";
			    	}
			 	});
			      
			    uploadResult.append(str);
			 }
	
		});
		
	});
	</script>
		
	
	
	
</body>
</html>