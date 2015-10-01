<?php /* COMPANIES $Id: ae_batching_maintenance.php 2013-01-08  ChrisHaas $ */
if (!defined('DP_BASE_DIR')) {
    die('You should not access this file directly.');
}

##
##	Companies: Edit Batching Maintenance
##
global $AppUI;

$company_id = intval(dPgetParam($_GET, 'company_id', 0));
$sql="SELECT * FROM company_report_downloads WHERE company_id='$company_id' AND  pdf_type='au'";
$rows = db_loadList($sql, NULL);

// format dates
$df = $AppUI->getPref('SHDATEFORMAT');

$rownum = 1;

// function renamed to avoid naming clash


// setup the title block
// $titleBlock = new CTitleBlock('Batching Maintenance Report Download History', 'handshake.png', $m, "$m.$a");
// if ($canEdit) {
//     $titleBlock->addCell();
// }
// $titleBlock->addCrumb('?m=companies', 'company list');
// if ($canEdit) {
//     $titleBlock->addCrumb(('?m=companies&amp;a=view&amp;company_id=' . $company_id), 'view this company');
// }
// $titleBlock->show();

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
<br><br>

<table width="50%" class="tbl">
    <th>File Name</th>
    <th>Date Time</th>
    <th>User Id</th>

    <?php
    $i=0;
    global $baseUrl;
    foreach($rows as $row):
        $downloaded_on=date("m/d/Y h:i A",strtotime($row['downloaded_on']));
        $file_name=basename($row['pdf_link']);
        $pdf_link=$baseUrl.$row['pdf_link'];
        $pdf="<a href='$pdf_link' target='_blank'>$file_name</a>";
        echo"<tr><td>$pdf</td><td>$downloaded_on</td><td>{$row['user_id']}</td></tr>";
    $i++;
    endforeach;
    if(!$i)
    echo "<tr><td colspan='3'><font color='red'>No Records found !</font></td></tr>";
    ?>


</table>


<style>
    .tbl td{
        text-align:center;
    }
</style>
