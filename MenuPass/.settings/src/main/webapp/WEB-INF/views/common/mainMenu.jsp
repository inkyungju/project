<?xml version="1.0" encoding="UTF-8"?>
<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>


    <div class="l-navbar" id="navbar">
    <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="#" class="nav__logo">MENU PASS</a>
                </div>
                <div class="nav__list">
              	  <a href="/maplist/list.do" class="nav__link active">
                        <ion-icon name="navigate-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">AroundPass</span>
                    </a>
                    
                    <a href="/recommend/recommend.do" class="nav__link">
                        <ion-icon name="thumbs-up-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">RecomPass</span>
                    </a>
                    
                    <a href="/api/map" class="nav__link">
                        <ion-icon name="map-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name" >LikePass</span>
                    </a>
                    
                    <a href="/commu/list.do" class="nav__link">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name" >CommuPass</span>
                    </a>

                <div>
                    <a href="/member/updatein" class="nav__link">
                    <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">Settings</span>
               		 </a>
            	</div>
            <a href="/member/logout" class="nav__link" id="logout-link">
    		<ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
    		<span class="nav_name">Log out</span>
			</a>
        </div>
        </div>
        </nav>
        </div>
	<script src="../../resources/js/mainMenu.js"></script>
