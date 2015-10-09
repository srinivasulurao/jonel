<?php /* COMPANIES $Id: ae_batching_maintenance.php 2013-01-08  ChrisHaas $ */
if (!defined('DP_BASE_DIR')) {
    die('You should not access this file directly.');
}
function debug($ArrayObject){
  echo "<pre>";
  print_r($ArrayObject);
  echo "</pre>";
}
##
##	Companies: Edit Batching Maintenance
##
// setup the title block
$titleBlock = new CTitleBlock('Edit AU Maintenance', 'handshake.png', $m, "$m.$a");
if ($canEdit) {
    $titleBlock->addCell();
}
$titleBlock->addCrumb('?m=companies', 'company list');
if ($canEdit) {
    $titleBlock->addCrumb(('?m=companies&amp;a=view&amp;company_id=' . $company_id),
        'view this company');
}
$titleBlock->show();

global $AppUI,$baseU;

$company_id = intval(dPgetParam($_GET, 'company_id', 0));

if($_POST['save_au']=="SAVE"):
    $application_date=($_POST['accepted_date'])?date("m/d/Y",(strtotime($_POST['accepted_date'])-(3600*24*365))):$_POST['expiration_date'];
    $report_accept_date=($_POST['accepted_date'])?date("Y-m-d H:i:s",strtotime($_POST['accepted_date'])):"0000-00-00 00:00:00";

    global $db;

    //debug($_REQUEST);

    $sql="UPDATE companies SET application_date='$application_date', report_accept_date='$report_accept_date' WHERE company_id='$company_id'";
    //$db->Execute($sql);
    echo"<div style='margin:5px;background:lightgreen;padding:5px;border:1px solid green;border-radius:4px;'>&#x2714; Company details saved successfully !</div>";
endif;




$company_data=db_loadList("SELECT * FROM companies WHERE  company_id='$company_id'");
$result=$company_data[0];
$root_url=$baseUrl;

//Now generate the pdf report.

if($_POST['save_au']=="GENERATE REPORT"):

    $company_name=$result['company_name'];
    $annually='$'.number_format($result['application_amount'],2);
    $quaterly='$'.number_format(($result['application_amount']/4),2);
    $contract_begin_date=date("F d, Y",strtotime($_POST['contract_begin_date']));
    $contract_end_date=date("F d, Y",(strtotime($_POST['contract_begin_date'])+(3600*24*365)));
    $result['company_address2']=($result['company_address2'])?"<br>".$result['company_address2']:"";

    $modules_html="<table style=\"width:100%;font-family:arial;font-size:14px;\" cellpadding=\"7\">";
    $result['software_module_details']=str_replace(", ",",",$result['software_module_details']);
    $software_modules=@explode(",",$result['software_module_details']);
    foreach($software_modules as $key=>$sd):
    $background=($key%2==0)?"lightgrey":"white";
    $modules_html.="<tr><td width=\"50%\" style=\"background-color:$background;border-bottom:1px solid lightgrey\">$sd</td><td width=\"50%\" style=\"background-color:$background;border-left:1px solid grey;border-bottom:1px solid lightgrey\"></td></tr>";
    endforeach;
    $modules_html.="</table>";


    if(!is_dir($baseDir."/modules/companies/exported-pdf/".$company_name)):
        @mkdir($baseDir."/modules/companies/exported-pdf/".$company_name);
    endif;

    $page1= <<<EOD
        <div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
        <table border="0" style="font-family:arial;width:120%;font-size:15px">
        <tr><td width="30%" ><img width="220" src="$root_url/modules/companies/images/jonel_logo_2.jpg"><br><br><span style="font-size:14px">Jonel Engineering<br>500E.Walnut Avenue<br>P.O.Box 798<br>Fullerton, CA 92832</span></td>
        <td width='60%'></td>
        <td width="30%" style="font-size:12px;align:right">
        <span style="font-size:14px;display:inline-block;text-align:left;display:inline-block;"><br><br><br><br><br>{$company_name}<br>{$result['company_address1']}{$result['company_address2']}<br>{$result['company_city']}, {$result['company_state']} {$result['company_zip']}</span>
        </td></tr>
        </table><br><br>

        <table border="0" style="font-family:arial;width:125%;font-size:14px">
        <tr><td width='80%'><span style="font-size:14px;display:inline-block;text-align:left;">Contract Number : __________________<br>Prepared By: ______________________</span></td>
        <td width='25%'>Contract Date: {$contract_begin_date}</td>
        </tr>
        </table><br><br><br>

        <table style="font-family:arial;width:100%;font-size:15px">
        <tr><td style="text-align:center;font-size:20px;font-weight:bold">OPERATIONS & ACCOUNTING SOFTWARE SERVICE AGREEMENT</td></tr>
        <br><br>
        <table><br>

        <table style="font-family:arial;width:100%;font-size:15px">
        <tr><td style="font-size:20px;font-weight:bold">SERVICE OVERVIEW</td></tr>
        <tr><td>A twenty-four hour service call window will be provided under this agreement Monday through Friday, to correct any inconsistencies in the standard software package or answer questions arising from the use of the software.</td></tr>
        <br><br>
        <table>

        <table style="font-family:arial;width:100%;font-size:15px">
        <tr><td style="font-size:20px;font-weight:bold">On-Site Training and Implementation</td></tr>
        <tr><td>Any requirements for Jonel Staff to perform On-site implementation and training will be billed at a daily rate of $1000 per day per person plus any overtime. On site implementation and training include the following.<br>
        <ul>
        <li>Setup and configuration of Access Unlimited SQL databases.</li>
        <li>File building set up - taxes, products, customers, etc.</li>
        <li>Setup of batch panel interface.</li>
        <li>On site DBA - replication, backup and maintenance plans.</li>
        <li>Mobile Signaling setup/configuration.</li>
        <li>Core application training: Sales, Dispatch, Billing, etc.</li>
        <li>On site I/T training-network, O/S setup, MSMQ, report writing</li>
        </ul>
        </td></tr>
        <br><br>
        <table>

        <table style="font-family:arial;width:100%;font-size:15px">
        <tr><td style="font-size:20px;font-weight:bold">Programming/Customization</td></tr>
        <tr><td>Jonel will provide customization to the core Access Unlimited JS application at an hourly rate of $180 per hour. Custom programming and development will be quoted separately for each program modification
        and an estimated due date will be mutually agreed upon for each project.
        </td></tr>
        <br><br>
        <table>

EOD;

    $page2=<<<xyz
            <div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
            <table border="0" style="font-family:arial;width:100%;font-size:15px">
            <tr><td width="30%" ><img width="220" src="$root_url/modules/companies/images/jonel_logo_2.jpg"></td>
            <td width="78%" style="vertical-align:top;font-size:12px;align:right">
            </td></tr>
            </table><br><br>

            <table style="font-family:arial;width:100%;font-size:15px">
            <tr><td style="font-size:20px;font-weight:bold">Off-site DBA/Network/Hardware Troubleshooting</td></tr>
            <tr><td>Off-site database administration is billable at a rate of $180 per hour. Example of this type of services are as follows:
            <ul>
            <li>Setting up backups and scheduled maintenance plans specific to SQL Server</li>
            <li>Adding new databases or moving data between databases using replication or data transformation tools</li>
            <li>Fixing database corruption at table or index level</li>
            <li>Restoring database from backup</li>
            <li>Rebuilding application database based on server failure</li>
            <li>SQL upgrades.</li>
            </ul>
            </td></tr>
            <tr><td>
            <br><br>
          In addition, any off-site services that are extraneous to the Access Unlimited application that require Jonel service will be billable. Examples of this type of general support are as follows.
            <ul>
            <li>Setting up configuring NT/200 network components (DNS, DHCP, WINS, TCP/IP, etc.)</li>
            <li>Setting up RAID Server arrays</li>
            <li>Installing or reinstalling operating system on server(s)</li>
            <li>OS upgrades</li>
            <li>Third party application configuration and setup such as Citrix Metaframe</li>
            <li>Trouble shooting client computer issues such as network configuration or hardware issues specific to client machines (NIC cards, video cards, hard drives, peripherals, etc.)</li>
            </ul>
            </td></tr>
            </table>
              <br><br>

            <table style="font-family:arial;width:100%;font-size:15px">
            <tr><td style="font-size:20px;font-weight:bold">Access Unlimited Upgrades (Weekends/After Hours)</td></tr>
            <tr><td>One annual upgrade per calendar year is included in your service contract providing it's done between the hours of 8:00AM-5:00PM Monday through Friday PST.
            if an upgrade is required on a weekend or any time outside standard business hours, it will be billed at a rate of $180.00 per hour.
            </td></tr>
            </table>
            <br><br>

            <table style="font-family:arial;width:100%;font-size:15px">
            <tr><td style="font-size:20px;font-weight:bold">Negligent Use</td></tr>
            <tr><td>Any blatant misuse of the product in a consistent, negligent fashion is billable. This type of issue may arise when user
            request service on issues that they have direct control of avoiding, but continuously cause due to lack of training of forgetfulness. These types of billable items guard against users who <i>consistently</i>
            fail to follow directions or use of the product in a way that it was not intended. Examples of this are as follows:
            <ul>
            <li>Unscrupulously disabling core services such as SQL server, TCP/IP, Message Queue, etc.</li>
            <li>Consistently exporting incorrect billing data</li>
            <li>Unauthorized database modifications or changes to data outside of the Access Unlimited application.</li>
            </ul>
            </td></tr>
            </table>
              <br><br>
xyz;

    $page3=<<<EOD
            <div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
            <table border="0" style="font-family:arial;width:100%;font-size:15px">
            <tr><td width="30%" ><img width="220" src="$root_url/modules/companies/images/jonel_logo_2.jpg"></td>
            <td width="78%" style="vertical-align:top;font-size:12px;align:right">
            </td></tr>
            </table><br><br>

            <table style="font-family:arial;width:100%;font-size:15px">
            <tr><td style="font-size:20px;font-weight:bold">Included in the service contract:</td></tr>
            <tr><td>The following items are covered in your service contact.
            <ul>
            <li>Off-site training on Access Unlimited core applications on an individual basis. (This does not include off-site "classroom training").</li>
            <li>General questions on setup, configuration and use of Access Unlimited core application.</li>
            <li>Training on configuring AUJS core components: Reports, Batch Panel Interface and Mobile Signaling Interface.</li>
            <li>Training on formatting documents: tickets, invoices and form letters.</li>
            <li>General questions on database table structure and table relationship for custom reports and queries.</li>
            <li>Bug Fixes.</li>
            <li>General trouble shootings of issues dealing explicitly and Access Unlimited JS system and core components (Batch Panel, Reports and Mobile Signaling). </li>
            <li>Access Unlimited upgrades during business hours 8:00AM-5:00PM Monday-Friday PST.</li>
            </ul>
            All Customers declining maintenance will be charged at a rate of $240 per hour, in half-hour
            increments for phone service. A purchase order number will be required before services are provided.
            </td></tr>
            </table>
         <br><br>

         <table style="font-family:arial;width:100%;font-size:15px">
         <tr><td style="font-size:17px;font-weight:bold">This Software Service Agreement includes the following software modules:</td></tr>
         <tr><td></td></tr>
         </table>
         <br>
         $modules_html
EOD;


    $page4=<<<EOD
        <table style="font-family:arial;width:100%;font-size:15px">
        <tr><td style="font-size:20px;font-weight:bold;border-bottom:1px solid black">Notes:</td></tr>
        <tr><td style="font-size:20px;font-weight:bold;border-bottom:1px solid black"></td></tr>
        <tr><td style="font-size:20px;font-weight:bold;border-bottom:1px solid black"></td></tr>
        <tr><td style="font-size:20px;font-weight:bold;border-bottom:1px solid black"></td></tr>
        <tr><td style="font-size:20px;font-weight:bold;border-bottom:1px solid black"></td></tr>
        </table>
        <br><br>
        <table  style="font-family:arial;width:100%;font-size:15px">
        <tr><td>Software Service Agreement will commence {$contract_begin_date} and continues through {$contract_end_date}. The Software Service Agreement must be Signed and returned to Jonel along with payment.</td></tr>
        <tr><td></td></tr>
        <tr><td>Invoice terms: Due upon receipt. Payments may be made quarterly or annually. If quarterly payments are selected, payment must be made on or before their due date. Should payments laps for more than one-month (30) days, this contract will be invalid.</td></tr>
        </table>

        <br><br><br><br>

        <table  style="font-family:arial;width:100%;font-size:15px;color:steelblue;line-height:25px;">
        <tr><td style="width:70%"></td><td style="width:17%"><b>ANNUALLY</b>: </td><td>$annually</td></tr>
        <tr><td style="width:70%"></td><td style="width:17%"><b>QUARTERLY</b>: </td><td>$quaterly</td></tr>
        <tr><td></td></tr>
        </table>

        <br><br>

        <table  style="font-family:arial;width:100%;font-size:15px;line-height:25px;">
        <tr><td><b>SIGNED</b>: ______________________</td></tr>
        <tr><td><b>DATE</b>: ________________________</td></tr>
        <tr><td></td></tr>
        </table>

EOD;
    $pdfName='AU-Maintenance-Report-'.time().".pdf";

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
            'page3'=>$page3,
            'page4'=>$page4,
            'pdfName' => $pdfName,
            'link'=>2,
            'pdf_link'=>$baseUrl."/index.php?m=companies&a=view-pdf&company_id=$company_id&pdf_type=au&comp_name=$company_name&pdf=".base64_encode($baseUrl."/modules/companies/exported-pdf/temp/".$pdfName),
            'pdf_path'=>$baseDir."/modules/companies/exported-pdf/temp/".$pdfName
        )
    ));
// Send the request & save response to $resp
    $resp = curl_exec($curl);
// Close request to clear up some resources
    echo $resp;

    curl_close($curl);


endif;
?>
<form method="post" action="">
<table width="75%" class="tbl auComp" cellpadding="5">
    <tr><th>Contract Begin Date</th><th>Expires</th><th>Report Generation Date</th><th>Accepted Date</th></tr>
    <tr><td><input class='text' readonly type="text" id='contract_begin_date' name="contract_begin_date" value="<?php echo date("d/M/Y",time()); ?>"><a href="javascript:void(0)" onclick="showDPCalender('contract_begin_date')"> <img src="./images/calendar.gif" name="img_expiredate2" width="24" height="12" alt="Calendar" border="0"></a></td>
        <td><input class='text' readonly type="text" id='expiration_date' name="expiration_date" value="<?php echo date("d/M/Y",strtotime($result['application_date'])); ?>"><a href="javascript:void(0)" onclick="showDPCalender('expiration_date')"> <img src="./images/calendar.gif" name="img_expiredate2" width="24" height="12" alt="Calendar" border="0"></a></td>
        <td><?php echo ($result['report_generation_date']!="0000-00-00 00:00:00")?date("d/M/Y",strtotime($result['report_generation_date'])):"Not generated yet"; ?></td>
        <td><input class='text' readonly type="text" id="accepted_date" name="accepted_date" value="<?php echo ($result['report_accept_date']!="0000-00-00 00:00:00")?date("d/M/Y",strtotime($result['report_accept_date'])):""; ?>"><a href="javascript:void(0)" onclick="showDPCalender('accepted_date')"> <img src="./images/calendar.gif" name="img_expiredate2" width="24" height="12" alt="Calendar" border="0"></a></td>
      <input name='accepted_date_hidden' type='hidden' id='accepted_date_hidden' value="<?php echo ($result['report_accept_date']!="0000-00-00 00:00:00")?date("Ymd",strtotime($result['report_accept_date'])):date("Ymd",time()); ?>" >
      <input name='expiration_date_hidden' type='hidden' id='expiration_date_hidden' value="<?php echo date("Ymd",strtotime($result['application_date'])); ?>" >
      <input name='accepted_date_hidden' type='hidden' id='contract_begin_date_hidden' value="<?php echo date("Ymd",time()); ?>" >
    </tr>
    <tr><td colspan="4" style="text-align:center;"><input class="button" type="submit" name="save_au" value="SAVE">&nbsp;<input type="submit" name="save_au" value="GENERATE REPORT" class="button"></td></tr>
</table>


</form>


<style>
    .auComp td{
        text-align:center;
    }

    .auComp .text{
        text-align: center;
    }

    .button{
        cursor:pointer;
    }

</style>

<script>
function showDPCalender(givenId){
  calendarField = document.getElementById(givenId);
  fld_date = document.getElementById(givenId+"_hidden");
  idate = fld_date.value;
  window.open('?m=public&'+'a=calendar&'+'dialog=1&'+'callback=setCalendar&'+'date=' + idate, 'calwin', 'top=250,left=250,width=278, height=272, scrollbars=no, status=no');

}

function setCalendar(idate, fdate) {
  console.log(idate,fdate);
	calendarField.value = fdate;
	fld_date.value = idate;
}

</script>

<!--
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
    $(function() {
        $( "[name='contract_begin_date'],[name='expiration_date'],[name='accepted_date']").datepicker();
    });
</script>
-->
