var fb_test_link=window.location.href;$('#facebookShareId').click(function(event){var width=600,height=600,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="https://www.facebook.com/sharer/sharer.php?u="+fb_test_link,opts='status=1'+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;});$('#twitterShareId').click(function(event){var width=600,height=600,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="http://twitter.com/share?url="+fb_test_link,opts='status=1'+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;});$('#gPlusShareId').click(function(event){var width=600,height=600,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="https://plus.google.com/share?url="+fb_test_link,opts='menubar=no'+',toolbar=no'+',resizable=yes'+',scrollbars=yes'+',width='+width+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;});function shareOnGooglePlus(url,height,width){var width=width,height=height,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="https://plus.google.com/share?url="+url,opts='menubar=no'+',toolbar=no'+',resizable=yes'+',scrollbars=yes'+',width='+width+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;}function shareOnFacebook(url,height,width){var width=width,height=height,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="https://www.facebook.com/sharer/sharer.php?u="+url,opts='status=1'+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;}function shareOnTwitter(url,height,width){var width=width,height=height,left=($(window).width()-width)/2,top=($(window).height()-height)/2,url="http://twitter.com/share?url="+url,opts='status=1'+',width='+width+',height='+height+',top='+top+',left='+left;window.open(url,'twitter',opts);return false;}function shareOnWhatsApp(elementId){if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)){var text=$('#'+elementId).attr("data-text");var url=$('#'+elementId).attr("data-link");var message=encodeURIComponent(text)+" - "+encodeURIComponent(url);var whatsapp_url="whatsapp://send?text="+message+"&utm_source=articledetail&utm_medium=whatsapp&utm_campaign=mobtraffic";window.location.href=whatsapp_url;}else{alert("Please use an Mobile Device to Share this Article");}}function shareByWhatsApp(){var url=$("#share-url").val();if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)){var text=$("#share-url-text").val();var message=encodeURIComponent(text)+" - "+encodeURIComponent(url);var whatsapp_url="whatsapp://send?text="+message+"&utm_source=articledetail&utm_medium=whatsapp&utm_campaign=mobtraffic";window.location.href=whatsapp_url;}else{alert("Please use an Mobile Device to Share this Article");}}