<?php /* COMPANIES $Id: do_batching_maintenance_aed.php  2013-01-15 ChrisHaas $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}
global $AppUI;

require_once ($AppUI->getModuleClass('departments'));

$updateall = isset($_POST['hidden_batching_maintenance_all']) ? $_POST['hidden_batching_maintenance_all'] : 0;
if ($updateall) {

    $dept = new CDepartment();
    foreach ($_POST['dept_id'] as $value) {
        $deptId = $value;
        $dept->load($deptId);
        $dept->dept_batching_maintenance = $updateall;
        if (($msg = $dept->store())) {
                $AppUI->setMsg($msg, UI_MSG_ERROR);
        }
    }
} else {

    $dept = new CDepartment();

    foreach ($_POST['dept_id'] as $key => $value) {
        $deptId = $value;
        $maintExpireDate = $_POST['dept_batching_maintenance'][$key];
//        echo"<pre>";
//        print_r($_POST);
//        echo"</pre>";
//        exit;

        if (strlen($maintExpireDate) > 0) {

            $msg = $dept->load($deptId);
            $dept->last_report_accept_date=date("Y-m-d H:i:s",strtotime($_POST['last_report_accept_date_hidden'][$key]));
            $dept->dept_batching_maintenance=date("Y-m-d H:i:s",(strtotime($_POST['last_report_accept_date_hidden'][$key])+(365*24*3600)));
            //$batch_maintenance_touched=(substr_count($_POST['batch_expiration_touched'],":"))?explode(":",$_POST['batch_expiration_touched']):array();
            //if(in_array($key,$batch_maintenance_touched))
            $dept->dept_batching_maintenance = $maintExpireDate;

            if (($msg = $dept->store())) {
                    $AppUI->setMsg($msg, UI_MSG_ERROR);
            }

        }
    }
}
$AppUI->redirect();
?>
