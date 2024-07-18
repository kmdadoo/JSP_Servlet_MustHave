<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>NaverLoginSDK Test with BootStrap</title>
	</head>
	<body>
	
	<a id="gnbLogin" href="#">Login</a>
	
	<div id="naverIdLogin">
	</div>
	
		<!-- /container -->
		<script src="https://code.jquery.com/jquery.js"></script>
	
		<!-- (2) LoginWithNaverId Javscript SDK -->
		<script src="naveridlogin_js_sdk_2.0.2.js"></script>
	
		<!-- (3) LoginWithNaverId Javscript 설정 정보 및 초기화 -->
		<script>
			
			var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "s4wA14Q7fw7G_kH7x_nO",
					callbackUrl: "http://localhost:8081/MustHaveJSP/NaverLogin/login.jsp",
					isPopup: false,
					loginButton: {color: "green", type: 3, height: 60}
				}
			);
			/* (4) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
			naverLogin.init();
			
			/* (4-1) 임의의 링크를 설정해줄 필요가 있는 경우 */
			$("#gnbLogin").attr("href", naverLogin.generateAuthorizeUrl());
	
			/* (5) 현재 로그인 상태를 확인 */
			window.addEventListener('load', function () {
				naverLogin.getLoginStatus(function (status) {
					if (status) {
						/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고
						   사용자 정보를 출력합니다. */
						setLoginStatus();
					}
				});
			});
	
			/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고
			   사용자 정보를 출력합니다. */
			function setLoginStatus() {
				console.log(naverLogin.user);
				var uid = naverLogin.user.getId();
				var profileImage = naverLogin.user.getProfileImage();
				var uName = naverLogin.user.getName();
				var nickName = naverLogin.user.getNickName();
				var eMail = naverLogin.user.getEmail();
	
				$("#naverIdLogin").html(
						'<br><br><img src="' + profileImage + 
						'" height=50 /> <p>' + uid + "-" + uName + '님 반갑습니다.</p>');
	
				$("#gnbLogin").html("Logout");
				$("#gnbLogin").attr("href", "#");
				/* (7) 로그아웃 버튼을 설정하고 동작을 정의합니다. */
				$("#gnbLogin").click(function () {
					naverLogin.logout();
					window.location.replace("login.jsp");
				});
			}
		</script>
	</body>
</html>
