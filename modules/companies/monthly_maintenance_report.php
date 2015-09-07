<?php /* COMPANIES $Id: ae_batching_maintenance.php 2013-01-08  ChrisHaas $ */
if (!defined('DP_BASE_DIR')) {
    die('You should not access this file directly.');
}

##
##	Companies: Edit Batching Maintenance
##
global $AppUI;
global $baseUrl;
global $baseDir;
$conditions_apply=" ";

if($_POST['search_text']):
$conditions_apply.=" AND (c.company_name LIKE '%{$_POST['search_text']}%' OR left(`d`.`dept_name`,5) LIKE '%{$_POST['search_text']}%' OR ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) LIKE '%{$_POST['search_text']}%')";
endif;

$sql="select `c`.`company_name` AS `Company`,left(`d`.`dept_name`,5) AS `Batching_Serial_Number`,ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) AS `Plant_Name`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 12 month) else (last_day(`d`.`dept_batching_maintenance`) + interval 12 month) end) AS `End_Date`,`d`.`dept_url` AS `Amount` from (`departments` `d` join `companies` `c` ON d.dept_company=c.company_id) WHERE 1 $conditions_apply order by `c`.`company_name`";
//$sql="Select * from au_batching_contracts1 WHERE 1 $conditions_apply order by Company";

$rows = db_loadList($sql, NULL);

// format dates
$df = $AppUI->getPref('SHDATEFORMAT');

$rownum = 1;

$html="";
$html=<<<xyz
<table width="100%" class="tbl" style="font-size:12px !important" cellpadding="2" border="1">
<tr>
    <th style="border-bottom:1px solid black;color:steelblue;font-weight:bold;text-align:center;">Company</th>
    <th style="border-bottom:1px solid black;color:steelblue;font-weight:bold;text-align:center;width:27%">Batching Serial Number</th>
    <th style="border-bottom:1px solid black;color:steelblue;font-weight:bold;text-align:center;">Plant Name</th>
    <th style="border-bottom:1px solid black;color:steelblue;font-weight:bold;text-align:center">End Date</th>
    <th style="border-bottom:1px solid black;color:steelblue;font-weight:bold;text-align:center;width:12%">Amount</th>
    </tr>
xyz;

    
    foreach($rows as $row):
        ## We have to show only the expired 
        $end_timestamp=strtotime($row['End_Date']);
        $from_timestamp=strtotime($_POST['end_date_from']);
        $till_timestamp=strtotime($_POST['end_date_till']);
        $condition_1=($_POST['end_date_from'])?($from_timestamp <= $end_timestamp):1;
        $condition_2=($_POST['end_date_till'])?($till_timestamp >= $end_timestamp):1;
        if($condition_1 and $condition_2):
        $Amount='$'.number_format($row['Amount'],2);
        $html.="<tr><td style=\"text-align:center\">{$row['Company']}</td><td style=\"text-align:center\">{$row['Batching_Serial_Number']}</td><td style=\"text-align:center\">{$row['Plant_Name']}</td><td style=\"text-align:center\">{$row['End_Date']}</td><td style=\"text-align:center\">$Amount</td></tr>";
        $i++;
        endif;
        
    endforeach;
    if(!$i)
    $html.="<tr><td colspan='6' style='padding:30px;font-size:20px'><font color='red'>No Records found !</font></td></tr>";

$html.="</table>";


if($_POST['form_task']=='PRINT'):
    if(!is_dir($baseDir."/modules/companies/exported-pdf/temp")):
        @mkdir($baseDir."/modules/companies/exported-pdf/temp");
    endif; 
    $header="<table><tr><td align=\"center\"><h1>Jonel Maintenance List</h1><br><br></td></tr></table>";

    //Create the folder inside the url.
    if(!is_dir($baseDir."/modules/companies/exported-pdf/".$company_name)):
        @mkdir($baseDir."/modules/companies/exported-pdf/".$company_name);
    endif; 
    
    $pdfName='Monthly-Maintenance-Report-'.time().".pdf";
    //exit($html);
    //Hve to use the curl now to get the job done.
    $curl = curl_init();
// Set some options - we are passing in a useragent too here
    curl_setopt_array($curl, array(
        CURLOPT_RETURNTRANSFER => 1,
        CURLOPT_URL =>$baseUrl."/tcpdf/examples/monthly-report-generator.php",
        CURLOPT_USERAGENT => 'Codular Sample cURL Request',
        CURLOPT_POST => 1,
        CURLOPT_POSTFIELDS => array(
            'html' => $header.$html,
            'pdfName' => $pdfName,
            //'pdf_link'=>$baseUrl."/index.php?m=companies&a=view-pdf&company_id=$company_id&comp_name=$company_name&pdf=".base64_encode($baseUrl."/modules/companies/exported-pdf/temp/".$pdfName),
            'pdf_link'=>$baseUrl."/modules/companies/exported-pdf/temp/".$pdfName,
            'pdf_path'=>$baseDir."/modules/companies/exported-pdf/temp/".$pdfName
        )
    ));

// Send the request & save response to $resp
      $resp = curl_exec($curl); 
    echo $resp;

    curl_close($curl);
    // sleep(5);
    // $print_file=$baseDir."/modules/companies/exported-pdf/temp/".$pdfName;
    //exit($print_file);
// if (file_exists($print_file)) {
//     $file_name =basename($print_file);
//     $file_url = $baseUrl."/modules/companies/exported-pdf/temp/".$pdfName;
//     // echo $file_url;
//     // header('Content-Type: application/pdf');
//     // header("Content-disposition: attachment; filename=\"".$file_name."\"");
//     // readfile($file_url);
//     //unlink($print_file);
//     echo "<a href='$file_url' id='deletePDF' download='$file_name'>Download</a>";
    // }

endif;
?>


<h1 style='text-align:center'>Jonel Maintenance List <!-- <br> <?php echo date("F",time()); ?> --></h1>
<div class='filter_div'>
<form method="post" action='' name='filter_form'>
<label>Search Text :</label><input autocomplete='off' value="<?php echo $_POST['search_text']; ?>" type='text' name='search_text' placeholder='Search Text'> <label>End Date From : </label> <input type='text' value="<?php echo $_POST['end_date_from']; ?>" name='end_date_from' autocomplete='off' placeholder='From' id='datepicker1'> <label>End Date Till : </label> <input placeholder='Till' type="text" name='end_date_till' autocomplete='off' value="<?php echo $_POST['end_date_till']; ?>" id='datepicker2'>  <input type='submit' value='SEARCH' name='form_task'> <input type='submit' name='form_task' value='PRINT'> <a href=''>Clear</a>
</form>
</div>


<?php 

echo $html;
    ?>





<style>
    .tbl td{
        text-align:center;
        border:0px !important;
    }

    .filter_div{
        margin: 20px 0 20px 0;
    background: #ADD8E6;
    padding: 10px;
    text-align: center;
    border: 1px solid #D3D3D3;
    box-shadow: 0 0px 2px;
    border-radius: 4px;
    }
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "#datepicker1, #datepicker2" ).datepicker();
  });
  </script>

  <script>
  function clearAll(){
    $('#datepicker1, #datepicker2').val('');
    document.filter_form.submit();
  }


  </script>


<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'></script>
<script>

$(document).ready(function() {

    $('.nav a').click(function(){
                
                $.ajax({
                      type: "POST",
                      url:"<?php echo $baseUrl.'/index.php?m=companies&a=delete-pdf&task=delete_all'; ?>",
                      async:false,
                      success:function(data){
                        console.log(data);
                      }
                });
    });

});
</script>
