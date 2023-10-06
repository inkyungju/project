<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link href="/resources/css/member.css" rel="stylesheet">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<!-- sweetAlert2 CDN -->
<!-- sweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</head>
<body>
	<div class="line"></div>
	<container>
	<h1 class="menupass-heading">MENU PASS</h1>
	<nav class="main-nav">
		<ul>
			<li><a class="signin" href="#0">Sign in</a></li>
			<li><a class="signup" href="#0">Sign up</a></li>

		</ul>
	</nav>

	<div class="user-modal">
		<div class="user-modal-container">
			<ul class="switcher">
				<li><a href="#0">Sign in</a></li>
				<li><a href="#0">New account</a></li>
			</ul>

			<div id="login">
				<form class="form" action="/member/login.do" method="post">
					<p class="fieldset">
						<label class="image-replace email" for="signin-email">E-mail</label>
						<input class="full-width has-padding has-border" id="signin-email"
							name="memberEmail" type="text" placeholder="E-mail"> <span
							class="error-message">An account with this email address
							does not exist!</span>
					</p>

					<p class="fieldset">
						<label class="image-replace password" for="signin-password">Password</label>
						<input class="full-width has-padding has-border"
							id="signin-password" name="memberPw" type="password"
							placeholder="Password"> <a href="#0"
							class="hide-password">Show</a> <span class="error-message">Wrong
							password! Try again.</span>
					</p>

					<p class="fieldset">
						<input type="checkbox" id="remember-me" checked> <label
							for="remember-me">Remember me</label>
					</p>

					<p class="fieldset">
						<input class="full-width" id="btn" type="submit" value="Login">
					</p>
				</form>

				<p class="form-bottom-message">
					<a href="#0">Forgot your password?</a>
				</p>
				<!-- <a href="#0" class="close-form">Close</a> -->
			</div>

			<div id="signup">

				<form class="form" action="member/register.do" method="post">
					<p class="fieldset">
						<label class="image-replace username" for="signup-username">Username</label>
						<input class="full-width has-padding has-border"
							id="signup-username" name="memberName" type="text"
							placeholder="Username"> <span class="error-message">Your
							username can only contain numeric and alphabetic symbols!</span>
					</p>

					<p class="fieldset">
						<label class="image-replace email" for="signup-email">E-mail</label>
						<input class="full-width has-padding has-border" id="signup-email"
							name="memberEmail" type="email" placeholder="E-mail"> <span
							class="error-message">Enter a valid email address!</span>
					</p>

					<p class="fieldset">
						<label class="image-replace password" for="signup-password">Password</label>
						<input class="full-width has-padding has-border"
							id="signup-password" name="memberPw" onkeyup="validatePassword()"
							type="password" placeholder="Password"> <a href="#0"
							class="hide-password">Show</a> <span id="pwdChkMsg"></span>
					</p>

					<p class="fieldset">
						<label class="image-replace password" for="passwordChk">비밀번호
							확인</label> <input class="full-width has-padding has-border"
							name="passwordChk" id="passwordChk" onkeyup="validatePassword();"
							required="" type="password" placeholder="Password"> <a
							href="#0" class="hide-password">Show</a> <span id="chkMsg"></span>
					</p>

					<p class="fieldset">
						<input type="checkbox" id="accept-terms"> <label
							for="accept-terms">I agree to the <a class="accept-terms"
							href="#0">Terms</a></label>
					</p>

					<p class="fieldset">
						<input class="full-width has-padding" type="submit"
							value="Create account">
					</p>
				</form>

				<!-- <a href="#0" class="cd-close-form">Close</a> -->
			</div>

			<div id="reset-password">
				<p class="form-message">
					Lost your password? Please enter your email address.</br> You will
					receive a link to create a new password.
				</p>

				<form class="form" action="member/login.do" method="post">
					<p class="fieldset">
						<label class="image-replace email" for="reset-email">E-mail</label>
						<input class="full-width has-padding has-border" id="reset-email"
							name="memberEmail" type="email" placeholder="E-mail"> <span
							class="error-message">An account with this email does not
							exist!</span>
					</p>

					<p class="fieldset">
						<input class="full-width has-padding" type="submit"
							value="Reset password">
					</p>
				</form>

				<p class="form-bottom-message">
					<a href="#0">Back to log-in</a>
				</p>
			</div>
			<a href="#0" class="close-form">Close</a>
		</div>
	</div>
	</container>

	<script>
	
    // jQuery 문서가 준비되면 실행되는 코드

        jQuery(document).ready(function($){
           
    // 변수들을 설정합니다.

  	var $form_modal = $('.user-modal'),
    $form_login = $form_modal.find('#login'),
    $form_signup = $form_modal.find('#signup'),
    $form_forgot_password = $form_modal.find('#reset-password'),
    $form_modal_tab = $('.switcher'),
    $tab_login = $form_modal_tab.children('li').eq(0).children('a'),
    $tab_signup = $form_modal_tab.children('li').eq(1).children('a'),
    $forgot_password_link = $form_login.find('.form-bottom-message a'),
    $back_to_login_link = $form_forgot_password.find('.form-bottom-message a'),
    $main_nav = $('.main-nav');

    // 모바일에서 메인 네비게이션을 클릭했을 때의 동작
  $main_nav.on('click', function(event){

    if( $(event.target).is($main_nav) ) {
        // 모바일에서 하위 메뉴 열기
      $(this).children('ul').toggleClass('is-visible');
    } else {
        // 모바일에서 하위 메뉴 닫기
      $main_nav.children('ul').removeClass('is-visible');
      // 모달 레이어 표시
      $form_modal.addClass('is-visible'); 
      // 선택된 폼 표시
      ( $(event.target).is('.signup') ) ? signup_selected() : login_selected();
    }

  });

  // 모달을 닫는 코드
  $('.user-modal').on('click', function(event){
    if( $(event.target).is($form_modal) || $(event.target).is('.close-form') ) {
      $form_modal.removeClass('is-visible');
    } 
  });
  // Esc 키를 눌렀을 때 모달 닫기
  $(document).keyup(function(event){
      if(event.which=='27'){
        $form_modal.removeClass('is-visible');
      }
    });

  // 탭 간 전환
  $form_modal_tab.on('click', function(event) {
    event.preventDefault();
    ( $(event.target).is( $tab_login ) ) ? login_selected() : signup_selected();
  });

  // 비밀번호 숨기기 또는 보이기
  $('.hide-password').on('click', function(){
    var $this= $(this),
      $password_field = $this.prev('input');
    
    // 비밀번호 필드의 타입 변경

    ( 'password' == $password_field.attr('type') ) ? $password_field.attr('type', 'text') : $password_field.attr('type', 'password');
    // 버튼 텍스트 변경
	( 'Show' == $this.text() ) ? $this.text('Hide') : $this.text('Show');
    // 포커스 및 커서 이동
    $password_field.putCursorAtEnd();
  });

  // 비밀번호 재설정 폼 표시
  $forgot_password_link.on('click', function(event){
    event.preventDefault();
    forgot_password_selected();
  });

  // 비밀번호 재설정 폼에서 로그인 폼으로 돌아가기
  $back_to_login_link.on('click', function(event){
    event.preventDefault();
    login_selected();
  });
  
  // 로그인 폼 선택 시 동작
  function login_selected(){
    $form_login.addClass('is-selected');
    $form_signup.removeClass('is-selected');
    $form_forgot_password.removeClass('is-selected');
    $tab_login.addClass('selected');
    $tab_signup.removeClass('selected');
  }
  // 회원가입 폼 선택 시 동작

  function signup_selected(){
    $form_login.removeClass('is-selected');
    $form_signup.addClass('is-selected');
    $form_forgot_password.removeClass('is-selected');
    $tab_login.removeClass('selected');
    $tab_signup.addClass('selected');
  }

  function forgot_password_selected(){
    $form_login.removeClass('is-selected');
    $form_signup.removeClass('is-selected');
    $form_forgot_password.addClass('is-selected');
  }

 

  //IE9 placeholder fallback
  //credits http://www.hagenburger.net/BLOG/HTML5-Input-Placeholder-Fix-With-jQuery.html
  if(!Modernizr.input.placeholder){
    $('[placeholder]').focus(function() {
      var input = $(this);
      if (input.val() == input.attr('placeholder')) {
        input.val('');
        }
    }).blur(function() {
      var input = $(this);
        if (input.val() == '' || input.val() == input.attr('placeholder')) {
        input.val(input.attr('placeholder'));
        }
    }).blur();

   }

});


//credits https://css-tricks.com/snippets/jquery/move-cursor-to-end-of-textarea-or-input/
jQuery.fn.putCursorAtEnd = function() {
  return this.each(function() {
      // If this function exists...
      if (this.setSelectionRange) {
          var len = $(this).val().length * 2;
          this.setSelectionRange(len, len);
      } else {
      
          $(this).val($(this).val());
      }
  });
};  

<!-- Alert Script -->

const msg = '<%= request.getAttribute("msg") %>'
	const status = '<%= request.getAttribute("status") %>'
	if(msg !== null && msg !== "null" &&
	   status !== null && status !== "null") {
		$(document).ready(function() {  
			alertFunction(msg, status);
		});
	}

function alertFunction(msg, status) {
	Swal.fire({
		icon: status,
		title: status,
		text: msg
	});
}
	function validatePassword() {
	    const passwordRegex = /^(?=.*[a-z])(?=.*[!@#$%^&+=])[A-Za-z\d@$!%*?&#]{6,20}$/;
	    const password = document.getElementById("signup-password").value;
	    const passwordChk = document.getElementById("passwordChk").value;
	    const msg = document.getElementById("pwdChkMsg");
	    const msgChk = document.getElementById("chkMsg");

	    if (passwordRegex.test(password)) {
	        msg.innerHTML = "사용 가능한 비밀번호입니다.";
	        msg.style.color = "green";
	    } else {
	        msg.innerHTML = "6자이상 영문,숫자, 특수문자를 사용하세요.";
	        msg.style.color = "red";
	    }

	    if (password === passwordChk) {
	        msgChk.innerHTML = "비밀번호가 동일합니다.";
	        msgChk.style.color = "green";
	    } else {
	        msgChk.innerHTML = "비밀번호가 동일하지 않습니다.";
	        msgChk.style.color = "red";
	    }
	}

</script>
</body>
</html>



