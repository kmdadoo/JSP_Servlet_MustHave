<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
	    <title>Insert title here</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <script src="http://code.jquery.com/jquery.js"></script>
	
	<script>
	  window.fbAsyncInit = function() {
	    FB.init({
	      appId      : '1821994574834799',
	      cookie     : true,
	      xfbml      : true,
	      version    : 'v20.0'
	    });
	
	    FB.getLoginStatus(function(response) {
	    	console.log(response);
	      statusChangeCallback(response);
	    });
	  };
	
	  // Load the SDK asynchronously
	  (function(d, s, id) {
	    var js, fjs = d.getElementsByTagName(s)[0];
	    if (d.getElementById(id)) return;
	    js = d.createElement(s); js.id = id;
	    js.src = "https://connect.facebook.net/en_US/sdk.js";
	    fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
	
	  function statusChangeCallback(response) {
	    if (response.status === 'connected') {
	      getINFO();
	    } else {
	      $('#login').css('display', 'block');
	      $('#logout').css('display', 'none');
	      $('#upic').attr('src', '');
	      $('#uname').html('');
	    }
	  }
		  
	  function fbLogin () {
	    FB.login(function(response){
	      statusChangeCallback(response);
	    }, {scope: 'public_profile, email'});
	  }
	
	  function fbLogout () {
	    FB.logout(function(response) {
	      statusChangeCallback(response);
	    });
	  }
	
	  function getINFO() {
	    FB.api('/me?fields=id,name,picture.width(100).height(100).as(picture_small)', function(response) {
	      console.log(response);
	      $('#login').css('display', 'none');
	      $('#logout').css('display', 'block');
	      $('#upic').attr('src', response.picture_small.data.url );
	      $('#uname').html('[ ' + response.name + ' ]');
	    });
	  }
	
	</script>
	
	</head>
	<body>
	
	<div id="login" style="display: block;">
	    <input type="button" onclick="fbLogin();" value="로그인" /><br>
	</div>
	
	<div id="logout" style="display: none;">
	    <input type="button" onclick="fbLogout();" value="로그아웃" /><br>
	
	    <img id="upic" src=""><br>
	    <span id="uname"></span>
	</div>
	
	</body>
</html>
