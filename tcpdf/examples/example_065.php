<?php
//============================================================+
// File name   : example_065.php
// Begin       : 2011-09-28
// Last Update : 2013-05-14
//
// Description : Example 065 for TCPDF class
//               Creates an example PDF/A-1b document using TCPDF
//
// Author: Nicola Asuni
//
// (c) Copyright:
//               Nicola Asuni
//               Tecnick.com LTD
//               www.tecnick.com
//               info@tecnick.com
//============================================================+

/**
 * Creates an example PDF/A-1b document using TCPDF
 * @package com.tecnick.tcpdf
 * @abstract TCPDF - Example: PDF/A-1b mode
 * @author Nicola Asuni
 * @since 2011-09-28
 */

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
$pdf->setPrintFooter(false);
// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

// set margins
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
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

// Set some content to print
$root_url="http://localhost/jonel/";
$page1= <<<EOD
<div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
<table style="border:0px;font-family:arial;width:100%;font-size:14px">
<tr><td width="65%" ><img src="$root_url/modules/companies/images/jonel_logo.jpg"><br><br><span style="font-size:14px">500E.Walnut <br> Fullerton, CA 92832</span></td>
<td style="vertical-align:top;font-size:12px"><b style="display:inline-block;width:100px;text-align:right">Date :</b> <span style="display:inline-block;width:150px;"> 65656565</span></br><b style="display:inline-block;width:100px;text-align:right">Customer :</b> <span style="display:inline-block;width:150px;"> 65656565</span><br><b style="display:inline-block;width:100px;text-align:right">Address :</b> <span style="display:inline-block;width:150px;"> 656566</span></td></tr>
</table><br>
<h1 style="font-weight:400;font-family:arial;padding:10px;text-transform:uppercase;font-size:18px;color:white;background:grey">MAINTENANCE SUPPORT AGREEMENT -6565</h1>
<p style="font-size:14px;line-height:20px;">
This document describes and identifies the Service Agreement terms and conditions, which includes a non-exclusive, non-transferable subscription for support and
maintenance of the following computer System(s), under the terms and conditions set forth below.<br>
<div style="font-size:14px;display:inline-block;width:45%"><b>Subscriber Begin Date :</b> <span style="display:inline-block;width:150px;"> 56565</span></div>
<div style="font-size:14px;display:inline-block;width:45%"><b>Subscriber End Date :</b> <span style="display:inline-block;width:150px;"> 656565</span></div>
<p style="font-size:14px;line-height:20px;">
Listed below are the Archer, Advantage or Block mate Batching Controller(ABC) Serial Number(s) of the system(s) eligible to be converted within this agreement.
</p>
<table style="width:100%;border:0" cellpadding="10" cellspacing="0">
<tr style="background:grey;color:white"><th align="left" width="30%">System Number</th><th align="left" width="50%">Plant</th><th align="left" width="20%">Annual Amount</th></tr>
<tr style="background:grey;color:white"><th align="left" width="30%">System Number</th><th align="left" width="50%">Plant</th><th align="left" width="20%">Annual Amount</th></tr>
<tr><td>26433</td><td>Valvista</td><td>1,000.00</td></tr><tr><td>30456</td><td>Dobson</td><td>1,000.00</td></tr><tr><td>26451</td><td>Rio Rancho</td><td>1,000.00</td></tr>
<tr style="background:grey;color:white"><th>&nbsp;</th><th>Total</th><th align="left">3,000.00</th></tr>
<tr style="background:grey;color:white"><th>&nbsp</th><th>Total</th><th align="left">2,000.00</th></tr>
</table>
</div>
<div style="clear:both"> </div>
EOD;

$page2= <<<EOD
<div style="font-family:arial !important;width:800px;margin:auto;background:white;padding:30px">
<h1 style="font-weight:400;font-family:arial;padding-left:10px;text-transform:uppercase;font-size:18px;color:white;background-color:grey">Maintenance Support Service Agreement</h1>
<table width="100%" style="line-height:20px;margin-top:20px">
<tr><td style="font-size:14px;"><u>Phone Service</u> :<br>All toll free service line has been established to recieve all incoming service and technical calls.
The service window is available twenty-four hours a day, seven weeks per day.
</td></tr>

<tr><td style="font-size:14px;"><u>Jonel Remote Support Tool</u> :<br>Plants that have access to the internet can be connected to our instantaneously to help operators
troubleshoot issues as well as train on new system features.
</td></tr>

<tr><td style="font-size:14px;"><u>Software Upgrades</u> :<br>Plants that have access to the internet can be connected to our instantaneously to help operators
troubleshoot issues as well as train on new system features.
</td></tr>

<tr><td style="font-size:14px;"><u>Parts Discounts</u> :<br>A twenty percent(20%) discount will be given on all computer parts with the exception of peripherals
(PC"s, printers, moisture probes, short haul modems etc).This includes I/O, CPU and A/D boards.
</td></tr>

<tr><td style="font-size:14px;"><u>Program Modification Discount</u> :<br>Programming and labor charges are $140.00 oer hour. A twenty dollar($20.00) discount per hour on labor and
program changes will be given to all systems contained within this agreement.<br>
All Customers declining maintenance will be charged $24.00 per hour in half-hour increments for phone service. A purchase order number will be required before service are provided.
</td></tr>

</table>
<h1 style="margin-top:30px;font-size:22px;color:black;font-weight:40px"><u>Authorization</u></h1><br>
<p style="font-size:14px;line-height:20px;">
In Witness Where of, the parents have executed this Agreement as of the dayand year written below, each representing that they have actual authority to do so.
</p>
<br><br>
<table style="width:100%;font-size:14px;">
<tr><td style="font-size:12px;">__________________<br><label>On Behalf of</label></td>
<td style="font-size:13px;"><label>Date</label>:________</td>
<td style="font-size:13px;">__________________<br><label>On Behalf of Jonel Engineering</label></td>
<td style="font-size:13px;"><label>Date</label>:________</td></tr>
<tr><td colspan="4" style="height:20p"></td></tr>
<tr>
<td colspan="2" style="font-size:13px;">___________________________________<br><label>Please Print Name On Line Above</label> </td>
<td colspan="2" style="font-size:13px;"><div style="border:1px solid black;padding:10px !important;"><b> Please Fax to:</b>(714)526-2397 - Attn Judy<br> Or Scan signed copy and email  to:<b>judy@jonel.com</b></div></td>
</tr>
<tr><td colspan="4" style="height:20px"></td></tr>
<tr>
<td colspan="2" style="font-size:13px;">_____________________________________<br><label>Support Agreement</label></td>
<td colspan="2" align="center" style="font-size:13px;">____________________________________<br><label>Jonel Engineering Company, INC</label></td>
</tr>
</table>
</div>
EOD;

$html=$page2;
// Print text using writeHTMLCell()
$pdf->writeHTMLCell(0, 0, "", "", $html, 0, 1, 0, true, "", true);

// ---------------------------------------------------------

// Close and output PDF document
// This method has several options, check the source code documentation for more information.
$pdf->Output("example_065.pdf", "I");

//============================================================+
// END OF FILE
//============================================================+
