<?php /* COMPANIES $Id: ae_batching_maintenance.php 2013-01-08  ChrisHaas $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

##
##	Companies: Edit Batching Maintenance
##

global $AppUI;

$company_id = intval(dPgetParam($_GET, 'company_id', 0));

$q  = new DBQuery;
$q->addTable('departments','dept');
$q->addQuery('dept.*');
$q->addWhere('dept.dept_company = '.$company_id);
$q->addGroup('dept.dept_id');
$q->addOrder('dept.dept_parent, dept.dept_name');
$sql = $q->prepare();
$q->clear();
$rows = db_loadList($sql, NULL);

// format dates
$df = $AppUI->getPref('SHDATEFORMAT');

$rownum = 1;

// function renamed to avoid naming clash
function showchilddept_maintenance(&$a, $level=0) {
	global $AppUI, $df, $rownum;
        
        if (strlen($a["dept_batching_maintenance"]) == 0) {
            $batching_expire_date = null;
        } else {
            $batching_expire_date = new CDate($a["dept_batching_maintenance"]);
        }
        
        

	$s .= ('<td align="center"><a href="?m=departments&amp;a=view&amp;dept_id=' . $a['dept_id'] . '">'
	       . $a['dept_name'] . '</a>');
        $s .= '<input type="hidden" name="dept_id[]" id="dept_id' . $rownum . '" value="' . $a['dept_id'] . '" />';
	$s .= '</td>';
	$s .= '<td align="center"> <input type="text" class="text" name="batching_maintenance[]" id="batching_maintenance' . $rownum . '" disabled="disabled" value="' . (($batching_expire_date) ? $batching_expire_date->format($df) : '') . '"/>';
        $s .= '<input type="hidden" name="dept_batching_maintenance[]" id="dept_batching_maintenance' . $rownum . '" value="' . (($batching_expire_date) ? $batching_expire_date->format(FMT_TIMESTAMP_DATE) : '') . '" />';
        $s .= '<a href="#" onclick="javascript:popCalendar(getRow(event))"> <img src="./images/calendar.gif" name="img_expiredate" width="24" height="12" alt="' . $AppUI->_('Calendar') . '" border="0" /></a>';
        $s .= '</td>';
    $calAdder='<a href="javascript:void(0)" onclick="javascript:popCalendarAccept(getRow(event))"> <img src="./images/calendar.gif" name="img_expiredate2" width="24" height="12" alt="' . $AppUI->_('Calendar') . '" border="0" /></a>';
    $last_report_generation_date=($a['last_report_generation_date']=="0000-00-00 00:00:00")?"Not Generated Yet":date("d/M/Y",strtotime($a['last_report_generation_date']));
    $last_report_accept_date=date("d/M/Y",strtotime($a['last_report_accept_date']));
    $last_report_accept_date_hidden=date("Ymd",strtotime($a['last_report_accept_date']));
    $s.="<td align='center'>$last_report_generation_date</td><td align='center'><input class='text' id='last_report_accept_date_hidden$rownum' name='last_report_accept_date_hidden[]' value='$last_report_accept_date_hidden' type='hidden'><input type='text' name='last_report_accept_date[]' id='last_report_accept_date$rownum' class='text' value='$last_report_accept_date' disabled>$calAdder</td>";
	
	echo '<tr>' . $s . '</tr>';
        $rownum = $rownum + 1;
}

function updateEmptyAcceptDate($dept_id,$expiration_date){
    global $db;
    $fill_accept_date=date("Y-m-d H:i:s",(strtotime($expiration_date)-(365*24*3600)));
    $sql="UPDATE departments SET last_report_accept_date='$fill_accept_date' WHERE dept_id='$dept_id'";
    $db->Execute($sql);
}
// function renamed to avoid naming clash
function findchilddept_maintenance(&$tarr, $parent, $level=0) {
	$level = $level+1;
	$n = count($tarr);
	for ($x=0; $x < $n; $x++) {
		if ($tarr[$x]['dept_parent'] == $parent 
		    && $tarr[$x]['dept_parent'] != $tarr[$x]['dept_id']) {
			showchilddept_maintenance($tarr[$x], $level);
			findchilddept_maintenance($tarr, $tarr[$x]['dept_id'], $level);
		}
	}
}

// setup the title block
$titleBlock = new CTitleBlock('Edit Batching Maintenance', 'handshake.png', $m, "$m.$a");
if ($canEdit) {
	$titleBlock->addCell();
}
$titleBlock->addCrumb('?m=companies', 'company list');
if ($canEdit) {
	$titleBlock->addCrumb(('?m=companies&amp;a=view&amp;company_id=' . $company_id), 
	                      'view this company');
}
$titleBlock->show();

?>

<script language="javascript">

function isRow(e1) {
    return e1.tagName.match(/tr/i);
}

function getRow(e) {
    e = e || event;
    if (e != null) {
        var eventE1 = e.srcElement || e.target;
        var parent = eventE1.parentNode;
    }
    
    while (parent) {
        if (isRow(parent)) {
            return parent.rowIndex;
        } else {
            parent = parent.parentNode;
        }
    }
    return 0;
}

var calendarField = '';
var calendarFields = '';
var fld_date = '';

function popCalendar(rownum){
    if (rownum > 0) {       
        calendarField = document.getElementById("batching_maintenance" + rownum);
	fld_date = document.getElementById("dept_batching_maintenance" + rownum);
	idate = fld_date.value;
	window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');
    recordEditting(rownum);
    }
}

function popCalendarAccept(rownum){

    if (rownum > 0) {
        calendarField = document.getElementById("last_report_accept_date" + rownum);
        fld_date = document.getElementById("last_report_accept_date_hidden" + rownum);
        idate = fld_date.value;
        window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');
    }
}
    
/**
 *	@param string Input date in the format YYYYMMDD
 *	@param string Formatted date
 */
function setCalendar(idate, fdate) {
	calendarField.value = fdate;
	fld_date.value = idate;
}

function popCalendarAll() {
    calendarFields = document.getElementsByName("batching_maintenance[]");
    fld_dates = document.getElementsByName("dept_batching_maintenance[]");
    idate = fld_dates[0].value;
    window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendarAll&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');    
}

function setCalendarAll(idate, fdate) {
    //for (var i in calendarFields) {
    for (var i=0; i < calendarFields.length; i++) {
        calendarFields[i].value = fdate;
        fld_dates[i].value = idate;
    }
}

function submitIt(form) {
	form.submit();
}

function recordEditting(rownum){
  batch_expiration_touched_values=document.getElementById('batch_expiration_touched').value;
  document.getElementById('batch_expiration_touched').value=batch_expiration_touched_values+":"+(parseInt(rownum)-parseInt(1));
}

</script>

<form action="?m=companies" method="post" name="editBatchMaintenanceFrm">
    <input name="dosql" type="hidden" value="do_batching_maintenance_aed" />
    <input name="batch_expiration_touched" id='batch_expiration_touched' type="hidden" value="" />
<?php
$s = '<table width="75%" border="0" cellpadding="2" cellspacing="1" class="tbl" summary="view departments">';
$s .= '<tr>';
//$rows = db_loadList($sql, NULL);
if (count($rows)) {
	$s .= '<th width="25%">'.$AppUI->_('Name').'</th>';
	$s .= '<th width="25%">'.$AppUI->_('Expires').'</th>';
    $s .='<th width="25%">'.$AppUI->_('Report Generation Date').'</th>';
    $s .='<th width="25%">'.$AppUI->_('Accepted Date').'</th>';
} else {
	$s .= '<td>' . $AppUI->_('No data available') . '</td>';
}

$s .= '</tr>';
echo $s;

foreach ($rows as $row) {
	if ($row['dept_parent'] == 0) {

        if($row['last_report_accept_date']=="0000-00-00 00:00:00")
        @updateEmptyAcceptDate($row['dept_id'],$row['dept_batching_maintenance']);

		showchilddept_maintenance($row);
		findchilddept_maintenance($rows, $row['dept_id']);
	}
}

echo ('<tr>');
if ($canEdit) {
    $confirm = "if(confirm('Are you sure?')){location.href = 'index.php?" . $AppUI->getPlace() . "'}";
    echo ('<td>'.$AppUI->_('Update All Plants'));
    echo ('<a href="#" onclick="javascript:popCalendarAll()"> <img src="./images/calendar.gif" name="img_expiredate" width="24" height="12" alt="' . $AppUI->_('Calendar') . '" border="0" /></a></td>');
    echo ('<td colspan="3" nowrap="nowrap" rowspan="0" align="right" valign="top"' . ' style="background-color:#ffffff">');
    echo ('<input class="button" type="button" name="cancel" value="' . $AppUI->_('cancel') . '" onclick="javascript:' . $confirm . '" />');
    echo ('<input class="button" type="button" name="btnFuseAction" value="' . $AppUI->_('save') . '" onclick="javascript:submitIt(document.editBatchMaintenanceFrm);" />');
}
echo ('</td></tr>');
$maintenance_link="index.php?m=companies&a=batching-maintenance-report&company_id=".$_REQUEST['company_id'];
echo"<tr><td colspan='6' align='right'><a href='$maintenance_link' class='button' style='text-decoration:none;padding:1px 5px'>Maintenance</a></td></tr>";
echo ('</table>');
?>
</form>

<?php
// echo"<pre>";
// print_r($AppUI);
// echo"</pre>";
?>
