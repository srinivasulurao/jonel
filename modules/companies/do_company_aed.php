<?php /* COMPANIES $Id: do_company_aed.php 6149 2012-01-09 11:58:40Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}

$del = (int)dPgetParam($_POST, 'del', 0);
$obj = new CCompany();
$msg = '';

if (!$obj->bind($_POST)) {
	$AppUI->setMsg($obj->getError(), UI_MSG_ERROR);
	$AppUI->redirect();
}

require_once($AppUI->getSystemClass('CustomFields'));

// prepare (and translate) the module name ready for the suffix
$AppUI->setMsg('Company');
if ($del) {
	if (!$obj->canDelete($msg)) {
		$AppUI->setMsg($msg, UI_MSG_ERROR);
		$AppUI->redirect();
	}
	
	if (($msg = $obj->delete())) {
		$AppUI->setMsg($msg, UI_MSG_ERROR);
		$AppUI->redirect();
	} else {
		$AppUI->setMsg('deleted', UI_MSG_ALERT, true);
		$AppUI->redirect('m=companies');
	}
} 
else {
	if (($msg = $obj->store())) {
		$AppUI->setMsg($msg, UI_MSG_ERROR);
	} else {
 		$custom_fields = New CustomFields($m, 'addedit', $obj->company_id, 'edit');
 		$custom_fields->bind($_POST);
 		$sql = $custom_fields->store($obj->company_id); // Store Custom Fields
		$AppUI->setMsg(((@$_POST['company_id']) ? 'updated' : 'added'), UI_MSG_OK, true);

        //This is the client's new requirement to add software details module and store them in the table. 
        global $db;
        $software_module_details=mysql_real_escape_string($_POST['software_module_details']);
		$db->Execute("UPDATE companies set software_module_details='$software_module_details' WHERE company_id='{$obj->company_id}'");
	}
	$AppUI->redirect();
}
?>
