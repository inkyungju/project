
      /* EXPANDER MENU */
        const showMenu = (toggleId, navbarId, bodyId) => {
            const toggle = document.getElementById(toggleId),
                navbar = document.getElementById(navbarId),
                bodypadding = document.getElementById(bodyId);

            if (toggle && navbar) {
                toggle.addEventListener('click', () => {
                    navbar.classList.toggle('expander');
                    bodypadding.classList.toggle('body-pd');
                });
            }
        };

        showMenu('nav-toggle', 'navbar', 'body-pd');

      /* LINK ACTIVE */
        const linkColor = document.querySelectorAll('.nav__link');
        function colorLink() {
            linkColor.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        }
        linkColor.forEach(l => l.addEventListener('click', colorLink));

      /* COLLAPSE MENU */
        const linkCollapse = document.getElementsByClassName('collapse__link');
        let i;

        for (i = 0; i < linkCollapse.length; i++) {
            linkCollapse[i].addEventListener('click', function () {
                const collapseMenu = this.nextElementSibling;
                collapseMenu.classList.toggle('showCollapse');

                const rotate = collapseMenu.previousElementSibling;
                rotate.classList.toggle('rotate');
            });
        }

const logoutLink = document.getElementById('logout-link');
    
    logoutButton.addEventListener('click', () => {
      // 로그아웃 함수 호출
      logout();
    });

    function logout() {
      // 로그아웃 관련 처리를 여기에 구현
      // 예: 세션 삭제, 서버와의 로그아웃 요청 등
    }