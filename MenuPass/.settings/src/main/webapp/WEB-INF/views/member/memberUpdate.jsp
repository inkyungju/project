<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Member Update</title>
<link href="/resources/css/memberUpdate.css" rel="stylesheet">
<link href="../../resources/css/mainMenu.css" rel="stylesheet">
</head>
<body>
<%@ include file="../common/mainMenu.jsp"%>
	<div class="form-container">
		<h2>Member Update</h2>
		<form id="update-form" action="/member/updateout" method="post">
			<div class="form-group">
				<label for="name">Name:</label> <input type="text" id="name"
					name="memberName" value="${result.memberName}" required>
			</div>
			<div class="form-group">
				<label for="email">Email:</label> <input type="email" id="email"
					name="memberEmail" value="${result.memberEmail}" required>
			</div>
			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					id="password" name="memberPw" placeholder="********"
					onkeyup="validatePassword()"
					pattern="^(?=.*[a-z])(?=.*[!@#$%^&+=])[A-Za-z\d@$!%*?&#]{6,20}$"
					title="6자 이상 20자 이내로, 최소한 하나의 소문자와 하나의 특수문자를 포함해야 합니다." required>
			</div>
			<div class="form-group">
				<label for="confirm-password">Confirm Password:</label> <input
					type="password" id="confirm-password" name="confirm-password"
					onkeyup="validatePassword()" placeholder="********" required>
				<span id="msgChk"></span>
				<!-- Add this div to display the password confirmation message -->
			</div>
			<div class="form-group">
				<button type="submit">Update</button>
			</div>
		</form>
	</div>

	<script>
		function validatePasswords() {
			var password = document.getElementById('password').value;
			var confirmPassword = document.getElementById('confirm-password').value;
			var msgChk = document.getElementById('msgChk');

			if (password === confirmPassword) {
				msgChk.textContent = "Passwords match";
				msgChk.style.color = "green";
			} else {
				msgChk.textContent = "Passwords do not match";
				msgChk.style.color = "red";
			}
		}

		document
				.getElementById('update-form')
				.addEventListener(
						'submit',
						function(event) {
							event.preventDefault();

							var email = document.getElementById('email').value;
							var password = document.getElementById('password').value;
							var confirmPassword = document
									.getElementById('confirm-password').value;
							var msgChk = document.getElementById('msgChk');
							var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

							if (!emailRegex.test(email)) {
								alert("Invalid email address");
								return;
							}

							if (password !== confirmPassword) {
								msgChk.textContent = "Passwords do not match";
								msgChk.style.color = "red";
								return;
							}

							msgChk.textContent = ""; // Clear any previous message
							msgChk.style.color = "green";
							alert("회원정보 업데이트를 성공적으로 마쳤습니다.");
							document.getElementById('update-form').submit();
						});

		document.getElementById('password').addEventListener('keyup',
				validatePasswords);
		document.getElementById('confirm-password').addEventListener('keyup',
				validatePasswords);
	</script>
</body>
</html>
