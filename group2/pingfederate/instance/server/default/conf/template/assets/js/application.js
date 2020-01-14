
// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require jquery-ui
//= require_tree .
//= require_self

if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}

function sortUnorderedList(mylist)
{
	var listitems = mylist.children('li').get();
	listitems.sort(function(a, b) {
	   return $(a).text().toUpperCase().localeCompare($(b).text().toUpperCase());
	})
	$.each(listitems, function(idx, itm) { mylist.append(itm); });
}

function callAjax(urlStr, successFunction, errorFunction) {
	var response = null;
	
	var randomString = generateUUID();
	
	if(urlStr.endsWith(".json"))
	{
		urlStr = urlStr + "?";
	}
	else
	{
		urlStr = urlStr + "&";
	}
	
	urlStr = urlStr; // + "randomString=" + randomString;
	$.ajax({
		url : urlStr,
		data: { format: 'json'},
        	cache: false,
		dataType : "json",
		crossDomain: true,
		type: 'GET',
		//jsonpCallback: "callbackName",
		xhrFields: {withCredentials: true},
		beforeSend: function(xhr){
    			xhr.withCredentials = true;
		},
	}) 
	.done(successFunction)
	.fail(errorFunction);
	return response;
}

function callAjaxP(urlStr, successFunction, errorFunction) {
        var response = null;

        var randomString = generateUUID();

        if(urlStr.endsWith(".json"))
        {
                urlStr = urlStr + "?";
        }
        else
        {
                urlStr = urlStr + "&";
        }

        urlStr = urlStr; // + "randomString=" + randomString;
        $.ajax({
                url : urlStr,
                data: { format: 'jsonp'},
                cache: false,
                dataType : "jsonp",
                crossDomain: true,
                type: 'GET',
                jsonpCallback: successFunction,
                xhrFields: {withCredentials: true},
                beforeSend: function(xhr){
                        xhr.withCredentials = true;
                },
        });

        return response;
}

function getCookie(cname)
{
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for(var i=0; i<ca.length; i++) 
	{
	  var c = ca[i].trim();
	  if (c.indexOf(name)==0)
	  {
		  var cookieVal = decodeURIComponent (escape(c.substring(name.length,c.length)));
		  var hasQuotesReg = new RegExp("\".*\"");
		  
		  if(hasQuotesReg.test(cookieVal))
		  {
			  cookieVal = cookieVal.substring(1, cookieVal.length - 1);
		  }
			  
		  return cookieVal;
	  }
	}
	return "";
}

function generateUUID(){
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x7|0x8)).toString(16);
    });
    return uuid;
};

String.prototype.endsWith = function(suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};

if (!library)
	   var library = {};

library.json = {
   replacer: function(match, pIndent, pKey, pVal, pEnd) {
      var key = '<span class=json-key>';
      var val = '<span class=json-value>';
      var str = '<span class=json-string>';
      var r = pIndent || '';
      if (pKey)
         r = r + key + pKey.replace(/[": ]/g, '') + '</span>: ';
      if (pVal)
         r = r + (pVal[0] == '"' ? str : val) + pVal + '</span>';
      return r + (pEnd || '');
      },
   prettyPrint: function(obj) {
      var jsonLine = /^( *)("[\w]+": )?("[^"]*"|[\w.+-]*)?([,[{])?$/mg;
      return JSON.stringify(obj, null, 3)
         .replace(/&/g, '&amp;').replace(/\\"/g, '&quot;')
         .replace(/</g, '&lt;').replace(/>/g, '&gt;')
         .replace(jsonLine, library.json.replacer);
      }
   };

