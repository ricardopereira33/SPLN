var nObj,topUrlLoaded=!1,submitted={},notificationClosed=!0,userClosed=!1,notificationMinimized=!1,isFirstSubmit=!0,formStage=0,submissionToken="",oldParentBodyPaddingTop=0,oldParentBodyPaddingBottom=0,defaultLanguage="en",messages={en:{formErrors:{CANT_BE_BLANK:"can't be blank.",INVALID:"Invalid",SHOULD_BE_10_DIGITS:"should be 10-digit number",INVALID_PHONE:"should be valid",DEFAULT_FIELD_NAME:"Field"}},sk:{formErrors:{CANT_BE_BLANK:"pole je prázdne",INVALID:"neplatné",INVALID_PHONE:"chybný formát",DEFAULT_FIELD_NAME:"Polia"}},cz:{formErrors:{CANT_BE_BLANK:"pole je prázdné",INVALID:"neplatné",INVALID_PHONE:"chybný formát",DEFAULT_FIELD_NAME:"Pole"}},hu:{formErrors:{CANT_BE_BLANK:"üres mező",INVALID:"érvénytelen",INVALID_PHONE:"hibás formátum",DEFAULT_FIELD_NAME:"Mező"}}};_PrivateFunctions={notificationClosed:function(){return notificationClosed},notificationMinimized:function(){return notificationMinimized},topUrlLoaded:function(){return topUrlLoaded},_visitConnectActionURL:function(t,e){var n=document.location.protocol+"//server.connecto.io/action?action="+t+"&id="+nObj._id;parent.ajaxCall&&parent.ajaxCall(n,null,e)},_uid:function(){function t(t){var e=(Math.random().toString(16)+"000000000").substr(2,8);return t?"-"+e.substr(0,4)+"-"+e.substr(4,4):e}return t()+t(!0)+t(!0)+t()},_hideOnMaximize:function(t){if(t.staticElement&&t.staticElement.hideOnMaximize===!0){displayStyle="none";var e=parent.document.getElementById("container-notification-element-"+t._id+"-frame");e&&(e.style.display=displayStyle)}},_unhideOnMaximize:function(t){if(t.staticElement&&t.staticElement.hideOnMaximize===!0){displayStyle="block";var e=parent.document.getElementById("container-notification-element-"+t._id+"-frame");e&&(e.style.display=displayStyle)}},_openWidget:function(){var t=0,e=nObj.verticalMargin||0,n=nObj.horizontalMargin||0;if(nObj.staticElement&&nObj.staticElement.height&&(t=nObj.staticElement.height),nObj.darkenBackground){var i=parent.document.getElementById("connecto_"+nObj._id+"_bg_element");i&&(i.style.display="block")}if(2===nObj.notification_type){var o=parseInt(oldParentBodyPaddingTop)||0;o+=nObj.height?parseInt(nObj.height):35,parent.document.body.style.paddingTop=o+"px",parent.document.getElementById("container-notification-frame-"+nObj._id).style.margin="0px"}else if(7===nObj.notification_type){var a=parseInt(oldParentBodyPaddingBottom)||0;a+=nObj.height?parseInt(nObj.height):35,parent.document.body.style.paddingBottom=a+"px",parent.document.getElementById("container-notification-frame-"+nObj._id).style.margin="0px"}else if(3===nObj.notification_type){var r=parent.document.getElementById("connecto-modal-overlay-"+nObj._id);r.style.visibility="visible",r.style.zIndex=199999990,parent.document.getElementById("connecto-modal-overlay-"+nObj._id).style.display="block"}else if(12===nObj.notification_type||13===nObj.notification_type);else{var s="0px";8===nObj.notification_type?s="0px 0px "+e+"px -"+parseInt((nObj.width+2)/2)+"px":9===nObj.notification_type?s=e+"px 0px 0px -"+parseInt((nObj.width+2)/2)+"px":11===nObj.notification_type?s="0px "+n+"px -"+parseInt((nObj.height+2)/2)+"px 0px":10===nObj.notification_type?s="0px 0px -"+parseInt((nObj.height+2)/2)+"px "+n+"px":4===nObj.notification_type?s="0px "+n+"px "+e+"px 0px":1===nObj.notification_type?s="0px 0px "+e+"px "+n+"px":5===nObj.notification_type?s=e+"px 0px 0px "+n+"px":6===nObj.notification_type&&(s=e+"px "+n+"px 0px 0px"),parent.document.getElementById("container-notification-frame-"+nObj._id).style.margin=s;var c=parent.document.getElementById("container-notification-element-"+nObj._id+"-frame");nObj.staticElement&&nObj.staticElement.hideOnMaximize===!0?_P._hideOnMaximize(nObj):nObj.staticElement&&(11===nObj.notification_type?s="-"+t/2+"px "+(nObj.width+2)+"px 0px 0px":10===nObj.notification_type?s="-"+t/2+"px 0px 0px "+(nObj.width+2)+"px":4===nObj.notification_type?s="0px 0px "+(nObj.height+2)+"px 0px":1===nObj.notification_type?s="0px 0px "+(nObj.height+2)+"px 0px":8===nObj.notification_type?s="0px 0px "+(nObj.height+2)+"px -"+nObj.staticElement.width/2+"px":9===nObj.notification_type&&(s=nObj.height+2+"px 0px 0px -"+(nObj.staticElement.width/2+11)+"px"),c&&(c.style.margin=s,_P._removeClassFromElement(c,"static-element-minimized"),_P._addClassToElement(c,"static-element-unminimized")))}if(nObj.showCloseIconAfter&&nObj.showCloseIconAfter>0&&1==nObj.closeBehaviour){var l=document.getElementById("co-close-icon-"+nObj._id);l&&(l.style.visibility="hidden",setTimeout(function(){l.style.visibility="visible"},1e3*nObj.showCloseIconAfter))}},_logEvent:function(t){nObj.triggerGA&&(parent._gaq?parent._gaq.push(["_trackEvent","Connecto",t,nObj.title]):parent.dataLayer?parent.dataLayer.push({event:"Connecto",eventLabel:nObj.title,eventCategory:nObj.title,eventAction:t}):parent.ga&&("View"==t||"Close"==t?parent.ga("send","event","Connecto",t,nObj.title,{nonInteraction:!0}):parent.ga("send","event","Connecto",t,nObj.title,{nonInteraction:!1})))},_closeBarWidget:function(){var t,e=nObj.height||35;2===nObj.notification_type?(parent.document.body.style.paddingTop=oldParentBodyPaddingTop,t="-"+e+"px 0px 0px 0px"):7===nObj.notification_type&&(parent.document.body.style.paddingBottom=oldParentBodyPaddingBottom,t="0px 0px -"+e+"px 0px"),parent.document.getElementById("container-notification-frame-"+nObj._id).style.margin=t},_closeFloatingWidget:function(){var t=0;nObj.staticElement&&nObj.staticElement.height&&(t=nObj.staticElement.height);var e="";if(5===nObj.notification_type?e=2===nObj.animateDirection?"0px 0px 0px -"+(nObj.width+2)+"px":"-"+(nObj.height+2)+"px 0px 0px 0px":9===nObj.notification_type?e="-"+(nObj.height+2)+"px 0px 0px -"+parseInt((nObj.width+2)/2)+"px":6===nObj.notification_type?e=2===nObj.animateDirection?"0px -"+(nObj.width+2)+"px 0px 0px":"-"+(nObj.height+2)+"px 0px 0px 0px":11===nObj.notification_type?e="-"+t/2+"px -"+(nObj.width+2)+"px -"+parseInt((nObj.height+2)/2)+"px 0px":10===nObj.notification_type?e="-"+t/2+"px 0px -"+parseInt((nObj.height+2)/2)+"px -"+(nObj.width+2)+"px":4===nObj.notification_type?e=2===nObj.animateDirection?"0px -"+(nObj.width+2)+"px 0px 0px":"0px 0px -"+(nObj.height+2)+"px 0px":8===nObj.notification_type?e="0px 0px -"+(nObj.height+2)+"px -"+parseInt((nObj.width+2)/2)+"px":1===nObj.notification_type?e=2===nObj.animateDirection?"0px 0px 0px -"+(nObj.width+2)+"px":"0px 0px -"+(nObj.height+2)+"px 0px":10===nObj.notification_type&&(e="0px 0px -"+parseInt((nObj.height+2)/2)+"px -"+(nObj.width+2)+"px"),parent.document.getElementById("container-notification-frame-"+nObj._id).style.margin=e,nObj.staticElement&&nObj.staticElement.hideOnMaximize===!0)_P._unhideOnMaximize(nObj);else if(nObj.staticElement&&(e="",11===nObj.notification_type?e="-"+t/2+"px 1px 0px 0px":10===nObj.notification_type?e="-"+t/2+"px 0px 0px 1px":4===nObj.notification_type?e="0px 0px 1px 0px":1===nObj.notification_type?e="0px 0px 1px 0px":8===nObj.notification_type?e="0px 0px 1px -"+nObj.staticElement.width/2+"px":9===nObj.notification_type&&(e="1px 0px 0px -"+(nObj.staticElement.width/2+11)+"px"),e)){var n=parent.document.getElementById("container-notification-element-"+nObj._id+"-frame");n&&(n.style.margin=e,_P._addClassToElement(n,"static-element-minimized"),_P._removeClassFromElement(n,"static-element-unminimized"));var i=parent.document.getElementById("static-element-"+nObj._id+"-icon");i&&(i.style.display="none")}},_getTConnecto:function(){var t;return t=13===nObj.notification_type?_TConnecto:parent._TConnecto},_postClick:function(t){var e=_P._getTConnecto();e&&e.updateState(nObj._id,1,t)},_postSubmit:function(t){var e=_P._getTConnecto();if(e&&(13===nObj.notification_type?e.updateState(nObj,1,t):e.updateState(nObj._id,1,t),nObj.triggerNotifications&&nObj.triggerNotifications.triggerAfterPost&&nObj.triggerNotifications.triggerAfterPost.length>0))for(var n=nObj.triggerNotifications.triggerAfterPost,i=0;i<n.length;i++)e.showMessage(n[i])},_postClose:function(){var t=_P._getTConnecto();if(t&&(13===nObj.notification_type?t.updateState(nObj,0):t.updateState(nObj._id,0),nObj.triggerNotifications&&nObj.triggerNotifications.triggerAfterClose&&nObj.triggerNotifications.triggerAfterClose.length>0))for(var e=nObj.triggerNotifications.triggerAfterClose,n=0;n<e.length;n++)t.showMessage(e[n])},_closeWidget:function(){if(nObj.darkenBackground){var t=parent.document.getElementById("connecto_"+nObj._id+"_bg_element");t&&(t.style.display="none")}if(2===nObj.notification_type||7===nObj.notification_type)_P._closeBarWidget();else if(3===nObj.notification_type){var e=parent.document.getElementById("connecto-modal-overlay-"+nObj._id);e.style.visibility="hidden",parent.document.getElementById("connecto-modal-overlay-"+nObj._id).style.display="none"}else 12===nObj.notification_type||13===nObj.notification_type||_P._closeFloatingWidget()},_openMinimizeElement:function(){2===nObj.notification_type?parent.document.getElementById("top-notification-arrow-"+nObj._id).style.top="0px":7===nObj.notification_type?parent.document.getElementById("top-notification-arrow-"+nObj._id).style.bottom="0px":4!==nObj.notification_type&&1!==nObj.notification_type&&8!==nObj.notification_type||nObj.staticElement?11!==nObj.notification_type||nObj.staticElement?10!==nObj.notification_type||nObj.staticElement||(parent.document.getElementById("container-notification-minimize-"+nObj._id).style.left="0px"):parent.document.getElementById("container-notification-minimize-"+nObj._id).style.right="0px":parent.document.getElementById("container-notification-minimize-"+nObj._id).style.bottom="0px"},_closeMinimizeElement:function(){2===nObj.notification_type?parent.document.getElementById("top-notification-arrow-"+nObj._id).style.top="-40px":7===nObj.notification_type?parent.document.getElementById("top-notification-arrow-"+nObj._id).style.bottom="0px":4!==nObj.notification_type&&1!==nObj.notification_type&&8!==nObj.notification_type||nObj.staticElement||(parent.document.getElementById("container-notification-minimize-"+nObj._id).style.bottom="-30px")},_changeTopURL:function(t){topUrlLoaded||(parent.document.location.href=_P._addProtocolToURL(t),topUrlLoaded=!0)},_addProtocolToURL:function(t){return-1==t.search(/^(tel|market|http[s]?)\:\/\//i)&&(t="http://"+t),t},_getConnectoStorage:function(){return parent._TConnecto&&parent._TConnecto.getConnectoStorage?parent._TConnecto.getConnectoStorage():null},_getConnectoLogs:function(){return parent._TConnecto&&parent._TConnecto.getConnectoLogs?parent._TConnecto.getConnectoLogs():null},_showNext:function(){var t=$("[id^=lead_form-]");$(t.get(formStage)).hide(),formStage+=1,formStage==t.length?($(".form-submit-message").show(),$(".hide-on-form-submit").hide()):$(t.get(formStage)).show()},_submitCompleted:function(t,e){if(isFirstSubmit){e||_P._closeOrRedirect(t),"object"==typeof CustomEvent&&!function(){function t(t,e){e=e||{bubbles:!1,cancelable:!1,detail:void 0};var n=document.createEvent("CustomEvent");return n.initCustomEvent(t,e.bubbles,e.cancelable,e.detail),n}t.prototype=window.Event.prototype,window.CustomEvent=t}();var n=new CustomEvent("formSubmitted",{detail:nObj._id});window.dispatchEvent(n)}isFirstSubmit=!1},_closeOrRedirect:function(t){var e,n=!1;if(nObj.form&&nObj.form.postBehavior&&nObj.form.postBehavior.redirectUrl?(e=nObj.form.postBehavior.redirectUrl,n=nObj.form.postBehavior.submitPostData,getPostDataInUrl=nObj.form.postBehavior.getPostDataInUrl):nObj.forms&&nObj.forms[0]&&nObj.forms[0].postBehavior&&nObj.forms[0].postBehavior.redirectUrl&&(e=nObj.forms[0].postBehavior.redirectUrl,n=nObj.forms[0].postBehavior.submitPostData,getPostDataInUrl=nObj.forms[0].postBehavior.getPostDataInUrl),e)if($("#container-notification-frame-"+nObj._id).hide(),n){var i=$("#"+t);i.attr("action",e),i.attr("method","POST"),i.attr("target","_top"),i.submit()}else{if(getPostDataInUrl){var i=$("#"+t),o=i.serialize(),a=e.indexOf("?");e=a>-1?e+"&"+o:e+"?"+o}nObj.openLinkInNewTab?(window.open(e,"_blank"),_P._closeWidget()):window.top.location.href=e}else _P._closeWidget()},_readCookie:function(t){for(var e=t+"=",n=document.cookie.split(";"),i=0;i<n.length;i++){for(var o=n[i];" "==o.charAt(0);)o=o.substring(1,o.length);if(0===o.indexOf(e))return o.substring(e.length,o.length)}return null},_readAllCookies:function(t){for(var e=document.cookie.split(";"),n=0;n<e.length;n++){for(var i=e[n];" "==i.charAt(0);)i=i.substring(1,i.length);i=i.split("="),t[i[0]]=i[1]}return 0===e.length?!1:!0},_isValidMobileNumber:function(t){var e=/^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ \\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\.?|extension|x)[\-\.\ \\\/]?(\d+))?$/i;return e.test(t)&&t.trim()&&t.trim().length>4?!0:!1},_elementHasClassName:function(t,e){return new RegExp("(?:^|\\s+)"+e+"(?:\\s+|$)").test(t.className)},_addClassToElement:function(t,e){_P._elementHasClassName(t,e)||(t.className=t.className?[t.className,e].join(" "):e)},_removeClassFromElement:function(t,e){if(_P._elementHasClassName(t,e)){var n=t.className;t.className=n.replace(new RegExp("(?:^|\\s+)"+e+"(?:\\s+|$)","g")," ")}}};var _P=_PrivateFunctions;openWidget=function(){nObj&&(notificationClosed=!1,_P._visitConnectActionURL(4),_P._openWidget(),_P._logEvent("View"),nObj.autoCloseAfter&&nObj.autoCloseAfter>0&&setTimeout(function(){autoCloseWidget()},1e3*nObj.autoCloseAfter))},closeWidget=function(){notificationClosed=!0,userClosed=!0,_P._visitConnectActionURL(0),_P._logEvent("Close"),_P._closeWidget(),_P._postClose()},closeWidgetForStatic=function(){notificationClosed=!0,_P._closeWidget()},autoCloseWidget=function(){notificationClosed||(_P._visitConnectActionURL(5),notificationClosed=!0,_P._closeWidget())},openTargetLink=function(t,e){if(notificationClosed=!0,_P._logEvent("Click"),t){if(_P._visitConnectActionURL(1,function(){nObj.openLinkInNewTab||_P._changeTopURL(t)}),0===t.indexOf("tel:")&&e&&"A"==e.nodeName)return e.setAttribute("href",t),e.setAttribute("target","_top"),void _P._closeWidget();nObj.openLinkInNewTab?(window.open(t,"_blank"),_P._postClick(),_P._closeWidget()):setTimeout(function(){_P._changeTopURL(t)},500)}else _P._visitConnectActionURL(1),_P._postClick(),_P._closeWidget()},openMinimizedWidget=function(){notificationClosed=!1,_P._openMinimizeElement()},minimizeOrUnminimizeWidget=function(){nObj.staticElement?toggleWidget():notificationMinimized?(_P._visitConnectActionURL(7),_P._logEvent("Unminimized"),_P._openWidget(),_P._closeMinimizeElement()):(_P._visitConnectActionURL(6),_P._logEvent("Minimized"),_P._closeWidget(),_P._openMinimizeElement()),notificationMinimized=!notificationMinimized},toggleWidget=function(){notificationClosed?(notificationClosed=!1,_P._visitConnectActionURL(7),_P._logEvent("Unminimized"),_P._openWidget()):(notificationClosed=!0,_P._visitConnectActionURL(6),_P._logEvent("Minimized"),_P._closeWidget())},hideIfShown=function(){nObj&&!notificationClosed&&(notificationClosed=!0,_P._logEvent("Minimized"),_P._closeWidget())},showIfHidden=function(){nObj&&notificationClosed&&!userClosed&&(notificationClosed=!1,_P._logEvent("Unminimized"),_P._openWidget())},submitLeadForm=function(t,e){var n=(document.getElementById(t),$("#"+t)),i=!1;if(t in submitted)return!1;if($("#"+t+" .form-field").each(function(){var t=$(this).attr("co-required"),e=$(this).attr("co-name"),n=$(this).attr("co-postdata-name"),o=parseInt($(this).attr("co-type")),a=$(this).attr("id"),r=$(this).val();if(!o||10!=o&&8!=o&&12!=o&&16!=o){if(9===o){var s=[];$('input[co-postdata-name="'+n+'"]:checked').each(function(){s.push($(this).val())}),s.length>0&&(r=s.join(","))}}else r=$("input[co-postdata-name='"+n+"']:checked").val();var c=$(this).attr("co-validations"),l=0,d=0;$(this).attr("co-min-length")&&(l=parseInt($(this).attr("co-min-length"),10)),$(this).attr("co-max-length")&&(d=parseInt($(this).attr("co-max-length"),10)),(!e||e.length>60)&&(e=messages[defaultLanguage].formErrors.DEFAULT_FIELD_NAME);var p;if("true"!=t||r)if("true"==t||r)if(l>0&&r.length<l)p=e+" can't be less than "+l+" characters.";else if(d>0&&r.length>d)p=e+" can't be more than "+d+" characters.";else{if(c)for(var m=c.split(","),_=0;_<m.length;_++){var f=parseInt(m[_]);switch(f){case 1:(1e9>r||r>9999999999)&&(p=e+" "+messages[defaultLanguage].formErrors.SHOULD_BE_10_DIGITS)}}switch(o){case 1:r.trim()||(p=messages[defaultLanguage].formErrors.INVALID+" "+e);break;case 2:var g=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;g.test(r)||(p=messages[defaultLanguage].formErrors.INVALID+" "+e);break;case 3:_P._isValidMobileNumber(r)||(p=e+" "+messages[defaultLanguage].formErrors.INVALID_PHONE)}}else;else p=e+" "+messages[defaultLanguage].formErrors.CANT_BE_BLANK;p&&(i=!0,$("#error-"+a).text(p),$("#error-"+a).show(),$(this).addClass("error-input")),p||($(this).removeClass("error-input"),$("#error-"+a).text(""),$("#error-"+a).hide())}),i)return!1;var o=n.serialize(),a=n.serializeArray(),r=_P._getConnectoStorage(),s=_P._getConnectoLogs(),c=_P._readCookie("__utmz"),l={},d=_P._readAllCookies(l),p=nObj._id||nObj.id;o+="&_CO_notification_id="+encodeURIComponent(p),o+="&_CO_source="+encodeURIComponent(window.top.location.href),o+="&_CO_token="+encodeURIComponent(submissionToken),o+="&_CO_form_stage="+encodeURIComponent(formStage),isFirstSubmit&&(r&&(r.source&&(o+="&_CO_referer="+encodeURIComponent(r.source)),r.landing_page&&(o+="&_CO_landing_page="+encodeURIComponent(r.landing_page))),parent._TConnecto&&parent._TConnecto.getVariables()&&(o+="&_CO_custom_variables="+encodeURIComponent(JSON.stringify(parent._TConnecto.getVariables()))),s&&(o+="&_CO_logs="+encodeURIComponent(JSON.stringify(s))),c&&(o+="&_CO_utmz="+encodeURIComponent(c)),d&&(o+="&_CO_first_party_cookies="+encodeURIComponent(JSON.stringify(l))),_P._logEvent("Click"),_P._visitConnectActionURL(1)),submitted[t]=1;var m=nObj.showThankYouMessageFor;return(!m||1e3>m)&&(m=1e3),$.ajax({type:"POST",url:"https://server.connecto.io/submit?source="+encodeURIComponent(window.top.location.href)+"&notification="+encodeURIComponent(p),data:o}).done(function(){_P._logEvent("Submit"),setTimeout(function(){_P._submitCompleted(t,e)},m),_P._postSubmit(a),_P._showNext()}),setTimeout(function(){_P._submitCompleted(t,e)},m+2e3),!1},init=function(t,e,n,i){var o=parent._TConnecto,a=o.getMessage(t);if(a&&a.segment&&a.segment.windowStart){var r=[];try{r=JSON.parse(localStorage.getItem("_Connecto")).events}catch(s){}if(r.length>0)for(var c=864e5,l=Math.floor((new Date).getTime()/c),d=l-a.segment.windowStart,p=l-a.segment.windowEnd,m=0;m<r.length;m++){var _=Math.floor(new Date(r[m].timestamp).getTime()/c);(d>_||_>p)&&r.splice(m,1)}}if((!r||o.userLiesInSegment(a.segment,r))&&(nObj=a.notification,submissionToken=_P._uid(),topUrlLoaded=void 0!==e&&null!==e?e:!1,notificationClosed=void 0!==n&&null!==n?n:!0,notificationMinimized=void 0!==i&&null!==i?i:!1,parent.document.getElementById("connecto-modal-overlay-"+nObj._id)&&nObj.closeWidgetOnBackgroundClick&&parent.document.getElementById("connecto-modal-overlay-"+nObj._id).addEventListener("click",closeWidget),oldParentBodyPaddingTop=window.getComputedStyle(parent.document.body,null).getPropertyValue("padding-top"),oldParentBodyPaddingBottom=window.getComputedStyle(parent.document.body,null).getPropertyValue("padding-bottom"),nObj.staticElement)){displayStyle="block";var f=parent.document.getElementById("container-notification-element-"+nObj._id+"-frame");f&&(f.style.display=displayStyle)}},initLandingPage=function(t){nObj=t,submissionToken=_P._uid(),openWidget()};