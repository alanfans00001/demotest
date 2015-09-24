var _common={
	/**
	 * 获取网站根路径
	 */
	getWebRootPath:function(){
	    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	    var curWwwPath=window.document.location.href;
	    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	    var pathName=window.document.location.pathname;
	    var pos=curWwwPath.indexOf(pathName);
	    //获取主机地址，如： http://localhost:8083
	    var localhostPaht=curWwwPath.substring(0,pos);
	    //获取带"/"的项目名，如：/uimcardprj
	    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	    return(localhostPaht+projectName);
	},
	/**
	 * 获取滚动条距离顶部的高度
	 */
	getScrollTop:function() {
	    if ('pageYOffset' in window) {
	        return window.pageYOffset;
	    } else if (document.compatMode == "BackCompat") {
	        return document.body.scrollTop;
	    } else {
	        return document.documentElement.scrollTop;
	    }
	},
	/**
	 * 判断浏览器
	 */
	getObserve:function(){
		if(navigator.userAgent.indexOf("MSIE")>0) { 
			if(navigator.userAgent.indexOf("MSIE 9")<0){
				alert('建议IE内核的浏览器请使用IE9.0以上版本，以便获得更好的视觉效果！');
			}
		} 
	},
	/**
	 * 显示实体新增或者修改的错误信息
	 */
	showEditedErrorMsg:function(msg){
		$('#system-message-container').children('button').click();
	  	
	  	var div=$('#system-message-container-backup').clone();
		$(div).attr('id','system-message-container');
	  	$(div).css({'display':'block'});	
	  	$(div).children('div[class="alert"]').addClass('alert-error');	
	  	$(div).find('p').html(msg);
	  	
		$('#system-message-container-backup').after($(div));
	}
};

/**
 * 将表单内的元素按照name属性封装为json实体
 */
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

/**
 * cookie操作
 * 
 * example $.cookie('name', 'value');
 * 设置cookie的值，把name变量的值设为value
 * example $.cookie('name', 'value', {expires: 7, path: '/', domain: 'jquery.com', secure: true});
 * 新建一个cookie 包括有效期 路径 域名等
 * example $.cookie('name', 'value');
 * 新建cookie
 * example $.cookie('name', undefined);
 * 删除一个cookie
 * var account= $.cookie('name');
 * 取一个cookie(name)值给account
 * @param name cookie的键
 * @param value cookie的值
 * @param options cookie的选项
 * @returns
 */
$.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};
/*
return  {

	//wrapper function to  block element(indicate loading)
	blockUI: function (el, centerY) {
	 var el = jQuery(el); 
	 el.block({
	         message: '<img src="'+OTT_ROOT+'/views/image/ajax-loading.gif" align="">',
	         centerY: centerY != undefined ? centerY : true,
	         css: {
	             top: '10%',
	             border: 'none',
	             padding: '2px',
	             backgroundColor: 'none'
	         },
	         overlayCSS: {
	             backgroundColor: '#000',
	             opacity: 0.05,
	             cursor: 'wait'
	         }
	     });
	},

	//wrapper function to  un-block element(finish loading)
	unblockUI: function (el) {
	 jQuery(el).unblock({
	         onUnblock: function () {
	             jQuery(el).removeAttr("style");
	         }
	     });
	},

}
*/

/**
 * 测试
 */
$(document).ready(function(){
	_common.getObserve();
});