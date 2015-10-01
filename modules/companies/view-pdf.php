<?php
$pdf=base64_decode($_REQUEST['pdf']);

if(isset($_POST['save_pdf'])):
$company_name=$_REQUEST['comp_name'];
$pdfName=basename($pdf);
insertDownloadingRecord($pdfName,$company_name);
//save the pdf to destiny.
$target=$baseDir."/modules/companies/exported-pdf/".$company_name."/".$pdfName;
@copy($pdf,$target);
echo"<div style='background:lightgreen;padding:10px;border:1px solid green;'>&#x2714; Document Saved Successfully !</div><br>";
exit;
$pdf=$baseUrl."/modules/companies/exported-pdf/".$company_name."/".$pdfName;
endif;
?>

<form method="post" action=''>
	<input type='submit' name='save_pdf' value="SAVE PDF" class='button' style='text-align:center;float:right;right: 200px;top: 2px;position:relative;'>
</form>


<iframe src="<?php echo $pdf; ?>" height="600px" width="800" style='border-radius:10px;border:5px solid black; margin:auto;margin-left:200px' frameborder='0' scrolling="no"></iframe>

<?php

function insertDownloadingRecord($pdf_name,$company_name){
    global $AppUI;
    global $db;
    $today=date("Y-m-d H:i:s",time());
    $pdf_link="/modules/companies/exported-pdf/$company_name/".$pdf_name;
    $user_id=$AppUI->user_id;
		$pdf_type=$_REQUEST['pdf_type'];
    $sql="INSERT INTO company_report_downloads SET company_id='{$_REQUEST['company_id']}', pdf_link='$pdf_link', user_id='$user_id',downloaded_on='$today',pdf_type='$pdf_type'";
    $db->Execute($sql);
}

?>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'></script>
<script>

$(document).ready(function() {

    $(window).unload(function() {

                $.ajax({
					  type: "POST",
					  url:"<?php echo $baseUrl.'/index.php?m=companies&a=delete-pdf&pdf_name='.basename($pdf); ?>",
					  async:false,
					  success:function(data){
					  	console.log(data);
					  }
			    });
    });

});
</script>
