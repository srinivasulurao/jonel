<?php /* HELPDESK $Id: addedit.php,v 1.65 2005/05/20 16:45:09 zibas Exp $ */

$item_id = dPgetParam($_GET, 'item_id', 0);

$allowedCompanies = arrayMerge( array( 0 => '' ), getAllowedCompanies() );

$projects = getAllowedProjectsForJavascript();

//$allowedDepartments = arrayMerge(array(0 => ''), getAllowedDepartments());
$allowedDepartments = getAllowedDepartmentsForJavascript();

// Pull data
$sql = "SELECT *
        FROM helpdesk_items
        WHERE item_id = '$item_id'";

db_loadHash( $sql, $hditem );

// Check permissions for this record
$perms=& $AppUI->acl();
$canView = $perms->checkModule( $m, 'view');
if ($item_id) {
  // Already existing item
  $canEdit = $perms->checkModuleItem($m, 'edit', $item_id);
} else {
  $canEdit = $perms->checkModule($m, 'add');
}
if (!canView) {
  $AppUI->redirect( "m=public&a=access_denied" );
}
if(!$canEdit){
  $AppUI->redirect( "m=public&a=access_denied" );
}

if(!@$hditem["item_assigned_to"] && $HELPDESK_CONFIG['default_assigned_to_current_user']){
  @$hditem["item_assigned_to"] = $AppUI->user_id;
  @$hditem["item_status"] = 1;
}

if(!@$hditem["item_company_id"] && $HELPDESK_CONFIG['default_company_current_company']){
  @$hditem["item_company_id"] = $AppUI->user_company;
}

$users = getAllowedUsers();

$sql = "SELECT company_id, company_name
        FROM companies
        WHERE "
     . getCompanyPerms("company_id")
     . "ORDER BY company_name";

$companies = arrayMerge( array( 0 => '' ), db_loadHashList( $sql ) );

$sql = "
	SELECT 
		helpdesk_item_watchers.user_id, 
		CONCAT(contact_last_name, ',', contact_first_name) as name,
		contact_email
	FROM 
		helpdesk_item_watchers
		LEFT JOIN users ON helpdesk_item_watchers.user_id = users.user_id
		LEFT JOIN contacts ON user_contact = contact_id
        WHERE 
        	item_id = ".$item_id."
        ORDER BY contact_last_name, contact_first_name";

$watchers = db_loadHashList( $sql );


// Setup the title block
$ttl = $item_id ? 'Editing Help Desk Item' : 'Adding Help Desk Item';

$titleBlock = new CTitleBlock( $ttl, 'helpdesk.png', $m, "$m.$a" );
$titleBlock->addCrumb( "?m=helpdesk", 'Home' );
$titleBlock->addCrumb( "?m=helpdesk&a=list", 'List');

if ($item_id) {
  $titleBlock->addCrumb( "?m=helpdesk&a=view&item_id=$item_id", 'View this item' );
}

$titleBlock->show();

if ($item_id) { 
  $df = $AppUI->getPref('SHDATEFORMAT');
  $tf = $AppUI->getPref('TIMEFORMAT');
  $item_date = new CDate( $hditem["item_created"] );
  $tc = $item_date->format( "$df $tf" );
} else {
//  $hditem["item_created"] = db_unix2dateTime(time());
  $hditem["item_created"] = date('Y-m-d H:i:s');
}

?>
<script src="http://code.jquery.com/jquery-1.8.2.js"></script>
<script language="javascript">
function submitIt() {
  var f   = document.frmHelpDeskItem;
  var msg = '';

  if ( f.item_title.value.length < 1 ) {
    msg += "\n<?=$AppUI->_('Title')?>";
    f.item_title.focus();
  }

  if( f.item_requestor.value.length < 1 ) {
    msg += "\n<?=$AppUI->_('Requestor')?>";
    f.item_requestor.focus();
  }

  if( f.item_summary.value.length < 1 ) {
    msg += "\n<?=$AppUI->_('Summary')?>";
    f.item_summary.focus();
  }

  //concat all the multiselect values together for easier retrieval on the back end.
  var watchers = "";
  var list = f.watchers_select;
  for (var i=0, n = list.options.length; i < n; i++) {
    var user = list.options[i];
    if(user.selected)
    	watchers += user.value + ",";
  }
  if(watchers.length>0){
  	f.watchers.value = watchers.substring(0,watchers.length-1);
  }
  
  if( msg.length > 0) {
    alert('<?php echo $AppUI->_('helpdeskSubmitError', UI_OUTPUT_JS); ?>:' + msg)
  } else {
    f.submit();
  }
} 

function popUserDialog() {
  window.open('./index.php?m=helpdesk&a=selector&callback=setUserRequestor&table=users&dialog=1', 'selector', 'left=50,top=50,height=250,width=400,resizable,scrollbars=yes')
}

function popContactDialog() {
  window.open('./index.php?m=helpdesk&a=selector&callback=setContactRequestor&table=contacts&dialog=1', 'selector', 'left=50,top=50,height=250,width=400,resizable,scrollbars=yes')
}

var oldRequestor = '';

// Callback function for the generic selector
function setRequestor( key, val ) {
  var f = document.frmHelpDeskItem;

  if (val != '') {
    f.item_requestor_id.value = key;
    f.item_requestor.value = val;
    oldRequestor = val;

    // Since we probably chose someone else, wipe the e-mail and phone fields
    f.item_requestor_email.value = '';
    f.item_requestor_phone.value = '';
  }
}

function setUserRequestor( key, val ) {
  var f = document.frmHelpDeskItem;

  if (val != '') {
    setRequestor( key, val );
    f.item_requestor_type.value = 1
  }
}

function setContactRequestor( key, val ) {
  var f = document.frmHelpDeskItem;

  if (val != '') {
    setRequestor( key, val );
    f.item_requestor_type.value = 2
  }
}

function updateStatus(obj){
  var f = document.frmHelpDeskItem;

  if(obj.options[obj.selectedIndex].value>0){
    if(f.item_status.selectedIndex==0){
    	f.item_status.selectedIndex=1;
    }
  }
}

<?php 
$ua = $_SERVER['HTTP_USER_AGENT'];
$isMoz = strpos( $ua, 'Gecko' ) !== false;


print "\nvar projects = new Array(";
print isset($projects) ? implode(",\n", $projects ) : "";
print ")"; 

print "\nvar departments = new Array(";
print isset($allowedDepartments) ? implode(",\n", $allowedDepartments ) : "";
print ")"; 
?>

// Dynamic project list handling functions

function emptyList( list ) {
<?php if ($isMoz) { ?>
  list.options.length = 0;
<?php } else { ?>
  while( list.options.length > 0 )
    list.options.remove(0);
<?php } ?>
}

function addToList( list, text, value ) {
<?php if ($isMoz) { ?>
  list.options[list.options.length] = new Option(text, value);
<?php } else { ?>
  var newOption = document.createElement("OPTION");
  newOption.text = text;
  newOption.value = value;
  list.add( newOption, 0 );
<?php } ?>
}

function changeList( listName, source, target ) {
  var f = document.frmHelpDeskItem;
  var list = eval( 'f.'+listName );
  
  // Clear the options
  emptyList( list );
  
  // Refill the list based on the target
  // Add a blank first to force a change
  addToList( list, '', '0' );
  for (var i=0, n = source.length; i < n; i++) {
    if( source[i][0] == target ) {
      addToList( list, source[i][2], source[i][1] );
    }
  }
}

// Select an item in the list by target value
function selectList( listName, target ) {
  var f = document.frmHelpDeskItem;
  var list = eval( 'f.'+listName );

  for (var i=0, n = list.options.length; i < n; i++) {
    if( list.options[i].value == target ) {
      list.options.selectedIndex = i;
      return;
    }
  }
}

function companyListChanged(obj) {
    changeList('item_project_id',projects, obj.options[obj.selectedIndex].value);
    changeList('item_department_id', departments, obj.options[obj.selectedIndex].value);
}

</script>
<script type="text/javascript">
    $s= jQuery.noConflict();
    $s(function(){
        $s('#c').change(function(){
            var cmpid = $s(this).val();
            var domain1=document.domain;
	    var url='modules/helpdesk/comp.php';
            //alert(url);
            //var url='http://localhost:8080/dotproject/modules/helpdesk/comp.php';
            $s.ajax({
                type: "POST",
                url: url,
                data: {id: cmpid},
                dataType: "html",
                success: function(data){
                    if(data === "null"){
                        $s('#customselect').hide();
                        $s('#defalutselect').show();
                        $s('#dates').hide();
                    }else{
                        var array = data.split('@');
                        if(array[0]===""){
                            $s('#dates').hide();
                        }else{
                            $s('#dates').html(array[0]);
                            $s('#dates').show();
                        }
                        if(array[1]!=='Please select company'){
                           if(array[1]!=="null"){
                                $s('#defalutselect').hide();
                                $s('#customselect').html(array[1]);
                                $s('#customselect').show();
                                $s('#appdate').html(array[0]);
                           }else{
                                $s('#customselect').hide();
                                $s('#defalutselect').show();
                           }
                        }else{
                            $s('#customselect').hide();
                            $s('#defalutselect').show();
                        }
                    }
                }
            });            
        });
        $s('#customselect, #pai').change(function(){
           var source = $s(this).find(":selected").val();
           $s('#defalutselect, #iap').val(source);
        });
    });
    
    $s(document).ready(function(){
            var cmpid = $s('#c').val();
            var itemid = $s("#item_id").val();
            var domain1=document.domain;
	        var url='modules/helpdesk/comp1.php';
            //alert(url);
            //var url='http://localhost:8080/dotproject/modules/helpdesk/comp.php';
            $s.ajax({
                type: "POST",
                url: url,
                data: {id: cmpid,item_id: itemid},
                dataType: "html",
                success: function(data){
                    if(data === "null"){
                        $s('#customselect').hide();
                        $s('#defalutselect').show();
                        $s('#dates').hide();
                    }else{
                        if(data == "Please select company"){
                            $s('#customselect').hide();
                            $s('#defalutselect').show();
                            $s('#dates').hide();
                        }else{
                            var array = data.split('@');
                            //alert(array[0]);
                            if(array[0]=== "null"){                            
                                $s('#dates').hide();
                            }else{                            
                                $s('#dates').html(array[0]);                
                                $s('#dates').show();
                            }
                            var n=array[1].split(",");
                            if(array[1]!='Please select company'){
                               if(array[1]!="null"){
                                    $s('#defalutselect').hide();
                                    $s('#customselect').html(n[0]);
                                    $s('#pai').val(n[1]);
                                    $s('#customselect').show();
                               }else{
                                    $s('#customselect').hide();
                                    $s('#defalutselect').show();
                               }
                            }else{
                                $s('#customselect').hide();
                                $s('#defalutselect').show();
                            }
                        }
                    }
                }
            }); 
    });
</script>
<table cellspacing="1" cellpadding="1" border="0" width="100%" class="std">
  <form name="frmHelpDeskItem" action="?m=helpdesk" method="post">
  <input type="hidden" name="dosql" value="do_item_aed" />
  <input name="del" type="hidden" value="0" />
  <input type="hidden" name="item_id" value="<?=$item_id?>" id="item_id" />
  <input type="hidden" name="item_requestor_type" value="<?=@$hditem["item_requestor_type"]?>" />
  <input type="hidden" name="item_requestor_id" value="<?=@$hditem["item_requestor_id"]?>" />
  <input type="hidden" name="item_created" value="<?=@$hditem["item_created"]?>" />
  <?php if(!$item_id){ ?>
  <input type="hidden" name="item_created_by" value="<?=$AppUI->user_id?>" />
  <?php } ?>

  <tr>
  <td valign="top" width="50%">
    <table cellspacing="0" cellpadding="2" border="0">
    <?php if ($item_id) { ?>
    <tr>
      <td align="right" nowrap><?=$AppUI->_('Date Created')?>:</td>
      <td width="100%"><strong><?=$tc?></strong></td>
    </tr>
    <?php } ?>
    <tr>
      <td align="right"><font color="red"><label for="it">* <?=$AppUI->_('Title')?>:</label></font></td>
      <td valign="top"><input type="text" class="text" id="it" name="item_title"
                              value="<?=@$hditem["item_title"]?>" maxlength="64" /></td>
    </tr>

    <tr>
      <td align="right" nowrap><font color="red"><label for="ir">* <?=$AppUI->_('Requestor');?>:</label></font></td>
      <td valign="top" nowrap>
        <input type="text" class="text" id="ir" name="item_requestor"
        value="<?=@$hditem["item_requestor"]?>" maxlength="64"
        onChange="if (this.value!=oldRequestor) {
                    document.frmHelpDeskItem.item_requestor_id.value = 0;
                    oldRequestor = this.value;
                  }" />
      <input type="button" class="button" value="<?=$AppUI->_('Users')?>" onclick="popUserDialog();" />
  <!-- <input type="button" class="button" value="<?=$AppUI->_('Contacts')?>" onclick="popContactDialog();" /> -->
      </td>
    </tr>

    <tr>
      <td align="right" nowrap><label for="ire">&dagger; <?=$AppUI->_('Requestor E-mail');?>:</label></td>
      <td valign="top"><input type="text" class="text" id="ire"
                              name="item_requestor_email"
                              value="<?=@$hditem["item_requestor_email"]?>"
                              maxlength="64" /></td>
    </tr>

    <tr>
      <td align="right" nowrap><label for="irp">&dagger; <?=$AppUI->_('Requestor Phone');?>:</label></td>
      <td valign="top"><input type="text" class="text" id="irp"
                              name="item_requestor_phone"
                              value="<?=@$hditem["item_requestor_phone"]?>"
                              maxlength="30" /></td>
    </tr>

    <tr>
      <td align="right"><label for="c"><?=$AppUI->_('Company')?>:</label></td>
      <td><?=arraySelect( $allowedCompanies, 'item_company_id', 'size="1" class="text" id="c" onchange="companyListChanged(this)"',
                          @$hditem["item_company_id"] )?></td>
    </tr>

    <tr>
      <td align="right"><label for="d"><?=$AppUI->_('Department')?>:</label></td>
      <td><select name="item_department_id" size="1" class="text" id="d"></select></td>
    </tr>
    
    <tr>
      <td align="right"><label for="p"><?=$AppUI->_('Project')?>:</label></td>
      <td><select name="item_project_id" size="1" class="text" id="p"></select></td>
    </tr>

    <tr>
      <td align="right" valign="top"><label for="iat"><?=$AppUI->_('Assigned To')?>:</label></td>
      <td><?=arraySelect( arrayMerge( array( 0 => '' ), $users), 'item_assigned_to', 'size="1" class="text" id="iat" onchange="updateStatus(this)"',
                          @$hditem["item_assigned_to"] )?>
        <br/><input type="checkbox" name="item_notify" value="1" id="in"
        <?php 
          if (!$item_id) {
            print $HELPDESK_CONFIG['default_notify_by_email'] ? "checked" : "";
          } else {
            print $hditem["item_notify"] ? "checked" : "";
          }
        ?>
        />
        <label for="in"><?=$AppUI->_( 'Notify by e-mail' );?></label></td>
    </tr>


    </table>
  </td>
  <td valign="top" width="50%">
    <table cellspacing="0" cellpadding="2" border="0">
    <tr>
      <td align="right" nowrap><label for="ict"><?=$AppUI->_('Call Type')?>:</label></td>
      <td><?=arraySelect( $ict, 'item_calltype', 'size="1" class="text" id="ict"',
                          @$hditem["item_calltype"], true )?></td>
    </tr>

    <tr>
      <td align="right" nowrap><label for="ics"><?=$AppUI->_('Call Source')?>:</label></td>
      <td><?=arraySelect( $ics, 'item_source', 'size="1" class="text" id="ics"',
                          @$hditem["item_source"], true)?></td>
    </tr>

    <tr>
      <td align="right"><label for="ist"><?=$AppUI->_('Status')?>:</label></td>
      <td><?=arraySelect( $ist, 'item_status', 'size="1" class="text" id="ist"',
                          @$hditem["item_status"], true )?></td>
    </tr>

    <tr>
      <td align="right"><label for="ipr"><?=$AppUI->_('Priority')?>:</label></td>
      <td><?=arraySelect( $ipr, 'item_priority', 'size="1" class="text" id="ipr"',
                          @$hditem["item_priority"], true )?></td>
    </tr>

    <tr>
      <td align="right"><label for="isv"><?=$AppUI->_('Severity')?>:</label></td>
      <td><?=arraySelect( $isv, 'item_severity', 'size="1" class="text" id="isv"',
                          @$hditem["item_severity"], true )?></td>
    </tr>

    <tr>
      <td align="right" nowrap><label for="ios"><?=$AppUI->_('Operating System')?>:</label></td>
      <td><?=arraySelect( $ios, 'item_os', 'size="1" class="text" id="ios"',
                          @$hditem["item_os"], true)?></td>
    </tr>

    <tr>
      <td align="right"><label for="iap"><?=$AppUI->_('Application')?>:</label></td>
      <td id="defalutselect"><?=arraySelect( $iap, 'item_application', 'size="1" class="text" id="iap"',
                          @$hditem["item_application"], true)?></td>
      <td id="customselect" style="display:none;"></td>
    </tr>
    </table>
  </td>
</tr>

<tr>
    <td colspan="2">
        <div style="float:left;">
            <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td align="left"><font color="red"><label for="summary">* <?=$AppUI->_('Summary')?>:</label></font></td>
                    <td><label for="watchers"><?=$AppUI->_('Watchers')?>:</label></td>
                </tr>
                <tr>
                    <td valign="top">
                        <textarea id="summary" cols="75" rows="15" class="textarea"
                                  name="item_summary"><?=@$hditem["item_summary"]?></textarea>
                    </td>
                    <td valign="top">
                        <select name="watchers_select" size="17" class="text" id="watchers_select" multiple="multiple"><?php
                        foreach($users as $id => $name){
                            echo "<option value=\"{$id}\"";
                            if(array_key_exists($id,$watchers))
                                    echo " selected";
                            echo ">{$name}</option>";
                        }
                        ?>
                        </select>
                        <input type="hidden" name="watchers" value="" /></td>
                </tr>
            </table>
        </div>
        <div id="dates" style="display: none;float:left; margin-left:30px;">
        </div>
    </td>
</tr>

<tr>
  <td colspan="2">
  <br>
  <small>
    <font color="red">* <?=$AppUI->_('Required field')?></font><br>
    &dagger; <?=$AppUI->_('helpdeskFieldMessage')?>
  </small>
  <br><br>
  </td>
</tr>

<tr>
  <td><input type="button" value="<?=$AppUI->_('back')?>" class="button" onClick="javascript:history.back(-1);" /></td>
  <td align="right"><input type="button" value="<?=$AppUI->_('submit')?>" class="button" onClick="submitIt()" /></td>
</tr>

</form>
</table>

<p>&nbsp;</p>
<?php 
  /* If we have a company stored, pre-select it.
     If we have a project but not a company (version <0.2) do a reverse
     lookup.
     Else, select nothing */
  if (@$hditem['item_company_id']) {
    $target = $hditem['item_company_id'];
  } else if (@$hditem['item_project_id']) {
    $target = $reverse[$hditem['item_project_id']];
  } else {
    $target = 0;
  }

  /* Select the project from the list */
  $select = @$hditem['item_project_id'] ? $hditem['item_project_id'] : 0;
  
  $selectdept = @$hditem['item_department_id'] ? $hditem['item_department_id'] : 0;
?>

<script language="javascript">
selectList('item_company_id',<?=$target?>);
changeList('item_project_id', projects, <?=$target?>);
selectList('item_project_id',<?=$select?>);
changeList('item_department_id', departments, <?=$target?>);
selectList('item_department_id',<?=$selectdept?>);
</script>
