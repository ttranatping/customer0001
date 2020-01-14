<html>

        <head>
                <base href="https://bankapp.pingapac.com/"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
                <link rel="stylesheet" type="text/css" href="/assets/css/apps.css">
                <link rel="stylesheet" href="/assets/menu/styles.css">
                <script src="/assets/js/application.js"></script>
                <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
                <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
                <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
                <script src="/assets/menu/script.js"></script>
                <script src="https://css-tricks.com/examples/PopFromTopMessage/js/modernizr.custom.80028.js"></script>
                <title>My Bank</title>

                <meta http-equiv="cache-control" content="max-age=0" />
                <meta http-equiv="cache-control" content="no-cache" />
                <meta http-equiv="expires" content="-1" />
                <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
                <meta http-equiv="pragma" content="no-cache" />

                <script type="text/javascript">
var apiBaseUrl = "https://bankapp.pingapac.com";

var idx = 0;

function downgrade()
{
        var apiUrl = "/pa/oidc/logout.png";

        callAjax(apiUrl, "GET", null, downgradeResponse);
}

function downgradeResponse(data)
{
        updateBalance();
}

function updateStatement()
{
        var apiUrl = apiBaseUrl + "/bank/getStatement.json?index=" + idx;

        callAjax(apiUrl, "GET", null, updateStatementResponse);
}

function updateStatementResponse(data)
{
                        jQuery.each(data, function(i, item)
                        {
                                idx ++;
                                $("#statementHeader:first-child").after("<tr><td>" + item.type + "</td><td>" + item.desc + "</td><td>$" + item.amount + "</td></tr>");
                        });
}
function updateBalance()
{
        var apiUrl = apiBaseUrl + "/bank/me.json";

        callAjax(apiUrl, "GET", null, updateBalanceResponse, null, true);
}

function updateBalanceResponse(data)
{
        $("body").show();
        $("#balance").html("$" + data.balance);
        updateStatement();
}

function deposit()
{
        var amount = $("#amount").val();

        var apiUrl = apiBaseUrl + "/bank/deposit.json?amount=" + amount;

        callAjax(apiUrl, "GET", null, depositResponse, depositErrorResponse);
}

function depositResponse(data)
{
                        displaySuccess("Successfully deposited $" + $("#amount").val() + " to account.");
                        updateBalance();
                        $("#amount").val("");
}

function depositErrorResponse()
{
        displayError("You do not have permission to deposit money.");
}

function transfer()
{
        var to = $("#to").val();
        var amount = $("#transferAmount").val();

        var apiUrl = apiBaseUrl + "/bank/transfer.json?amount=" + amount + "&toUser=" + to;
        callAjax(apiUrl, "GET", null, transferResponse, transferErrorResponse);
}

function transferErrorResponse()
{
        displayError("You do not have permission to transfer money.");
}
function transferResponse(data)
{
                updateBalance();
                displaySuccess("Successfully transfered $" + $("#transferAmount").val() + " to " + $("#to").val());
                $("#to").val("");
                $("#transferAmount").val("");
}

function displaySuccess(message)
{
                //window.scrollTo(0,0);
                $('#note').css("background","#fde073");
                $('#note').css("color","black");
                $('#note').html(message);
                $('#note').slideDown(1000, function(){
                                     setTimeout(function(){$('#note').slideUp();}, 5000);
                });
}

function displayError(message)
{
                //window.scrollTo(0,0);
                $('#note').css("background-color","red");
                $('#note').css("color","white");
                $('#note').html(message);
                $('#note').slideDown(1000, function(){
                setTimeout(function(){$('#note').slideUp();}, 10000);
                 });
}

function callAjax(url, method, inData, successFunction, errorFunction, isInitialAuth)
{
        var content = inData;

        if(inData != null && inData != "")
                content = JSON.stringify(inData);
        $.ajax({
                url : url,
                //dataType : "json",
                data: content,
                headers: {
                        'X-PREVENT-XSRF':'true'
                },
                type : method,
                statusCode: {
                        401: function(data)
                                {
                                        $("#reauthenticateDiv").empty();
                                        $("#reauthenticateDiv").append(data.responseText);

                                        if(!isInitialAuth)
                                        {
$( function() {
    $( "#dialog-confirm" ).dialog({
      resizable: false,
      height: "auto",
      width: 400,
      modal: true,
      buttons: {
        "Continue": function() {
          navigate();
          $( this ).dialog( "close" );
        },
        Cancel: function() {
          $("reauthenticateDiv").empty();
          $( this ).dialog( "close" );
        }
      }
    });
});
                                                //alert("Your request has been cancelled and you are required to re-authenticate before reattempting the same request.");
                                        }
                                        else
                                                navigate();
                                },
                        403: errorFunction,
                        200: successFunction
                }
        });
}


updateBalance();

                </script>
                <style>


    #note {
        position: absolute;
        z-index: 6001;
        top: 0;
        left: 0;
        display: none;
        right: 0;
        background: #fde073;
        text-align: center;
        line-height: 2.5;
        overflow: hidden;
        -webkit-box-shadow: 0 0 5px black;
        -moz-box-shadow:    0 0 5px black;
        box-shadow:         0 0 5px black;
    }
    #noteUpgrade {
        position: absolute;
        z-index: 6001;
        top: 0;
        left: 0;
        display: none;
        right: 0;
        background: red;
        color: #fff;
        text-align: center;
        line-height: 2.5;
        overflow: hidden;
        -webkit-box-shadow: 0 0 5px black;
        -moz-box-shadow:    0 0 5px black;
        box-shadow:         0 0 5px black;
    }
        .wordwrap {
                white-space: pre-wrap;      /* CSS3 */
                white-space: -moz-pre-wrap; /* Firefox */
                white-space: -pre-wrap;     /* Opera <7 */
                white-space: -o-pre-wrap;   /* Opera 7 */
                word-wrap: break-word;      /* IE */
        }
#divAdditionalConsent
{
        max-width:500px;
        margin: 0 auto;
}

#divAdditionalConsent ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}

#divAdditionalConsent li {
  font: 200 20px/1.5 Helvetica, Verdana, sans-serif;
  border-bottom: 1px solid #ccc;
}

#divAdditionalConsent li:last-child {
  border: none;
}

#divAdditionalConsent li a {
  text-decoration: none;
  color: #000;
  display: block;
  width: 200px;

  -webkit-transition: font-size 0.3s ease, background-color 0.3s ease;
  -moz-transition: font-size 0.3s ease, background-color 0.3s ease;
  -o-transition: font-size 0.3s ease, background-color 0.3s ease;
  -ms-transition: font-size 0.3s ease, background-color 0.3s ease;
  transition: font-size 0.3s ease, background-color 0.3s ease;
}

#divAdditionalConsent li a:hover {
  font-size: 30px;
  background: #f6f6f6;
}

#top, #bottom, #left, #right {
        display:none;
        background: red;
        position: fixed;
        }
        #left, #right {
                top: 0; bottom: 0;
                width: 15px;
                }
                #left { left: 0; }
                #right { right: 0; }

        #top, #bottom {
                left: 0; right: 0;
                height: 15px;
                }
                #top { top: 0; }
                #bottom { bottom: 0; }
                </style>
        </head>
        <body style="display:none">
<div id="left"></div>
<div id="right"></div>
<div id="top"></div>
<div id="bottom"></div>
<div style="display:none;" id="dialog-confirm" title="Upgrade session?">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>You will need to upgrade your session before performing this action. You may be asked to perform a stronger level of authentication. </p><p>Would you like to continue?</p>
</div>
                <div id="noteUpgrade">Your session has been upgraded. You can now perform additional functions. Click <a href="javascript:downgrade()" style="color:yellow">here</a> to downgrade your session.
                </div>
                <div id="note">
                </div>
                <script type="text/javascript">

                        var sub = "<%=request.getHeader("X-FIRSTNAME")%>";

                </script>
                <div class="row header">
                        <div class="col-12">
                                <div class="logo">&nbsp;</div>
                        </div>
                </div>
                <div class="row content">
                                <div class="row row1">
                                        <div class="col-12 centerText">
                                                <h1>Bank App</h1>
                                                <a href="https://idp-anz.pingapac.com/idp/startSLO.ping">Logout</a>
                                        </div>
                                        <div class="col-12 centerText">
                                                Hello <span id="sub"></span>,
                                        </div>
                                        <div class="col-12 centerText">
                                                <p>Your balance is: <span id="balance"></span></p>
                                        </div>
                                </div>
                                <div class="row row2">
                                        <div class="col-12 centerText">
                                                <h2>Deposit money</h2>
                                                <div class="col-12"><input type="text" name="amount" id="amount" placeholder="Amount..."/></div>
                                                <div class="col-12"><input type="button" name="Deposit" value="Deposit" onclick="deposit()"/></div>
                                        </div>
                                </div>
                                <div class="row row3">
                                        <div class="col-12 centerText">
                                                <h2>Transfer money</h2>
                                                <div class="col-12"><input type="text" name="to" id="to" placeholder="Send money to..."/></div>
                                                <div class="col-12"><input type="text" name="transferAmount" id="transferAmount" placeholder="Amount"/></div>
                                                <div class="col-12"><input type="button" name="Transfer" value="Transfer" onclick="transfer()"/></div>
                                        </div>
                                </div>
                                <div class="row row4">
                                        <div class="col-12 innerContent">
                                                <h2>Transaction history</h2>
                                                <table id="statement">
                                                        <tr id="statementHeader"><th align="left" width="200">Type</th><th align="left" width="400">Description</th><th align="left" width="200">Amount</th></tr>
                                                </table>
                                        </div>
                                </div>
                        <script type="text/javascript">
                                document.getElementById("sub").textContent="<%=request.getHeader("X-FIRSTNAME")%>";
                                //updateBalance();
                        </script>
                </div>
                <div id="reauthenticateDiv"></div>

<script>

if("<%=request.getHeader("X-ACR")%>" == "2FA")
{
        $("#top").show();
        $("#right").show();
        $("#left").show();
        $("#bottom").show();
        $("#noteUpgrade").show();
}
</script>
        </body>

</html>