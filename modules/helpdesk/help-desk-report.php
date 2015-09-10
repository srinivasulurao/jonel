<?php
$client_sql="select hi.item_id 'Item Id', DATE_FORMAT(hi.item_created, '%m-%d-%Y')  'Item Created', hi.item_requestor 'Requested By',
u.user_username 'User', hi.item_title 'Issue', hi.item_summary 'Detail', d.dept_name 'System #',
(case 
	when hi.item_status = 2 then 'Closed'
else
	'Open'
end) as Status,
format(sum(ifnull(tl.task_log_hours, 0)), 2) 'Hours', hi.item_application 'Application' FROM  helpdesk_items hi
left outer join  departments d on hi.item_department_id = d.dept_id Join helpdesk_item_status his join users u 
join task_log tl  
where  his.status_id = hi.item_status and hi.item_created_by = u.user_id and hi.item_id = tl.task_log_help_desk_id and hi.item_created between  'date filter begin Date' and 'Date filter end Date'
group by  Hi.Item_id ";

$conditions_apply=" WHERE 1 ";
if($_POST['item_company_id'])
$conditions_apply.=" AND hi.item_company_id ='{$_POST['item_company_id']}' ";

if($_POST['date_from']):
$date_from=date("Y-m-d H:i:s",strtotime($_POST['date_from']));
$conditions_apply.="  AND hi.item_created >= '$date_from'";
endif;

if($_POST['date_till']):
$date_till=date("Y-m-d H:i:s",strtotime($_POST['date_till']));
$conditions_apply.="  AND hi.item_created <= '$date_till'";
endif;

if($_POST['item_department_id'])
$conditions_apply.=" AND hi.item_department_id ='{$_POST['item_department_id']}' ";

if($_POST['item_created_by'])
$conditions_apply.=" AND hi.item_created_by ='{$_POST['item_created_by']}' ";

if($_POST['item_application'])
$conditions_apply.=" AND hi.item_application LIKE '%{$_POST['item_application']}%' ";


$sql="SELECT * FROM helpdesk_items as hi LEFT JOIN departments as d ON hi.item_department_id=d.dept_id LEFT JOIN task_log tl ON hi.item_id=tl.task_log_help_desk_id $conditions_apply GROUP BY item_id ORDER BY hi.item_id";

$result=db_loadlist($sql,NULL);
//debug($result[0]);

?>

<?php
function debug($arrayObj){
	echo "<pre>";
	print_r($arrayObj);
	echo "</pre>";
}

function getUser($user_id){
	$sql="SELECT * FROM users WHERE user_id='$user_id'";
	$result=db_loadlist($sql);
	return $result[0];
}

function getCompanies(){
	$sql="select company_id, company_name from companies";
	$result=db_loadlist($sql);
	return $result;
}

function getDepartments(){
	$sql="select dept_id, dept_name,dept_company from departments";
	$result=db_loadlist($sql);
	return $result;
}
function getUsers(){
	$sql="SELECT user_username,user_id FROM users";
	$result=db_loadlist($sql);
	return $result;
}
?>
<h1 style='text-align:center;margin:10px 0;border:1px solid lightgrey;padding:10px;background:white'>Help Desk Report <a href='javascript:void(0)' onclick="printContent()" style="float:right"><img src="images/icons/stock_print-16.png" alt="Print"></a></h1>
<form method="post" action="">
<div class='filters'>
<label>Company: </label>
<select name='item_company_id' onchange="showDepartments(this.value,'')"><option value="">-SELECT-</option>
<?php
$company_list=getCompanies();
foreach ($company_list as $comp):
	$comp_sel=($comp['company_id']==$_POST['item_company_id'])?"selected='selected'":"";
	echo "<option value='{$comp['company_id']}' $comp_sel>{$comp['company_name']}</option>";
endforeach;	
?>
</select>
<label>Create Date From: </label>
<input name='date_from' type='text' value="<?php echo $_POST['date_from']; ?>" readonly='readonly'>
<label>Create Date Till: </label>
<input name='date_till' type='text' value="<?php echo $_POST['date_till']; ?>" readonly='readonly'>
<label>System #: </label>
<select name='item_department_id' id="item_department_id"><option value="">-SELECT-</option>
<?php
$dept_list=getDepartments();
foreach ($dept_list as $dept):
	$dept_sel=($dept['dept_id']==$_POST['item_department_id'])?"selected='selected'":"";
	echo "<option value='{$dept['dept_id']}' $dept_sel id='company_{$dept['dept_company']}'>{$dept['dept_name']}</option>";
endforeach;	
?>
</select>
<label>User: </label>
<select name='item_created_by'><option value="">-SELECT-</option>
<?php
$user_list=getUsers();
foreach ($user_list as $user):
	$user_sel=($user['user_id']==$_POST['item_created_by'])?"selected='selected'":"";
	echo "<option value='{$user['user_id']}' $user_sel>{$user['user_username']}</option>";
endforeach;	
?>
</select>
<label>Application Type: </label>
<input name='item_application' type='text' value="<?php echo $_POST['item_application']; ?>">
<input type='submit' name='generate_list' value="Submit">
<input type='submit' name='export_list' value="Export">
</form>
<a href='?m=helpdesk&a=list&item_calltype=0&item_status=-1' style='font-size:10px;text-decoration:none !important;bottom:12px;position:relative;float:right;margin:10px 1px;padding:3px 3px' class="button">Back</a>
<a href='' style='font-size:10px;text-decoration:none !important;bottom:12px;position:relative;float:right;margin:10px 1px;padding:3px 3px;' class='button'>Refresh</a>
</div>
<!-- Now Create the Table. -->
<table class='tbl mera-tbl' width="100%" cellpadding="5" cellspacing="1" id="printableArea">
<tr><th>Item Id</th><th>Item Created</th><th>Requested By</th><th>User</th><th>Application</th><th>Issue</th><th>Detail</th><th>System #</th><th>Status</th><th>Time</th></tr>
<?php
$i=0;
$export_data=array("Item Id","Item Created","Requested By","User","Application","Issue","Detail","System #","Status","Time");
$export_data=implode("\t",$export_data)."\n";
foreach($result as $key):
	echo "<tr>";
$item_id=$key['item_id'];
$item_created=date('m/d/Y',strtotime($key['item_created']));
$userDetail=getUser($key['item_created_by']);
$user=ucwords($userDetail['user_username']);
$requested_by=ucwords($key['item_requestor']);
$application=$key['item_application'];
$issue=$key['item_title'];
$detail=$key['item_summary'];
$system_explode=explode(" ",$key['dept_name']);
$system=$system_explode[1];
$status=($key['item_status']==2)?"Closed":"Open";
$time=number_format($key['task_log_hours'],2);


$export_data.=implode("\t",array($item_id,$item_created,$requested_by,$user,$application,$issue,$detail,$system,$status,$time))."\n";

echo "<td>$item_id.</td>";
echo "<td>$item_created</td>";
echo "<td>$requested_by</td>";
echo "<td>$user</td>";
echo "<td>$application</td>";
echo "<td>$issue</td>";
echo "<td>$detail</td>";
echo "<td>$system</td>";
echo "<td>$status</td>";
echo "<td>$time</td>";
    echo "</tr>";
    $i++;
endforeach;
if(!$i):
$export_data.="\t"."Sorry, No Records Found !"."\n";	
echo "<tr><td colspan='10' style='color:red'>Sorry, No Records Found !</td></td>";
$total_task_log_hours+=$time;
endif;
echo "<tr><td colspan='8'></td><td ><b>TOTAL</b></td><td>".number_format($total_task_log_hours,2)."</td></tr>";
?>

<?php
//exporting the sql report.
if($_POST['export_list']):
$xls_file="/modules/helpdesk/images/helpdesk-report.xls";
$fp=fopen($baseDir.$xls_file,"w");
fwrite($fp,$export_data);
header("Location:".$baseUrl."/".$xls_file);
endif;
?>
</table>

<style>
.filters{
border:1px solid grey;
background: white;
padding:10px;
}

.filters input[type='text'], .filters select{
	width:80px;
}
.filters input[type='submit']{
width:45px;
}


.mera-tbl td{
text-align: center;
}

select,input[type='text'],input[type='submit'],label{
	font-size:10px;
}




</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "[name='date_from'],[name='date_till']").datepicker();
  });
  </script>



<script>

function printContent() {

     document.title='Jonel- Help Desk Report';
     window.print();

}

	function showDepartments(company_id,dept_val){

        $('#item_department_id').val(dept_val);
		$('#item_department_id option').each(function(){
			$(this).hide();
		});
		$('#item_department_id #company_'+company_id).show();

	}
</script>

<?php
if($_POST['item_company_id']):
echo "<script>showDepartments('{$_POST['item_company_id']}','{$_POST['item_department_id']}');</script>";
endif;
?>

<style type="text/css">
	@media print
	{
		body * { visibility: hidden; }
		#printableArea * { visibility: visible; }
		#printableArea { position: absolute; top: 0px; left: 0px; }
		table td,table th{
			border-bottom:1px solid grey;
			border-left:1px solid grey;
		}

		th{
			color:steelblue !important;
			font-weight: bold;
		}

		table{
			border-spacing: 0px;
			border-collapse: collapse;
		}


	}
</style>
