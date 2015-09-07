<?php /* COMPANIES $Id: addedit.php 6048 2010-10-06 10:01:39Z ajdonnison $ */
if (!defined('DP_BASE_DIR')) {
  die('You should not access this file directly.');
}


$company_id = intval(dPgetParam($_GET, 'company_id', 0));

// check permissions for this company
// If the company exists we need edit permission,
// If it is a new company we need add permission on the module.
if ($company_id) {
  $canEdit = getPermission($m, 'edit', $company_id);
} else {
  $canEdit = getPermission($m, 'add');
}

if (!$canEdit) {
	$AppUI->redirect('m=public&a=access_denied');
}

// load the company types
$types = dPgetSysVal('CompanyType');

// load the record data
$q = new DBQuery;
$q->addTable('companies', 'co');
$q->addQuery('co.*');
$q->addQuery('con.contact_first_name');
$q->addQuery('con.contact_last_name');
$q->addJoin('users', 'u', 'u.user_id = co.company_owner');
$q->addJoin('contacts', 'con', 'u.user_contact = con.contact_id');
$q->addWhere('co.company_id = '.$company_id);
$sql = $q->prepare();
$q->clear();

$obj = null;
if (!db_loadObject($sql, $obj) && $company_id > 0) {
	//$AppUI->setMsg('$qid =& $q->exec(); Company'); // What is this for?
	$AppUI->setMsg('invalidID', UI_MSG_ERROR, true);
	$AppUI->redirect();
}

// collect all the users for the company owner list
$q = new DBQuery;
$q->addTable('users','u');
$q->addTable('contacts','con');
$q->addQuery('user_id');
$q->addQuery('CONCAT_WS(", ",contact_last_name,contact_first_name)'); 
$q->addOrder('contact_last_name');
$q->addWhere('u.user_contact = con.contact_id');
$owners = $q->loadHashList();

// setup the title block
$ttl = $company_id > 0 ? 'Edit Company' : 'Add Company';
$titleBlock = new CTitleBlock($ttl, 'handshake.png', $m, "$m.$a");
$titleBlock->addCrumb('?m=companies', 'companies list');
if ($company_id != 0) {
	$titleBlock->addCrumb('?m=companies&amp;a=view&amp;company_id=' . $company_id, 'view this company');
}
$titleBlock->show();
?>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.24/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script src="http://code.jquery.com/ui/1.8.24/jquery-ui.js"></script>
<script language="javascript" type="text/javascript">
function submitIt() {
	var form = document.changeclient;
	if (form.company_name.value.length < 3) {
		alert("<?php echo $AppUI->_('companyValidName', UI_OUTPUT_JS); ?>");
		form.company_name.focus();
        } else {
        	form.submit();                
//                alert(document.getElementById('company_name').value);
//                exit;
	}
}

function testURL(x) {
	var test = "document.changeclient.company_primary_url.value";
	test = eval(test);
	if (test.length > 6) {
		newwin = window.open("http://" + test, 'newwin', '');
	}
}
</script>
<script type="text/javascript">
    $(function(){
        $('#refresh').click(function(){
           $('#datepicker').val("");
        });
        $('#auchecked').click(function(){
           if($(this).is(':checked')){
               $('.date').show();
           }else if($(this).is(':checked')==false){
               //$('#datepicker').val("");
               $('.date').hide();
           } 
        });
        $('#au').click(function(){
           if($(this).is(':checked')){
               $('.date').show();
           }else if($(this).is(':checked')==false){
               //$('#datepicker').val("");
               $('.date').hide();
           }
        });
        var cases = [];
        $('.case').each(function(){
            if($(this).is(':checked')){
                cases.push($(this).val());
            }
        });
        $('.case').click(function(){
            if($(this).is(':checked')){
                cases.push($(this).val());
            }else if($(this).is(':checked')==false){
                var itemtoRemove = $(this).val();
                cases.splice($.inArray(itemtoRemove, cases),1);
            }
            $('#resultarray').val(cases);
        });
    });
</script>
<script>
    $(function() {
        $("#datepicker").datepicker();
    });
</script>
<style>
    #company_app{
        width:400px;
    }
    #company_app option {
        float:left;
        width: 60px;
    }
    .boxes{
        float: left;
        width: 125px;
    }
</style>
<form name="changeclient" action="?m=companies" method="post">
	<input type="hidden" name="dosql" value="do_company_aed" />
	<input type="hidden" name="company_id" value="<?php echo dPformSafe($company_id); ?>" />
<table cellspacing="1" cellpadding="1" border="0" width='100%' class="std" summary="add/edit company">
<tr>
    <td>
        <table>
            <tr>
                <td align="right"><?php echo $AppUI->_('Company Name'); ?>:</td>
                <td>
                    <input type="text" class="text" name="company_name" id="company_name" value="<?php 
                    echo dPformSafe(@$obj->company_name); ?>" size="50" maxlength="255" /> 
                    (<?php echo $AppUI->_('required'); ?>)
                </td>
                <?php 
                    mysql_connect("localhost", "root", "kontron") or die(mysql_error()); 
                    mysql_select_db("dptest") or die(mysql_error()); 
                    $data = mysql_query("SELECT sysval_value FROM sysvals WHERE sysval_title='HelpDeskAppication'")
                    or die(mysql_error()); 
                    while($info = mysql_fetch_array($data)) 
                    { 
                       $result=$info['sysval_value'];
                    }
                    //echo $result;
                    $asdf[]=explode("|",$result);
                ?>
                <?php $checkedarrray = htmlspecialchars($obj->company_application);
                        $checkedarrray = explode(',',$checkedarrray);                
                ?>
                <td align="left" vertical-align="top">
                    <?php echo $AppUI->_('Application Type'); ?>:
                    <input type="hidden" class="text" id="resultarray" name="company_application" value=""/>
                </td>
                <td>
                    <?php 
                    foreach($asdf[0] as $af){?>
                        <div class="boxes">
                        <?php if (in_array($af,$checkedarrray)){?>
                            <?php if($af=="Access unlimited"){?>
                                <input type="checkbox" class="case" name="case" value="<?php echo $af; ?>" id="auchecked"  checked="checked"/>
                            <?php }else{ ?>
                                <input type="checkbox" class="case" name="case" value="<?php echo $af; ?>" checked="checked"/>
                            <?php } ?>                            
                        <?php }else{ ?>
                            <?php if($af=="Access unlimited"){?>
                                <input type="checkbox" class="case" name="case" value="<?php echo $af; ?>" id="au" />
                            <?php }else{ ?>
                                <input type="checkbox" class="case" name="case" value="<?php echo $af; ?>"  />
                            <?php } ?>
                        <?php } ?>
                        <span><?php echo $af;?></span>
                    </div>
                    <?php  } ?>     
                    <?php if (in_array("Access unlimited",$checkedarrray)){?>
                        <script type="text/javascript">
                            $(function(){
                                $('.date').show();
                            });
                        </script>
                    <?php } ?>
                    <div class="date" style="clear:both;display:none;">
                       <span>AU Maintenance Expires</span>
                       <input type="text" id="datepicker" name="application_date" value="<?php echo dPformSafe(@$obj->application_date); ?>" readonly/>
                       <input type="button" value="Refresh" id="refresh" style="cursor: pointer;" />
                       <div style="clear:both;margin-top:10px;"></div>
                       <span>AU Maintenance Amount</span>
                       <input type="text" name="application_amount" id="application_amount" value="<?php echo dPformSafe(@$obj->application_amount); ?>" />
                       <?php 
                            $data1 = mysql_query("SELECT sysval_value FROM sysvals WHERE sysval_title='AUMaintenancePeriod'")
                            or die(mysql_error()); 
                            while($info1 = mysql_fetch_array($data1)) 
                            { 
                               $result1=$info1['sysval_value'];
                            }
                            $new=explode(",",$result1);
                       ?>
                       <div style="clear:both;margin-top:10px;"></div>
                       <span>AU Contract Period: </span>
                       <?php foreach($new as $n){                                 
                       $as = explode('|',$n); 
                       $array[] = $as[1];
                       }
                       ?>
                       <?php echo arraySelect($array, 'application_period', 'size="1" class="text"', @$obj->application_period, true);?>
                       <!-- select id="application_period" name="application_period" >
                            <option value="<?php //echo $as[0]; ?>"><?php //echo $as[1]; ?></option>
                            <?php //} ?>
                        
                       </select -->   
                    </div>
                    <?php //echo arraySelect($array, 'application_period', 'size="1" class="text"', @$obj->application_period, true);?>
                        
                    <?php /*
                    <div class="boxes">
                        <?php if (in_array("eABC",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="eABC" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="eABC" />
                        <?php } ?>
                        <span>eABC</span>                        
                    </div>
                    <div class="boxes">
                        <?php if (in_array("M3",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="M3" checked="checked"/>
                       <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="M3"/>
                       <?php } ?>
                        <span>M3</span>
                    </div>
                    <div class="boxes">
                         <?php if (in_array("Vista2",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="Vista2" checked="checked"/>
                         <?php }else{ ?>   
                            <input type="checkbox" class="case" name="case" value="Vista2" />
                         <?php  } ?>   
                        <span>Vista2</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("OmniLink",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="OmniLink" checked="checked" />
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="OmniLink" />
                        <?php } ?>
                        <span>OmniLink</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("AUJS",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="AUJS" checked="checked" />
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="AUJS" />
                        <?php } ?>
                        <span>AUJS</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("BPS",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="BPS" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="BPS" />
                        <?php } ?>
                        <span>BPS</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("MSI",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="MSI" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="MSI" />
                        <?php } ?>
                        <span>MSI</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("ABC",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="ABC" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="ABC" />
                        <?php } ?>
                        <span>ABC</span>
                    </div>
                    <div class="boxes">
                        <?php if (in_array("Clutch",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="Clutch" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="Clutch" />
                        <?php } ?>
                        <span>Clutch</span>
                    </div>
                   <div class="boxes">
                       <?php if (in_array("Archer",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="Archer" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="Archer" />
                        <?php } ?>
                        <span>Archer</span>
                    </div>
                   <div class="boxes">
                       <?php if (in_array("Daily Insight",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="Daily Insight" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="Daily Insight" />
                        <?php } ?>
                        <span>Daily Insight</span>
                    </div>
                   <div class="boxes">
                       <?php if (in_array("Aspen",$checkedarrray)){?>
                            <input type="checkbox" class="case" name="case" value="Aspen" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" name="case" value="Aspen" />
                        <?php } ?>
                        <span>Aspen</span>
                    </div>
                    <div class="boxes">
                       <?php if (in_array("Access unlimited",$checkedarrray)){?>
                            <input type="checkbox" class="case" id="auchecked" name="case" value="Access unlimited" checked="checked"/>
                        <?php }else{ ?>
                            <input type="checkbox" class="case" id="au" name="case" value="Access unlimited" />
                        <?php } ?>
                        <span>Access Unlimited</span>
                    </div>
                    <?php if (in_array("Access unlimited",$checkedarrray)){?>
                        <script type="text/javascript">
                            $(function(){
                                $('.date').show();
                            });
                        </script>
                    <?php } ?>
                        <div class="date" style="clear:both;display:none;">
                           <span>AU Maintenance Expires</span>
                           <input type="text" id="datepicker" name="application_date" value="<?php echo dPformSafe(@$obj->application_date); ?>" readonly/>
                           <input type="button" value="Refresh" id="refresh" style="cursor: pointer;" />
                        </div>
                     */
                    ?>
                </td>                
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Email'); ?>:</td>
                <td>
                    <input type="text" class="text" name="company_email" value="<?php 
                    echo dPformSafe(@$obj->company_email);?>" size="30" maxlength="255" />
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Phone'); ?>:</td>
                <td>
                    <input type="text" class="text" name="company_phone1" value="<?php echo dPformSafe(@$obj->company_phone1); ?>" maxlength="30" />
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Phone'); ?>2:</td>
                <td>
                    <input type="text" class="text" name="company_phone2" value="<?php echo dPformSafe(@$obj->company_phone2); ?>" maxlength="50" />
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Fax'); ?>:</td>
                <td>
                    <input type="text" class="text" name="company_fax" value="<?php echo dPformSafe(@$obj->company_fax); ?>" maxlength="30" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <img src="images/shim.gif" width="50" height="1" alt="" /><?php echo $AppUI->_('Address'); ?><br />
                    <hr width="500" align="center" size="1" />
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Address'); ?>1:</td>
                <td><input type="text" class="text" name="company_address1" value="<?php 
                echo dPformSafe(@$obj->company_address1); ?>" size="50" maxlength="255" />
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Address'); ?>2:</td>
                <td><input type="text" class="text" name="company_address2" value="<?php 
                echo dPformSafe(@$obj->company_address2); ?>" size="50" maxlength="255" /></td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('City'); ?>:</td>
                <td><input type="text" class="text" name="company_city" value="<?php 
                echo dPformSafe(@$obj->company_city); ?>" size="50" maxlength="50" /></td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('State'); ?>:</td>
                <td><input type="text" class="text" name="company_state" value="<?php 
                echo dPformSafe(@$obj->company_state); ?>" maxlength="50" /></td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Zip'); ?>:</td>
                <td><input type="text" class="text" name="company_zip" value="<?php 
                echo dPformSafe(@$obj->company_zip); ?>" maxlength="15" /></td>
            </tr>
            <tr>
                <td align="right">URL http://<A name="x"></a></td>
                <td><input type="text" class="text" value="<?php 
                echo dPformSafe(@$obj->company_primary_url); 
                ?>" name="company_primary_url" size="50" maxlength="255" />
                    <a href="#x" onclick="testURL('CompanyURLOne')">[<?php echo $AppUI->_('test'); ?>]</a>
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Company Owner'); ?>:</td>
                <td><?php echo arraySelect($owners, 'company_owner', 'size="1" class="text"', 
                        ((@$obj->company_owner) ? $obj->company_owner : $AppUI->user_id));?>
                </td>
            </tr>
            <tr>
                <td align="right"><?php echo $AppUI->_('Type'); ?>:</td>
                <td><?php echo arraySelect($types, 'company_type', 'size="1" class="text"', @$obj->company_type, true);?>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top"><?php echo $AppUI->_('Description'); ?>:</td>
                <td align="left">
                    <textarea cols="70" rows="10" class="textarea" name="company_description"><?php 
                    echo htmlspecialchars(@$obj->company_description); ?></textarea>
                </td>
            </tr>
        </table>
    </td>
    <td align='left'>
		<?php
                require_once($AppUI->getSystemClass('CustomFields'));
                $custom_fields = New CustomFields($m, $a, $obj->company_id, 'edit');
                $custom_fields->printHTML();
                ?>		
    </td>
</tr>
<tr>
    <td>
        <input type="button" value="<?php echo $AppUI->_('back'); ?>" class="button" onclick="javascript:history.back(-1);" />
    </td>
    <td align="right"><input type="button" value="<?php echo $AppUI->_('submit'); ?>" class="button" onclick="javascript:submitIt()" />
    </td>
</tr>
</table>
</form>
