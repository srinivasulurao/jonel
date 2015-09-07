#
# $Id: upgrade_latest.sql 6177 2012-08-14 07:51:05Z ajdonnison $
#
# DO NOT USE THIS SCRIPT DIRECTLY - USE THE INSTALLER INSTEAD.
#
# All entries must be date stamped in the correct format.
#
# 20130223
# add batching maintenance expiration date
ALTER TABLE `%dbprefix%departments` ADD `dept_batching_maintenance` date default NULL AFTER `dept_owner`;

# 20130317
# add departments to helpdesk_items
ALTER TABLE `%dbprefix%helpdesk_items` ADD `item_department_id` int(11) NOT NULL default '0' AFTER `item_company_id`;
