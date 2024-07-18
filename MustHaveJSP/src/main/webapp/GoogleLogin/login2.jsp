<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>구글 아이디로 로그인하기 2</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    
	    <script src="https://accounts.google.com/gsi/client" async defer></script>
	    <script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
	    <script src="http://code.jquery.com/jquery.js"></script>
	    <script>
	    window.onload = function () {
	        google.accounts.id.initialize({
	            client_id: "328442239697-om2ha2st99g1iec29ij8g9g0fbvs7tpl.apps.googleusercontent.com",
	            callback: handleCredentialResponse
	        });
	        google.accounts.id.renderButton(
	            document.getElementById("buttonDiv"),
	            { theme: "outline", text: "signin", width: 250 },
	        );
		    //google.accounts.id.prompt();
	    }
	
	    function handleCredentialResponse(response) {
	        var profile = jwt_decode(response.credential);
	        console.log("ID: " + profile.sub);
	        console.log('Name: ' + profile.name);
	        console.log("Image URL: " + profile.picture);
	        console.log("Email: " + profile.email);    
			
	        $('#login').css('display', 'none');
	        $('#logout').css('display', 'block');
	        $('#upic').attr('src', profile.picture);
	        $('#uname').html('[ ' +profile.name + ' ]');
	    }
	    function signOut() {
	        google.accounts.id.disableAutoSelect();
		    
	        $('#login').css('display', 'block');
	        $('#logout').css('display', 'none');
	        $('#upic').attr('src', '');
	        $('#uname').html('');
	    }
	    </script>
	</head>
	<body>
	
	<div id="login">
	    <div id="buttonDiv"></div> 
	</div>
	
	<div id="logout" style="display: none;">
	    <input type="button" onclick="signOut();" value="로그아웃" /><br>
	
	    <img id="upic" src=""><br>
	    <span id="uname"></span>
	</div>
	
	</body>
</html>
