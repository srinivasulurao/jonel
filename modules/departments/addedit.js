// $Id: addedit.js 2013-01-05 chrishaas $
var calendarField = '';

function popCalendar(field){
	calendarField = field;
	dept_cal = document.getElementById('dept_' + field.name);
	idate = dept_cal.value;
	window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');
}

/**
 *	@param string Input date in the format YYYYMMDD
 *	@param string Formatted date
 */
function setCalendar(idate, fdate) {
	fld_date = document.getElementById('dept_' + calendarField.name);
	calendarField.value = fdate;
	fld_date.value = idate;
}
