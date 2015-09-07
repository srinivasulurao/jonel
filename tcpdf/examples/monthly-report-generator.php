<?php

// Include the main TCPDF library (search for installation path).
require_once("tcpdf_include.php");

// create new PDF document
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, "UTF-8", false, true);

// set document information
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor("Nicola Asuni");
$pdf->SetTitle("TCPDF Example 065");
$pdf->SetSubject("TCPDF Tutorial");
$pdf->SetKeywords("TCPDF, PDF, example, test, guide");

// set default header data
//$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE." 065", PDF_HEADER_STRING);

// set header and footer fonts
$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, "", PDF_FONT_SIZE_MAIN));
$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, "", PDF_FONT_SIZE_DATA));

$pdf->setPrintHeader(false);
$pdf->setPrintFooter(true);
// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

// set margins
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP-15, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

// set auto page breaks
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// set image scale factor
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

// set some language-dependent strings (optional)
if (@file_exists(dirname(__FILE__)."/lang/eng.php")) {
    require_once(dirname(__FILE__)."/lang/eng.php");
    $pdf->setLanguageArray($l);
}

// ---------------------------------------------------------

// set default font subsetting mode
$pdf->setFontSubsetting(true);

// Set font
//$pdf->SetFont("helvetica", "", 14, "", true);

// Add a page
// This method has several options, check the source code documentation for more information.

$pdf->AddPage();
$page1=$_POST['html'];
$pdf->writeHTMLCell(0, 0, "", "", $page1, 0, 1, 0, true, "", true);


// ---------------------------------------------------------

// Close and output PDF document
// This method has several options, check the source code documentation for more information.
$pdf->Output($_POST['pdf_path'], "F");
$pdfLink=$_POST['pdf_link'];
$base_name=$_POST['pdfName'];
echo"<div style='background:lightgreen;padding:10px;border:1px solid green;'>&#x2714;Monthly Maintenance Report Generated successfully, click <a  style='color:red;text-decoration:underline' href='$pdfLink' download='$base_name'>Here</a> to download the report !</div>";

//============================================================+
// END OF FILE
//============================================================+

