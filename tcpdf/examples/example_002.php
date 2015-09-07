<?php
//============================================================+
// File name   : example_002.php
// Begin       : 2008-03-04
// Last Update : 2013-05-14
//
// Description : Example 002 for TCPDF class
//               Removing Header and Footer
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
 * Creates an example PDF TEST document using TCPDF
 * @package com.tecnick.tcpdf
 * @abstract TCPDF - Example: Removing Header and Footer
 * @author Nicola Asuni
 * @since 2008-03-04
 */

// Include the main TCPDF library (search for installation path).
require_once('tcpdf_include.php');

// create new PDF document
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

// set document information
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('Nicola Asuni');
$pdf->SetTitle('TCPDF Example 002');
$pdf->SetSubject('TCPDF Tutorial');
$pdf->SetKeywords('TCPDF, PDF, example, test, guide');

// remove default header/footer
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);

// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

// set margins
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);

// set auto page breaks
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// set image scale factor
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

// set some language-dependent strings (optional)
if (@file_exists(dirname(__FILE__).'/lang/eng.php')) {
	require_once(dirname(__FILE__).'/lang/eng.php');
	$pdf->setLanguageArray($l);
}

// ---------------------------------------------------------

// set font
//$pdf->SetFont('times', 'BI', 20);

// add a page
$pdf->AddPage();

// set some text to print
$txt = <<<EOD
TCPDF Example 002

Default page header and footer are disabled using setPrintHeader() and setPrintFooter() methods.
EOD;

// print a block of text using Write()
//$pdf->Write(0, $txt, '', 0, 'C', true, 0, false, false, 0);
$page2= <<<EOD
<div style='font-family:arial !important;width:800px;margin:auto;background:white;padding:30px'>
<h1 style='font-weight:400;font-family:arial;padding:10px;text-transform:uppercase;font-size:18px;color:white;background:grey'>Maintenance Support Service Agreement</h1>
<table width='100%' style='line-height:20px;margin-top:20px'>
<tr><td style='font-size:14px;'><u>Phone Service</u> :<br>All toll free service line has been established to recieve all incoming service and technical calls.
The service window is available twenty-four hours a day, seven weeks per day.
</td></tr>

<tr><td style='font-size:14px;'><u>Jonel Remote Support Tool</u> :<br>Plants that have access to the internet can be connected to our instantaneously to help operators
troubleshoot issues as well as train on new system features.
</td></tr>

<tr><td style='font-size:14px;'><u>Software Upgrades</u> :<br>Plants that have access to the internet can be connected to our instantaneously to help operators
troubleshoot issues as well as train on new system features.
</td></tr>

<tr><td style='font-size:14px;'><u>Parts Discounts</u> :<br>A twenty percent(20%) discount will be given on all computer parts with the exception of peripherals
(PC's, printers, moisture probes, short haul modems etc).This includes I/O, CPU and A/D boards.
</td></tr>

<tr><td style='font-size:14px;'><u>Program Modification Discount</u> :<br>Programming and labor charges are $140.00 oer hour. A twenty dollar($20.00) discount per hour on labor and
program changes will be given to all systems contained within this agreement.<br>
All Customers declining maintenance will be charged $24.00 per hour in half-hour increments for phone service. A purchase order number will be required before service are provided.
</td></tr>

</table>
<h1 style='margin-top:30px;font-size:22px;color:black;font-weight:40px'><u>Authorization</u></h1><br>
<p style='font-size:14px;line-height:20px;'>
In Witness Where of, the parents have executed this Agreement as of the dayand year written below, each representing that they have actual authority to do so.
</p>
<br><br>
<table style='width:100%;font-size:14px;'>
<tr><td style='font-size:12px;'>__________________<br><label>On Behalf of</label></td>
<td style='font-size:12px;'><label>Date</label>:________</td>
<td style='font-size:12px;'>__________________<br><label>On Behalf of Jonel Engineering</label></td>
<td style='font-size:12px;'><label>Date</label>:________</td></tr>
<tr><td colspan='4' style='height:20px'></td></tr>
<tr>
<td colspan='2' style='font-size:12px;'><input type='text' size='22' style='border:0px;border-bottom:1px solid black;display:inline-block;margin-bottom:5px;'><br><label>Please Print Name On Line Above</label> </td>
<td colspan='2' style='font-size:12px;'><div style='border:1px solid black;padding:10px;'><b>Please Fax to:</b>(714)526-2397 - Attn Judy<br> Or Scan signed copy and email to:<b>judy@jonel.com</b></div></td>
</tr>
<tr><td colspan='4' style='height:20px'></td></tr>
<tr>
<td colspan='2' style='font-size:12px;'><input type='text' size='55' style='border:0px;border-bottom:1px solid black;display:inline-block;margin-bottom:5px;'><br><label>Support Agreement</label></td>
<td colspan='2' align='center' style='font-size:13px;'><input type='text' size='50' style='border:0px;border-bottom:1px solid black;display:inline-block;margin-bottom:5px;'><br><label>Jonel Engineering Company, INC</label></td>
</tr>
</table>
</div>
EOD;
$pdf->writeHTMLCell(0, 0, '', '', $page2, 0, 1, 0, true, '', true);

// ---------------------------------------------------------

//Close and output PDF document
$pdf->Output('example_002.pdf', 'I');

//============================================================+
// END OF FILE
//============================================================+
