<?php
ob_start();
$root_url=$baseUrl;
$company_id=$_REQUEST['company_id'];
$sql=batchMaintenanceQuery($company_id);
$batching_maintenance =(object)@db_loadList($sql, NULL);


//Have to generate use the heredoc style to accomplish the task
## Have to use pure inline css.

function getCompany($company_id){
    $sql="SELECT * FROM companies WHERE company_id='{$company_id}'";
    $company=@db_loadList($sql);
    return $company[0];
}

function debug($ao){
echo"<pre>";
print_r($ao);
echo"</pre>";
}


function getContractEndDate($start_date){
$start_timestamp=strtotime($start_date);
$end_timestamp=$start_timestamp+(3600*24*365);
$now_timestamp=time();
if($end_timestamp > $now_timestamp)
    return date("m/d/Y",$end_timestamp);
else
    return getContractEndDate(date("m/d/Y",$end_timestamp));
}

//Query generated from the view given by the client.
function batchMaintenanceQuery($company_id){
    $limitDate=date("Y",time())."-12-31";
    $sql="select d.dept_id,`c`.`company_name` AS `Company`,left(`d`.`dept_name`,5) AS `Batching_Serial_Number`,ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) AS `Plant_Name`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 1 day) else (last_day(`d`.`dept_batching_maintenance`) + interval 1 day) end) AS `Start_Date`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 12 month) else (last_day(`d`.`dept_batching_maintenance`) + interval 12 month) end) AS `End_Date`,`d`.`dept_url` AS `Amount`,`c`.`company_address1` AS `Company_Address1`,`c`.`company_address2` AS `Company_address2`,`c`.`company_city` AS `Company_City`,`c`.`company_state` AS `Company_State`,`c`.`company_zip` AS `Company_Zip`,`c`.`company_phone1` AS `Company_Phone` from (`departments` `d` join `companies` `c`) where ((`d`.`dept_company` = `c`.`company_id`) and (`c`.`company_type` = 1) and (`d`.`dept_batching_maintenance` < '$limitDate') and (`d`.`dept_url` <> '0')) AND c.company_id='{$company_id}' order by `c`.`company_name`";
    return $sql;
}

$today_date=date("m/d/Y");
$company_details=getCompany($company_id);
$company_name=$company_details['company_name'];
$company_address=implode(", ",array($company_details['company_address1'],$company_details['company_address2'],$company_details['company_city'],$company_details['company_state'],$company_details['company_zip']));
$company_address=str_replace(", , ",", ",$company_address);
//$contract_begin_date=date("m/d/Y",strtotime($_POST['contract_begin_date_hidden']));
$contract_begin_date=getExactContractBeginDate($_POST['contract_begin_date_hidden']);
$contract_end_date=getContractEndDate($contract_begin_date);
$department_rows="";



$annual_total=0;
//debug($batching_maintenance);
foreach($batching_maintenance as $bm):
    $dept_start_timestamp=strtotime($bm['Start_Date']);
    $contract_begin_date_timestamp=strtotime($contract_begin_date);
    //if($dept_start_timestamp >= $contract_begin_date_timestamp && in_array($bm['dept_id'],$_POST['select_dept'])):
    if(in_array($bm['dept_id'],$_POST['select_dept'])):
    $department_rows.="<tr><td>{$bm['Batching_Serial_Number']}</td><td>{$bm['Plant_Name']}</td><td>".number_format($bm['Amount'],2)."</td></tr>";
    $annual_total+=$bm['Amount'];
    ####We have to update the last report generated for this department.
    $update_last_generated_report_sql="UPDATE departments set last_report_generation_date='".date("Y-m-d H:i:s",time())."' WHERE dept_id='{$bm['dept_id']}'";
    $db->Execute($update_last_generated_report_sql);
    endif;
endforeach;
if(!$annual_total){
    $department_rows.='<tr><td colspan="3" style="color:red" align="center">Sorry, No Records found!</td></tr>';
}

$annual_total=number_format($annual_total,2);


//debug($company_details);
$page1= <<<EOD
<div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
<table border="0" style="font-family:arial;width:100%;font-size:14px">
<tr><td width="30%" ><img width="220" src="$root_url/modules/companies/images/jonel_logo.jpg"><br><br><span style="font-size:14px">500E.Walnut <br>Fullerton, CA 92832</span></td>
<td width="78%" style="vertical-align:top;font-size:12px;align:right">
<table width='100%'>
<tr><td align="right"><b style="display:inline-block;width:100px;text-align:right">Date :</b></td><td align="left"> $today_date</td></tr>
<tr><td align="right"><b style="display:inline-block;width:100px;text-align:right">Customer :</b></td><td align="left"> $company_name</td></tr>
<tr><td align="right"><b style="display:inline-block;width:100px;text-align:right">Address :</b></td><td align="left"> $company_address</td></tr>
</table>
</td></tr>
</table><br><br>
<table width="100%" cellpadding="7">
<tr style="color:black;background-color:grey;font-size:20px;border:1px solid black">
<th><br>MAINTENANCE SUPPORT AGREEMENT - $company_name</th></tr>
</table>
<p style="font-size:14px;line-height:20px;">
This document describes and identifies the Service Agreement terms and conditions, which includes a non-exclusive, non-transferable subscription for support and
maintenance of the following computer System(s), under the terms and conditions set forth below:<br><br>
<table width="100%" border="0">
<tr><td><b>Subscriber Begin Date :</b> <span style="display:inline-block;width:150px;"> $contract_begin_date</span></td>
<td><b>Subscriber End Date :</b> <span style="display:inline-block;width:150px;"> $contract_end_date</span></td></tr>
</table>
<p style="font-size:14px;line-height:20px;">
Listed below are the Archer, Advantage or Blockmate Batching Controller (ABC) Serial Number(s) of the system(s) eligible to be covered within this agreement.
</p>
<table style="width:100%;" cellpadding="5" border='1' >
<tr style="background-color:grey;color:white"><th align="left" width="30%">System Number</th><th align="left" width="50%">Plant</th><th align="left" width="20%">Annual Amount</th></tr>
$department_rows
<tr style="background-color:grey;color:black"><th> </th><th><b>Total</b></th><th align="left">$annual_total</th></tr>
</table>
</div>
EOD;



$page2= <<<EOD
<div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
<table width="100%" cellpadding="7">
<tr style="color:black;background-color:grey;font-size:20px;border:1px solid black">
<th><br>MAINTENANCE SUPPORT SERVICE AGREEMENT</th></tr>
</table>
<br><br>
<table width="100%" style="line-height:20px;margin-top:20px" cellpadding="5">
<tr><td style="font-size:14px;"><u>Phone Service</u> :<br>All toll free service line has been established to recieve all incoming service and technical calls.
The service window is available twenty-four hours a day, seven days per week.
</td></tr>

<tr><td style="font-size:14px;"><u>Jonel Remote Support Tool</u> :<br>Plants that have access to the internet can be connected to our support team instantaneously to help operators
troubleshoot issues as well as train on new system features.
</td></tr>

<tr><td style="font-size:14px;"><u>Software Upgrades</u> :<br>Software version upgrades will be released periodically. Standard version upgrades, updates and bug fixes are included under this contract.
</td></tr>

<tr><td style="font-size:14px;"><u>Parts Discounts</u> :<br>A twenty percent (20%) discount will be given on all computer parts with the exception of peripherals
(PC's, printers, moisture probes, short haul modems etc).This includes I/O, CPU and A/D boards.
</td></tr>

<tr><td style="font-size:14px;"><u>Program Modification Discount</u> :<br>Programming and labor charges are $140.00 per hour. A twenty dollar ($20.00) discount per hour on labor and
program changes will be given to all systems contained within this agreement.<br><br>
All Customers declining maintenance will be charged $240.00 per hour in half-hour increments for phone service. A purchase order number will be required before service are provided.
</td></tr>

</table>
<br><br><br>
<h1 style="margin-top:30px;font-size:22px;color:black;font-weight:40px"><u>AUTHORIZATION</u></h1><br>
<p style="font-size:14px;line-height:20px;">
IN WITNESS WHERE OF, the parties have executed this Agreement as of the day and year written below, each representing that they have actual authority to do so.
</p>
<table style="width:100%;font-size:14px;" cellpadding="0" cellspacing="0">
<tr>
<td colspan="4" style="height:20px"></td>
</tr>
<tr>
<td colspan="4" style="height:20px"></td>
</tr>
<tr>
<td style="font-size:12px;width:35%">________________________________<br><label>On Behalf of</label></td>
<td style="font-size:13px;width:15%"><label>Date</label>:_______</td>
<td style="font-size:13px;width:35%">______________________________<br><label>On Behalf of Jonel Engineering</label></td>
<td style="font-size:13px;width:15%"><label>Date</label>:_______</td>
</tr>
<tr>
<td colspan="4" style="height:20px"></td>
</tr>
<tr>
<td colspan="2" style="font-size:13px;">__________________________________<br><label>Please Print Name On Line Above</label> </td>
<td width="3.5%"></td>
<td  style="font-size:13px;width:90%" ><br><div style="display:none;border:1px solid black;padding:10px !important;"><b> Please Fax to: </b>(714)526-2397 - Attn : Judy<br> Or scan signed copy and email  to: <b>judyL@jonel.com</b></div>
<br><table cellpadding="5" width="50%" style="float:right;border:1px solid black;font-size:11px;">
<tr><td> <b>Please Fax to: </b>(714)526-2397 - Attn : Judy</td></tr>
<tr><td> Or scan signed copy and email  to: <b>judyL@jonel.com</b></td></tr>
</table>
</td>
</tr>

</table>
</div>
EOD;

if(!is_dir($baseDir."/modules/companies/exported-pdf/temp")):
        @mkdir($baseDir."/modules/companies/exported-pdf/temp");
    endif;

$company_details=getCompany($_REQUEST['company_id']);
    //if(isset($_POST['print_maintenance_report']) && (strtotime($_POST['contract_begin_date_hidden']) < strtotime($company_details['application_date']))):
    if(isset($_POST['print_maintenance_report'])):
    //Create the folder inside the url.
    if(!is_dir($baseDir."/modules/companies/exported-pdf/".$company_name)):
        @mkdir($baseDir."/modules/companies/exported-pdf/".$company_name);
    endif;

    $html="";
    $html=$page1.$page2;
    $pdfName='Batch-Maintenance-Report-'.time().".pdf";
    //exit($html);
    //Hve to use the curl now to get the job done.
    $curl = curl_init();
// Set some options - we are passing in a useragent too here
    curl_setopt_array($curl, array(
        CURLOPT_RETURNTRANSFER => 1,
        CURLOPT_URL =>$baseUrl."/tcpdf/examples/pdf-report-generator.php",
        CURLOPT_USERAGENT => 'Codular Sample cURL Request',
        CURLOPT_POST => 1,
        CURLOPT_POSTFIELDS => array(
            'page1' => $page1,
            'page2' => $page2,
            'pdfName' => $pdfName,
            'pdf_link'=>$baseUrl."/index.php?m=companies&a=view-pdf&company_id=$company_id&pdf_type=batching&comp_name=$company_name&pdf=".base64_encode($baseUrl."/modules/companies/exported-pdf/temp/".$pdfName),
            'pdf_path'=>$baseDir."/modules/companies/exported-pdf/temp/".$pdfName
        )
    ));
// Send the request & save response to $resp
    $resp = curl_exec($curl);
// Close request to clear up some resources
echo $resp;

    curl_close($curl);

endif;


// if(isset($_POST['print_maintenance_report']) && (strtotime($_POST['contract_begin_date_hidden']) > strtotime($company_details['application_date']))):
// echo "<div style=\"background:lightpink;padding:10px;border:1px solid red;\"> <span style='background:red;padding:3px 5px;border:1px solid red;border-radius:40px'>&#10006</span> The contract for the company has been expired, please input contract begin date before the company's contract expiration date of ".date("dS-M-Y",strtotime($company_details['application_date']))."!</div>";
// endif;

?>
