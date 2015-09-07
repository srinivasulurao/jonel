<?php
global $baseDir;
global $baseUrl;
if($_REQUEST['task']=='delete_all'):

$files = glob($baseDir."/modules/companies/exported-pdf".'/temp/*'); // get all file names
foreach($files as $file){ // iterate files
  if(is_file($file))
    unlink($file); // delete file
}

$content = "Access Denied !!!";
$fp = fopen($baseDir."/modules/companies/exported-pdf/temp/index.html","wb");
fwrite($fp,$content);
fclose($fp);

exit;
endif;


$delete_pdf=$baseDir."/modules/companies/exported-pdf/temp/".$_REQUEST['pdf_name'];
echo @unlink($delete_pdf); // Should echo 1;
?>