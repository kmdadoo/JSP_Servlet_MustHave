<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>D3.CodeEx2-Kakao JavaScript SDK - Custom Login Button</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	    <script src="http://code.jquery.com/jquery.js"></script>
	    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	</head>
	<body>
		<div id="login" style="display: block">
		    <a id="custom-login-btn" href="javascript:loginWithKakao()">
		    <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
		    </a>
		</div>
		
		<div id="logout" style="display: none;">
		    <input type="button" class="btn btn-success" onclick="signOut();" value="로그아웃" /><br>
		
		    <img id="upic" src=""><br>
		   	<span id="uname"></span>
		</div>
		
		<script type='text/javascript'>
		    Kakao.init('a04b4af4f9d588c26e65c264068e9118');
		    function loginWithKakao() {
		      // 로그인 창을 띄웁니다.
		      Kakao.Auth.login({
		        success: function(authObj) {
		          //alert(JSON.stringify(authObj));
		          signIn(authObj);
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
		    };
		
		    function signIn(authObj) {
		        //console.log(authObj);
		        Kakao.API.request({
		            url: '/v2/user/me',
		            success: function(res) {
		                //console.log(res);
		                console.log(res.id);
		                $('#login').css('display', 'none');
		               	$('#logout').css('display', 'block');
		                $('#upic').attr('src', res.properties.thumbnail_image );
		               	$('#uname').html('[ ' + res.properties.nickname + ' ]');
		             }
		         })
			}
		
		    function signOut() {
			    Kakao.Auth.logout(function () {
			    	$('#login').css('display', 'block');
			    	$('#logout').css('display', 'none');
			    	$('#upic').attr('src', '');
			    	$('#uname').html('');
			    });
			}
		</script>
	</body>
</html>

