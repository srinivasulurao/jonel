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
// echo "<pre>";
// print_r($rows);
// echo "<pre>";
// format dates
$df = $AppUI->getPref('SHDATEFORMAT');

$rownum = 1;


//this will give us the new contract date if the company contract date is expired.
function getExactContractBeginDate($given_time){
    $company_id=$_REQUEST['company_id'];
    $sql="SELECT application_date from companies WHERE company_id='$company_id'";
    $rows=db_loadList($sql, NULL);
    $au_expiration_date=$rows[0]['application_date'];
    $before_one_year=date("m/d/Y",(strtotime($au_expiration_date)-(3600*24*365)));
    $present_given_time=date("m/d/Y",strtotime($given_time)); //client is kind of confused.
    return (strtotime($au_expiration_date) > strtotime($given_time))?date("m/d/Y",strtotime($given_time)):$present_given_time;
}
// function renamed to avoid naming clash





function showchilddept_maintenance(&$a, $level=0) {
	global $AppUI, $df, $rownum;
        
        if (strlen($a["dept_batching_maintenance"]) == 0) {
            $batching_expire_date = null;
        } else {
            $batching_expire_date = new CDate($a["dept_batching_maintenance"]);
        }

	$s .= ('<td><a href="?m=departments&amp;a=view&amp;dept_id=' . $a['dept_id'] . '">' 
	       . $a['dept_name'] . '</a>');
        $s .= '<input type="hidden" name="dept_id[]" id="dept_id' . $rownum . '" value="' . $a['dept_id'] . '" />';
	$s .= '</td>';
	$s .= '<td> <input type="text" class="text" name="batching_maintenance[]" id="batching_maintenance' . $rownum . '" disabled="disabled" value="' . (($batching_expire_date) ? $batching_expire_date->format($df) : '') . '"/>';
        $s .= '<input type="hidden" name="dept_batching_maintenance[]" id="dept_batching_maintenance' . $rownum . '" value="' . (($batching_expire_date) ? $batching_expire_date->format(FMT_TIMESTAMP_DATE) : '') . '" />';
        $s .= '<a href="#" onclick="javascript:popCalendar(getRow(event))"> <img src="./images/calendar.gif" name="img_expiredate" width="24" height="12" alt="' . $AppUI->_('Calendar') . '" border="0" /></a>';
        $s .= '</td>';
        $dept_checked=(time() > strtotime($a['dept_batching_maintenance']))?"checked='checked'":""; //checked for expired dept.
        $s .= "<td align='center'><input type='checkbox' value='{$a['dept_id']}' $dept_checked name='select_dept[]'></td>";
	
	echo '<tr>' . $s . '</tr>';
        $rownum = $rownum + 1;
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
$titleBlock = new CTitleBlock('Batching Maintenance Report', 'handshake.png', $m, "$m.$a");
if ($canEdit) {
	$titleBlock->addCell();
}
$titleBlock->addCrumb('?m=companies', 'company list');
if ($canEdit) {
	$titleBlock->addCrumb(('?m=companies&amp;a=view&amp;company_id=' . $company_id), 'view this company');
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
    }
}


function popCalendar2(){
        calendarField = document.getElementById("contract_begin_date");
        fld_date = document.getElementById("contract_begin_date_hidden");
        idate = fld_date.value;
        window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');

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

function showCalendar(did){
    calendarField = document.getElementById(did);
	fld_date = document.getElementById(did);
	idate = fld_date.value;
	window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');
}

</script>
<?php @include_once("pdf-report-generator.php"); ?>
<form action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post" names="editBatchMaintenanceFrm">
<!--    <input name="dosql" type="hidden" value="do_batching_maintenance_aed" />-->
<?php
$s = '<table width="50%" border="0" cellpadding="2" cellspacing="1" class="tbl" summary="view departments">';
$s .= '<tr>';
//$rows = db_loadList($sql, NULL);
if (count($rows)) {
	$s .= '<th width="30%">'.$AppUI->_('Name').'</th>';
	$s .= '<th width="40%">'.$AppUI->_('Expires').'</th>';
	$s .="<th width='30%'>".$AppUI->_('Include Department').'</th>';
} else {
	$s .= '<td>' . $AppUI->_('No data available') . '</td>';
}

$s .= '</tr>';
echo $s;

foreach ($rows as $row) {
	if ($row['dept_parent'] == 0) {
		showchilddept_maintenance($row);
		findchilddept_maintenance($rows, $row['dept_id']);
	}
}

echo ('<tr>');
if ($canEdit) {
    $confirm = "if(confirm('Are you sure?')){location.href = 'index.php?" . $AppUI->getPlace() . "'}";
    echo ('<td>');
    //echo ('<a href="#" onclick="javascript:popCalendarAll()"> <img src="./images/calendar.gif" name="img_expiredate" width="24" height="12" alt="' . $AppUI->_('Calendar') . '" border="0" /></a></td>');
    echo ('<td colspan="1" nowrap="nowrap" rowspan="0" align="right" valign="top"' . ' style="background-color:#ffffff">');
    echo ('<input class="button" type="button" name="cancel" value="' . $AppUI->_('cancel') . '" onclick="javascript:' . $confirm . '" />');
    //echo ('<input class="button" type="button" name="btnFuseAction" value="' . $AppUI->_('save') . '" onclick="javascript:submitIt(document.editBatchMaintenanceFrm);" />');
}
echo ('</td><td align="center">'."<input type='button' class='button' value='ALL' onclick='checkAll()'> &nbsp <input type='button' class='button' value='None' onclick='checkNone()'></td>");
echo "</tr>";
echo ('</table>');
?>
<br><br>
    <table>
        <tr><td>
<label style='margin-left:100px;'>Contract Begin Date</label>&nbsp <input required="" type='text' readonly=\"readonly\" value='<?php echo date("d/M/Y",time());?>' name='contract_begin_date' id='contract_begin_date'><a  href="javascript:void(0)" onclick="javascript:popCalendar2()"> <img src="./images/calendar.gif" name="img_expiredate" width="24" height="12"  border="0" /></a>
<input type="hidden" name="contract_begin_date_hidden" id="contract_begin_date_hidden" value="<?php echo date("Ymd",time());?>">
                <input class='button' type='button' value='Refresh' onclick="window.location=''">
            </td></tr>
    </table>
<br>
<div style='text-align:center;width:50%;margin-top:20px'>
<input type='submit' name='print_maintenance_report' value="PRINT" class='button'>
</div>
</form>

<?php
// echo"<pre>";
// print_r($AppUI);
// echo"</pre>";
?>


<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'></script>
<script>
    function checkAll(){
        // $("input[type='checkbox']").each(function(){
        //    $(this).attr('checked',true);
        // });


  var checkboxes = new Array(); 
  checkboxes = document.getElementsByTagName('input');
 
  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox')   {
      checkboxes[i].checked = true;
    }
  }

    }

    function checkNone(){
        $("input[type='checkbox']").each(function(){
            $(this).removeAttr('checked');
        });
    }
</script>