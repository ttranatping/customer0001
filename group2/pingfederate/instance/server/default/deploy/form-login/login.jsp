<html>
<head>
    <title>Login</title>
    <base href="/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="x-ua-compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="https://sso-0001.pingapac.com/assets/css/main.css"/>

    <!-- Support Promises in Internet Explorer -->
    <script type="text/javascript">
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE ");
        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))
            document.write('<script src="https://polyfill.io/v3/polyfill.min.js?features=Promise%2CPromise.prototype.finally"><\/script>');
    </script>
</head>

<body onload="setFocus();isWebAuthnPlatformAuthenticatorAvailable();">

<div class="ping-container ping-signin login-template">

    <!--
    if there is a logo present in the 'company-logo' container,
    then 'has-logo' class should be added to 'ping-header' container.
    -->
    <div class="ping-header">
        <span class="company-logo"><!-- client company logo here --></span>
        Login
    </div>
    <!-- .ping-header -->

    <div class="ping-body-container">

        <div>
            <form method="POST" action="./form-login/loginHandler.jsp" autocomplete="off">

                        <div class="ping-input-label">
                            Username
                        </div>
                        <div class="ping-input-container">
                            <input id="username" type="text" size="36" name="username" value="" autocorrect="off" autocapitalize="off" onKeyPress="return postOnReturn(event)"  />
                            <div class="place-bottom type-alert tooltip-text" id="username-text">
                                <div class="icon">!</div>
                                Required value
                            </div>
                        </div>

                        <div class="ping-input-label">
                            Password
                        </div>
                        <div class="ping-input-container password-container">
                            <input id="password" type="password" size="36" name="password" onKeyPress="return postOnReturn(event)" />
                            <div class="place-bottom type-alert tooltip-text" id="password-text">
                                <div class="icon">!</div>
                                Required value
                            </div>
                        </div>

                        <div class="ping-buttons">
                            <input type="hidden" name="okButton" value="" />
                            <input type="hidden" name="cancelButton" value="" />

                            <a onclick="postOk();" class="ping-button normal allow" title="Sign in">
                            Sign in
                            </a>
                        </div><!-- .ping-buttons -->
            </form>
        </div><!-- .ping-body// blank div -->
        
    </div><!-- .ping-body-container -->

    <div class="ping-footer-container">
        <div class="ping-footer">
            <div class="ping-credits"></div>
            <div class="ping-copyright"></div>
        </div>
        <!-- .ping-footer -->
    </div>
    <!-- .ping-footer-container -->

</div><!-- .ping-container -->

<script type="text/javascript">

    function postOk() {
            // remove error tips
            if (document.forms[0]['username'].value !== '') {
                document.getElementById('username-text').className = 'place-bottom type-alert tooltip-text';
            }
            if (document.forms[0]['password'].value !== '') {
                document.getElementById('password-text').className = 'place-bottom type-alert tooltip-text';
            }
            // Add back
            if (document.forms[0]['username'].value === '') {
                document.getElementById('username-text').className += ' show';
            }
            else if (document.forms[0]['password'].value === '') {
                document.getElementById('password-text').className += ' show';
            }
            else {
                submitForm()
            }
    }

    function submitForm()
    {
        document.forms[0]['okButton'].value = 'clicked';
        document.forms[0].submit();
    }

    function postCancel() {
        document.forms[0]['cancelButton'].value = 'clicked';
        document.forms[0].submit();
    }

    function postOnReturn(e) {
        var keycode;
        if (window.event) keycode = window.event.keyCode;
        else if (e) keycode = e.which;
        else return true;

        if (keycode == 13) {
            postOk();
            return false;
        } else {
            return true;
        }
    }

    function setFocus() {
        var platform = navigator.platform;
        if (platform != null && platform.indexOf("iPhone") == -1) {
            document.getElementById('username').focus();
        }
    }

    function setMobile(mobile) {
        var className = ' mobile',
            hasClass = (bodyTag.className.indexOf(className) !== -1);

        if (mobile && !hasClass) {
            bodyTag.className += className;

        } else if (!mobile && hasClass) {
            bodyTag.className = bodyTag.className.replace(className, '');
        }
    }

    function getScreenWidth() {
        return (window.outerHeight) ? window.outerWidth : document.body.clientWidth;
    }

    var bodyTag = document.getElementsByTagName('body')[0],
        width = getScreenWidth(),
        remember = false;

    if (/Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        setMobile(true);
    } else {
        setMobile((width <= 480));
        window.onresize = function() {
            width = getScreenWidth();
            setMobile((width <= 480));
        }
    }

    function IsWebAuthnSupported() {
        if (!window.PublicKeyCredential) {

            console.log("Web Authentication API is not supported on this browser.");
            return false;
        }

        return true;
    }

    function isWebAuthnPlatformAuthenticatorAvailable() {

        theElement = document.getElementById("biometrics-div");
        if(theElement)
            theElement.style.display = "none";

        theElement = document.getElementById("windowshello-div");
        if(theElement)
             theElement.style.display = "none";

        theElement = document.getElementById("faceid-div");
        if(theElement)
            theElement.style.display = "none";

        theElement = document.getElementById("touchid-div");
        if(theElement)
            theElement.style.display = "none";

        var timer;

        var p1 = new Promise(function(resolve) {
            timer = setTimeout(function() {
                console.log("isWebAuthnPlatformAuthenticatorAvailable - Timeout");
                resolve(false);
            }, 300);
        });

        var p2 = new Promise(function(resolve) {

            if (IsWebAuthnSupported() && window.PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable) {

                resolve(
                    window.PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable().catch(function(err) {
                        console.log(err);
                        return false;
                    }));
            }
            else {
                resolve(false);
            }
        });

        return Promise.race([p1, p2]).then(function (res) {
            clearTimeout(timer);
            console.log("isWebAuthnPlatformAuthenticatorAvailable - " +  res);

            if(res) {
                 theElement = document.getElementById("biometrics-div");
                 if(theElement)
                     theElement.style.display = "block";

                 theElement = document.getElementById("windowshello-div");
                 if(theElement)
                     theElement.style.display = "block";

                 theElement = document.getElementById("faceid-div");
                 if(theElement)
                     theElement.style.display = "block";

                 theElement = document.getElementById("touchid-div");
                 if(theElement)
                     theElement.style.display = "block";
            }

            return res;
        });
    }
</script>

</body>
</html>