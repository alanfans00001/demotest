<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/views/com/commonctrl.inc"%>
<script type="text/javascript">
	/*(function($) {
		$('#collapseModal').modal({
			"backdrop" : true,
			"keyboard" : true,
			"show" : true,
			"remote" : ""
		});
	})(jQuery);
	jQuery(document).ready(function() {
		jQuery('.hasTooltip').tooltip({
			"container" : false
		});
	});
	window.addEvent('domready', function() {
		new Joomla.JMultiSelect('adminForm');
	});
	(function($) {
		$(document).ready(function() {
			$('.has-context').mouseenter(function() {
				$('.btn-group', $(this)).show();
			}).mouseleave(function() {
				$('.btn-group', $(this)).hide();
				$('.btn-group', $(this)).removeClass('open');
			});

			contextAction = function(cbId, task) {
				$('input[name="cid[]"]').removeAttr('checked');
				$('#' + cbId).attr('checked', 'checked');
				Joomla.submitbutton(task);
			}
		});
	})(jQuery);

	jQuery(document).ready(function() {
		jQuery('select').chosen({
			disable_search_threshold : 10,
			allow_single_deselect : true
		});
	});*/
</script>
<script type="text/javascript">
	(function() {
		var strings = {
			"JGLOBAL_SELECT_SOME_OPTIONS" : "Select some options",
			"JGLOBAL_SELECT_AN_OPTION" : "Select an option",
			"JGLOBAL_SELECT_NO_RESULTS_MATCH" : "No results match"
		};
		if (typeof Joomla == 'undefined') {
			Joomla = {};
			Joomla.JText = strings;
		} else {
			Joomla.JText.load(strings);
		}
	})();
</script>



<ul id="submenu" class="nav nav-list">
	<c:forEach items="${sessionScope.account_menu_key}" var="menu">
		<c:if test="${menu.menutype=='1' && menu.menuurl==OTT_URL}">
			<c:forEach items="${sessionScope.account_menu_key}" var="subMenu">
				<c:if test="${subMenu.menutype=='1' && subMenu.fathermenuno==menu.fathermenuno}">							
					<li <c:if test="${subMenu.menuurl==OTT_URL}">class="active"</c:if>>
						<a href="${OTT_ROOT}${subMenu.menuurl}">${subMenu.menuname}</a>
					</li>
				</c:if>
			</c:forEach>
		</c:if>
	</c:forEach>
</ul>