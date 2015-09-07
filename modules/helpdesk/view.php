<?php /* HELPDESK $Id: view.php,v 1.72 2005/04/07 22:20:29 bloaterpaste Exp $ */


$item_id = dPgetParam( $_GET, 'item_id', 0 );

// Get pagination page
if (isset($_GET['page'])) {
  $AppUI->setState('HelpDeskLogPage', $_GET['page']);
} else {
  $AppUI->setState('HelpDeskLogPage', 0);
}

$page = $AppUI->getState('HelpDeskLogPage') ? $AppUI->getState('HelpDeskLogPage') : 0;

// Get tab state
if (isset( $_GET['tab'] )) {
	$AppUI->setState( 'HelpLogVwTab', $_GET['tab'] );
}
$tab = $AppUI->getState( 'HelpLogVwTab' ) !== NULL ? $AppUI->getState( 'HelpLogVwTab' ) : 0;

// Pull data
$sql = "SELECT hi.*,
        CONCAT(co.contact_first_name,' ',co.contact_last_name) assigned_to_fullname,
        co.contact_email as assigned_email,
        p.project_id,
        p.project_name,
        p.project_color_identifier,
        c.company_name,
        d.dept_name
        FROM helpdesk_items hi
        LEFT JOIN users u ON u.user_id = hi.item_assigned_to
        LEFT JOIN contacts co ON co.contact_id = u.user_contact
        LEFT JOIN projects p ON p.project_id = hi.item_project_id
        LEFT JOIN companies c ON c.company_id = hi.item_company_id
        LEFT JOIN departments d ON d.dept_id = hi.item_department_id
        WHERE item_id = '$item_id'";

if (!db_loadHash( $sql, $hditem )) {
	$titleBlock = new CTitleBlock( $AppUI->_('Invalid item id'), 'helpdesk.png', $m, 'ID_HELP_HELPDESK_VIEW' );
	$titleBlock->addCrumb( "?m=helpdesk", 'Home' );
	$titleBlock->addCrumb( "?m=helpdesk&a=list", 'List' );
	$titleBlock->show();
} else {
  // Check permissions on this record

  $canRead = hditemReadable($hditem);
  $canEdit = hditemEditable($hditem);

  if(!$canRead && !$canEdit){
	  $AppUI->redirect( "m=public&a=access_denied" );
  }

  $name = $hditem['item_requestor'];
  $assigned_to_name = $hditem["item_assigned_to"] ? $hditem["assigned_to_fullname"] : "";
  $assigned_email = $hditem["assigned_email"];

$sql = "
	SELECT 
		helpdesk_item_watchers.user_id, 
		CONCAT(contact_first_name, ' ', contact_last_name) as name,
		contact_email
	FROM 
		helpdesk_item_watchers
		LEFT JOIN users ON helpdesk_item_watchers.user_id = users.user_id
		LEFT JOIN contacts ON user_contact = contact_id
	WHERE 
		item_id = ".$item_id."
	ORDER BY contact_last_name, contact_first_name";

 $watchers = db_loadlist( $sql );

  $titleBlock = new CTitleBlock( 'Viewing Help Desk Item', 'helpdesk.png', $m, 'ID_HELP_HELPDESK_IDX' );
  if (hditemCreate()) {
    $titleBlock->addCell(
      '<input type="submit" class="button" value="'.$AppUI->_('New Item').'" />', '',
      '<form action="?m=helpdesk&a=addedit" method="post">', '</form>'
    );
  }

	$titleBlock->addCrumb( "?m=helpdesk", 'Home');
	$titleBlock->addCrumb( "?m=helpdesk&a=list", 'List');

	if ($canEdit) {
    $titleBlock->addCrumbDelete('Delete this item', 1);
		$titleBlock->addCrumb( "?m=helpdesk&a=addedit&item_id=$item_id", 'Edit this item' );
	}

	$titleBlock->show();
?>
  <script language="JavaScript">
  function delIt() {
    if (confirm( "<?php print $AppUI->_('doDelete').' '.$AppUI->_('Item').'?';?>" )) {
      document.frmDelete.submit();
    }
  }

  function toggle_comment(id){
     var element = document.getElementById(id)
     element.style.display = (element.style.display == '' || element.style.display == "none") ? "inline" : "none"
  }
  </script>

  <table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td valign="top">
  <table border="0" cellpadding="4" cellspacing="0" width="100%" class="std">
  <tr>
    <td valign="top" width="50%" colspan="2">
      <strong><?=$AppUI->_('Item Details')?></strong>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <table cellspacing="1" cellpadding="2" width="100%">
      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Number')?>:</td>
        <td class="hilite" width="100%"><?=$hditem["item_id"]?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Title')?>:</td>
        <td class="hilite" width="100%"><?=$hditem["item_title"]?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Requestor')?>:</td>
        <td class="hilite" width="100%"><?php
          print $hditem["item_requestor_email"] ? 
            "<a href=\"mailto:".$hditem["item_requestor_email"]."\">".$hditem['item_requestor']."</a>" :
            $hditem['item_requestor'];?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Requestor Phone')?>:</td>
        <td class="hilite" width="100%"><?=$hditem["item_requestor_phone"]?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Assigned To')?>:</td>
        <td class="hilite" width="100%"><?php
          print $assigned_email ?
            "<a href=\"mailto:$assigned_email\">$assigned_to_name</a>" :
            $assigned_to_name;?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Company')?>:</td>
        <td class="hilite" width="100%"><?=$hditem["company_name"]?></td>
      </tr>

      <tr>
          <td align="right" nowrap="nowrap"><?=$AppUI->_('Department')?>:</td>
          <td class="hilite" width="100%"><?=$hditem["dept_name"]?></td>
      </tr>
      
      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Project')?>:</td>
        <td class="hilite" width="100%" style="background-color: <?='#' . $hditem['project_color_identifier']?>;"><a href="./index.php?m=projects&a=view&project_id=<?=$hditem["project_id"]?>"; style="color: <?= bestColor( $hditem['project_color_identifier'] ) ?>;"><?=$hditem["project_name"]?></a></td>
      </tr>
    </table>
    </td><td valign="top">
    <table cellspacing="1" cellpadding="2" width="100%">
      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Call Type')?>:</td>
        <td class="hilite" width="100%"><?php
          print $AppUI->_($ict[$hditem["item_calltype"]])." ";
          print dPshowImage (dPfindImage( 'ct'.$hditem["item_calltype"].'.png', $m ), 15, 17, 'align=center');
        ?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Call Source')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$ics[$hditem["item_source"]])?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Status')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$ist[$hditem["item_status"]])?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Priority')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$ipr[$hditem["item_priority"]])?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Severity')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$isv[$hditem["item_severity"]])?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Operating System')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$ios[$hditem["item_os"]])?></td>
      </tr>

      <tr>
        <td align="right" nowrap="nowrap"><?=$AppUI->_('Application')?>:</td>
        <td class="hilite" width="100%"><?=$AppUI->_(@$iap[$hditem["item_application"]])?></td>
      </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="top" colspan="2">
      
      <table cellspacing="0" cellpadding="2" border="0" width="100%">
      <tr>
        <td><strong><?=$AppUI->_('Summary')?></strong></td>
        <td><strong><?=$AppUI->_('Watchers')?></strong></td>
      <tr>
        <td class="hilite" width="50%"><?=str_replace( chr(10), "<br />", linkLinks($hditem["item_summary"]))?>&nbsp;</td>
        <td class="hilite" width="50%"><?php
		$delimiter = "";
		foreach($watchers as $watcher){
			echo "$delimiter <a href=\"mailto: {$watcher['contact_email']}\">".$watcher['name']."</a>";
			$delimiter = ",";
		}
        ?>&nbsp;</td>
      </tr>
      
      </table>

    </td>
  </tr>
  </table>
  </td></tr>
  <tr><td valign="top">
  <?php 

  $tabBox = new CTabBox( "?m=helpdesk&a=view&item_id=$item_id", "", $tab );
  $tabBox->add( dPgetConfig('root_dir') . '/modules/helpdesk/vw_logs', 'Task Logs' );

  if ($canEdit) {
    $tabBox->add( dPgetConfig('root_dir') . '/modules/helpdesk/vw_log_update', 'New Log' );
  }
  $tabBox->add( dPgetConfig('root_dir') . '/modules/helpdesk/vw_history', 'Item History' );

  $tabBox->show();
} 
?>
</td></tr></table>

<form name="frmDelete" action="./index.php?m=helpdesk&a=list" method="post">
  <input type="hidden" name="dosql" value="do_item_aed">
  <input type="hidden" name="del" value="1" />
  <input type="hidden" name="item_id" value="<?=$item_id?>" />
</form>
