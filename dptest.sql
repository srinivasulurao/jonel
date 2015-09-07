-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 18, 2015 at 10:56 AM
-- Server version: 5.1.50
-- PHP Version: 5.3.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dptest`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `au_batching_contracts`
--
CREATE TABLE IF NOT EXISTS `au_batching_contracts` (
`Company` varchar(100)
,`Batching_Serial_Number` varchar(16)
,`Plant_Name` varchar(255)
,`End_Date` date
,`Amount` decimal(14,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `batching_departments`
--
CREATE TABLE IF NOT EXISTS `batching_departments` (
`Company` varchar(100)
,`Batching_Serial_Number` varchar(5)
,`Plant_Name` varchar(255)
,`Start_Date` date
,`End_Date` date
,`Amount` decimal(14,2)
,`Company_Address1` varchar(50)
,`Company_address2` varchar(50)
,`Company_City` varchar(30)
,`Company_State` varchar(30)
,`Company_Zip` varchar(11)
,`Company_Phone` varchar(30)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `batching_maintenance1`
--
CREATE TABLE IF NOT EXISTS `batching_maintenance1` (
`Company` varchar(100)
,`Batching_Serial_Number` varchar(5)
,`Plant_Name` varchar(255)
,`Start_Date` date
,`End_Date` date
,`Amount` varchar(25)
,`Company_Address1` varchar(50)
,`Company_address2` varchar(50)
,`Company_City` varchar(30)
,`Company_State` varchar(30)
,`Company_Zip` varchar(11)
,`Company_Phone` varchar(30)
);
-- --------------------------------------------------------

--
-- Table structure for table `billingcode`
--

CREATE TABLE IF NOT EXISTS `billingcode` (
  `billingcode_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `billingcode_name` varchar(25) NOT NULL DEFAULT '',
  `billingcode_value` float NOT NULL DEFAULT '0',
  `billingcode_desc` varchar(255) NOT NULL DEFAULT '',
  `billingcode_status` int(1) NOT NULL DEFAULT '0',
  `company_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billingcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `billingcode`
--


-- --------------------------------------------------------

--
-- Table structure for table `common_notes`
--

CREATE TABLE IF NOT EXISTS `common_notes` (
  `note_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `note_author` int(10) unsigned NOT NULL DEFAULT '0',
  `note_module` int(10) unsigned NOT NULL DEFAULT '0',
  `note_record_id` int(10) unsigned NOT NULL DEFAULT '0',
  `note_category` int(3) unsigned NOT NULL DEFAULT '0',
  `note_title` varchar(100) NOT NULL DEFAULT '',
  `note_body` text NOT NULL,
  `note_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `note_hours` float NOT NULL DEFAULT '0',
  `note_code` varchar(8) NOT NULL DEFAULT '',
  `note_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `note_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note_modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `common_notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE IF NOT EXISTS `companies` (
  `company_id` int(10) NOT NULL AUTO_INCREMENT,
  `company_module` int(10) NOT NULL DEFAULT '0',
  `company_name` varchar(100) DEFAULT '',
  `company_phone1` varchar(30) DEFAULT '',
  `company_phone2` varchar(30) DEFAULT '',
  `company_fax` varchar(30) DEFAULT '',
  `company_address1` varchar(50) DEFAULT '',
  `company_address2` varchar(50) DEFAULT '',
  `company_city` varchar(30) DEFAULT '',
  `company_state` varchar(30) DEFAULT '',
  `company_zip` varchar(11) DEFAULT '',
  `company_primary_url` varchar(255) DEFAULT '',
  `company_owner` int(11) NOT NULL DEFAULT '0',
  `company_description` text,
  `company_type` int(3) NOT NULL DEFAULT '0',
  `company_email` varchar(255) DEFAULT NULL,
  `company_custom` longtext,
  `company_application` varchar(50) DEFAULT 'NOT NULL',
  `application_date` varchar(30) DEFAULT 'NOT NULL',
  `application_amount` int(11) NOT NULL DEFAULT '0',
  `application_period` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`company_id`),
  KEY `idx_cpy1` (`company_owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`company_id`, `company_module`, `company_name`, `company_phone1`, `company_phone2`, `company_fax`, `company_address1`, `company_address2`, `company_city`, `company_state`, `company_zip`, `company_primary_url`, `company_owner`, `company_description`, `company_type`, `company_email`, `company_custom`, `company_application`, `application_date`, `application_amount`, `application_period`) VALUES
(1, 0, 'Acme Construction', '', '', '', '500 E. Walnut', '', 'Fullerton', 'CA', '92832', '', 1, 'These are notes about the customer', 1, '', NULL, 'M3,ABC,Daily Insight,Archer,Access unlimited', '06/30/2013', 150, 3),
(2, 0, 'Test', '', '', '', '', '', '', '', '', '', 1, '', 0, 'asdf', NULL, '', '09/25/2013', 0, 0),
(3, 0, 'MIke Company', '585-658-2248', '', '', '', '', '', '', '', '', 1, '', 0, 'MIke im', NULL, 'Access unlimited', '05/13/2013', 1400, 1),
(4, 0, 'Jonel Engineering', '', '', '', '2000 Balcom', '', 'Anaheim', 'CA', '92832', '', 2, '', 1, '', NULL, 'Archer,Access unlimited', '07/09/2015', 800, 1);

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  `config_group` varchar(255) NOT NULL DEFAULT '',
  `config_type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`config_id`, `config_name`, `config_value`, `config_group`, `config_type`) VALUES
(1, 'host_locale', 'en', '', 'text'),
(2, 'check_overallocation', 'false', '', 'checkbox'),
(3, 'currency_symbol', '$', '', 'text'),
(4, 'host_style', 'default', '', 'text'),
(5, 'company_name', 'My Company', '', 'text'),
(6, 'page_title', 'Jonel Projects [Demo]', '', 'text'),
(7, 'site_domain', 'example.com', '', 'text'),
(8, 'email_prefix', '[dotProject]', '', 'text'),
(9, 'admin_username', 'admin', '', 'text'),
(10, 'username_min_len', '4', '', 'text'),
(11, 'password_min_len', '4', '', 'text'),
(12, 'enable_gantt_charts', 'true', '', 'checkbox'),
(13, 'log_changes', 'false', '', 'checkbox'),
(14, 'check_task_dates', 'true', '', 'checkbox'),
(15, 'check_task_empty_dynamic', 'false', '', 'checkbox'),
(16, 'locale_warn', 'false', '', 'checkbox'),
(17, 'locale_alert', '^', '', 'text'),
(18, 'daily_working_hours', '8', '', 'text'),
(19, 'display_debug', 'false', '', 'checkbox'),
(20, 'link_tickets_kludge', 'false', '', 'checkbox'),
(21, 'show_all_task_assignees', 'false', '', 'checkbox'),
(22, 'direct_edit_assignment', 'false', '', 'checkbox'),
(23, 'restrict_color_selection', 'false', '', 'checkbox'),
(24, 'cal_day_view_show_minical', 'true', '', 'checkbox'),
(25, 'cal_day_start', '8', '', 'text'),
(26, 'cal_day_end', '17', '', 'text'),
(27, 'cal_day_increment', '15', '', 'text'),
(28, 'cal_working_days', '1,2,3,4,5', '', 'text'),
(29, 'restrict_task_time_editing', 'false', '', 'checkbox'),
(30, 'default_view_m', 'calendar', '', 'text'),
(31, 'default_view_a', 'day_view', '', 'text'),
(32, 'default_view_tab', '1', '', 'text'),
(33, 'index_max_file_size', '-1', '', 'text'),
(34, 'session_handling', 'app', 'session', 'select'),
(35, 'session_idle_time', '2d', 'session', 'text'),
(36, 'session_max_lifetime', '1m', 'session', 'text'),
(37, 'debug', '1', '', 'text'),
(38, 'parser_default', '/usr/bin/strings', '', 'text'),
(39, 'parser_application/msword', '/usr/bin/strings', '', 'text'),
(40, 'parser_text/html', '/usr/bin/strings', '', 'text'),
(41, 'parser_application/pdf', '/usr/bin/pdftotext', '', 'text'),
(42, 'files_ci_preserve_attr', 'true', '', 'checkbox'),
(43, 'files_show_versions_edit', 'false', '', 'checkbox'),
(44, 'auth_method', 'sql', 'auth', 'select'),
(45, 'ldap_host', 'localhost', 'ldap', 'text'),
(46, 'ldap_port', '389', 'ldap', 'text'),
(47, 'ldap_version', '3', 'ldap', 'text'),
(48, 'ldap_base_dn', 'dc=saki,dc=com,dc=au', 'ldap', 'text'),
(49, 'ldap_user_filter', '(uid=%USERNAME%)', 'ldap', 'text'),
(50, 'postnuke_allow_login', 'true', 'auth', 'checkbox'),
(51, 'reset_memory_limit', '32M', '', 'text'),
(52, 'mail_transport', 'php', 'mail', 'select'),
(53, 'mail_host', 'localhost', 'mail', 'text'),
(54, 'mail_port', '25', 'mail', 'text'),
(55, 'mail_auth', 'false', 'mail', 'checkbox'),
(56, 'mail_user', '', 'mail', 'text'),
(57, 'mail_pass', '', 'mail', 'password'),
(58, 'mail_defer', 'false', 'mail', 'checkbox'),
(59, 'mail_timeout', '30', 'mail', 'text'),
(60, 'session_gc_scan_queue', 'false', 'session', 'checkbox'),
(61, 'task_reminder_control', 'false', 'task_reminder', 'checkbox'),
(62, 'task_reminder_days_before', '1', 'task_reminder', 'text'),
(63, 'task_reminder_repeat', '100', 'task_reminder', 'text'),
(64, 'gacl_cache', 'false', 'gacl', 'checkbox'),
(65, 'gacl_expire', 'true', 'gacl', 'checkbox'),
(66, 'gacl_cache_dir', '/tmp', 'gacl', 'text'),
(67, 'gacl_timeout', '600', 'gacl', 'text'),
(68, 'mail_smtp_tls', 'false', 'mail', 'checkbox'),
(69, 'ldap_search_user', 'Manager', 'ldap', 'text'),
(70, 'ldap_search_pass', 'secret', 'ldap', 'password'),
(71, 'ldap_allow_login', 'true', 'ldap', 'checkbox'),
(72, 'user_contact_inactivate', 'true', 'auth', 'checkbox'),
(73, 'user_contact_activate', 'false', 'auth', 'checkbox');

-- --------------------------------------------------------

--
-- Table structure for table `config_list`
--

CREATE TABLE IF NOT EXISTS `config_list` (
  `config_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL DEFAULT '0',
  `config_list_name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_list_id`),
  KEY `config_id` (`config_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `config_list`
--

INSERT INTO `config_list` (`config_list_id`, `config_id`, `config_list_name`) VALUES
(1, 44, 'sql'),
(2, 44, 'ldap'),
(3, 44, 'pn'),
(4, 34, 'app'),
(5, 34, 'php'),
(6, 52, 'php'),
(7, 52, 'smtp');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_first_name` varchar(30) DEFAULT NULL,
  `contact_last_name` varchar(30) DEFAULT NULL,
  `contact_order_by` varchar(30) NOT NULL DEFAULT '',
  `contact_title` varchar(50) DEFAULT NULL,
  `contact_birthday` date DEFAULT NULL,
  `contact_job` varchar(255) DEFAULT NULL,
  `contact_company` varchar(100) NOT NULL DEFAULT '',
  `contact_department` tinytext,
  `contact_type` varchar(20) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_email2` varchar(255) DEFAULT NULL,
  `contact_url` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `contact_phone2` varchar(30) DEFAULT NULL,
  `contact_fax` varchar(30) DEFAULT NULL,
  `contact_mobile` varchar(30) DEFAULT NULL,
  `contact_address1` varchar(60) DEFAULT NULL,
  `contact_address2` varchar(60) DEFAULT NULL,
  `contact_city` varchar(30) DEFAULT NULL,
  `contact_state` varchar(30) DEFAULT NULL,
  `contact_zip` varchar(11) DEFAULT NULL,
  `contact_country` varchar(30) DEFAULT NULL,
  `contact_jabber` varchar(255) DEFAULT NULL,
  `contact_icq` varchar(20) DEFAULT NULL,
  `contact_msn` varchar(255) DEFAULT NULL,
  `contact_yahoo` varchar(255) DEFAULT NULL,
  `contact_aol` varchar(30) DEFAULT NULL,
  `contact_notes` text,
  `contact_project` int(11) NOT NULL DEFAULT '0',
  `contact_icon` varchar(20) DEFAULT 'obj/contact',
  `contact_owner` int(10) unsigned DEFAULT '0',
  `contact_private` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`contact_id`),
  KEY `idx_oby` (`contact_order_by`),
  KEY `idx_co` (`contact_company`),
  KEY `idx_prp` (`contact_project`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contact_id`, `contact_first_name`, `contact_last_name`, `contact_order_by`, `contact_title`, `contact_birthday`, `contact_job`, `contact_company`, `contact_department`, `contact_type`, `contact_email`, `contact_email2`, `contact_url`, `contact_phone`, `contact_phone2`, `contact_fax`, `contact_mobile`, `contact_address1`, `contact_address2`, `contact_city`, `contact_state`, `contact_zip`, `contact_country`, `contact_jabber`, `contact_icq`, `contact_msn`, `contact_yahoo`, `contact_aol`, `contact_notes`, `contact_project`, `contact_icon`, `contact_owner`, `contact_private`) VALUES
(1, 'Admin', 'Person', '', NULL, NULL, NULL, '', NULL, NULL, 'admin@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'obj/contact', 0, 0),
(2, 'Test', 'User', '', NULL, NULL, NULL, '0', NULL, NULL, 'testuser@me.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'obj/contact', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_lists`
--

CREATE TABLE IF NOT EXISTS `custom_fields_lists` (
  `field_id` int(11) DEFAULT NULL,
  `list_option_id` int(11) DEFAULT NULL,
  `list_value` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custom_fields_lists`
--


-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_struct`
--

CREATE TABLE IF NOT EXISTS `custom_fields_struct` (
  `field_id` int(11) NOT NULL,
  `field_module` varchar(30) DEFAULT NULL,
  `field_page` varchar(30) DEFAULT NULL,
  `field_htmltype` varchar(20) DEFAULT NULL,
  `field_datatype` varchar(20) DEFAULT NULL,
  `field_order` int(11) DEFAULT NULL,
  `field_name` varchar(100) DEFAULT NULL,
  `field_extratags` varchar(250) DEFAULT NULL,
  `field_description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custom_fields_struct`
--


-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_values`
--

CREATE TABLE IF NOT EXISTS `custom_fields_values` (
  `value_id` int(11) DEFAULT NULL,
  `value_module` varchar(30) DEFAULT NULL,
  `value_object_id` int(11) DEFAULT NULL,
  `value_field_id` int(11) DEFAULT NULL,
  `value_charvalue` varchar(250) DEFAULT NULL,
  `value_intvalue` int(11) DEFAULT NULL,
  KEY `idx_cfv_id` (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custom_fields_values`
--


-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE IF NOT EXISTS `departments` (
  `dept_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dept_parent` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_company` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_name` tinytext NOT NULL,
  `dept_phone` varchar(30) DEFAULT NULL,
  `dept_fax` varchar(30) DEFAULT NULL,
  `dept_address1` varchar(30) DEFAULT NULL,
  `dept_address2` varchar(30) DEFAULT NULL,
  `dept_city` varchar(30) DEFAULT NULL,
  `dept_state` varchar(30) DEFAULT NULL,
  `dept_zip` varchar(11) DEFAULT NULL,
  `dept_url` varchar(25) DEFAULT NULL,
  `dept_desc` text,
  `dept_owner` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_batching_maintenance` date DEFAULT NULL,
  `dept_batching_type` int(11) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Department heirarchy under a company' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_parent`, `dept_company`, `dept_name`, `dept_phone`, `dept_fax`, `dept_address1`, `dept_address2`, `dept_city`, `dept_state`, `dept_zip`, `dept_url`, `dept_desc`, `dept_owner`, `dept_batching_maintenance`, `dept_batching_type`) VALUES
(1, 0, 1, '26433 Valvista', '', '', '', '', 'Fullerton', '', '92832', '1000', '', 0, '2015-01-01', 0),
(2, 0, 1, '30456 Dobson', '', '', '', '', '', '', '', '1000', '', 0, '2015-01-01', 0),
(3, 0, 1, '26451 Rio Rancho', '', '', '', '', '', '', '', '1000', '', 0, '2015-01-01', 1),
(4, 0, 2, 'Fromm Plant', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1200', NULL, 0, '2013-05-03', 1),
(5, 0, 3, 'Flynn Plant', '', '', '', '', '', '', '', '1000', '', 0, '2013-04-10', 1),
(6, 0, 4, '30456 Anaheim', '', '', '', '', '', '', '', '1000', '', 0, '2015-05-01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dotpermissions`
--

CREATE TABLE IF NOT EXISTS `dotpermissions` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(80) NOT NULL DEFAULT '',
  `section` varchar(80) NOT NULL DEFAULT '',
  `axo` varchar(80) NOT NULL DEFAULT '',
  `permission` varchar(80) NOT NULL DEFAULT '',
  `allow` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '0',
  KEY `user_id` (`user_id`,`section`,`permission`,`axo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dotpermissions`
--

INSERT INTO `dotpermissions` (`acl_id`, `user_id`, `section`, `axo`, `permission`, `allow`, `priority`, `enabled`) VALUES
(22, '1', 'app', 'helpdesk', 'access', 1, 1, 1),
(22, '1', 'app', 'helpdesk', 'add', 1, 1, 1),
(22, '1', 'app', 'helpdesk', 'delete', 1, 1, 1),
(22, '1', 'app', 'helpdesk', 'edit', 1, 1, 1),
(22, '1', 'app', 'helpdesk', 'view', 1, 1, 1),
(19, '2', 'app', 'helpdesk', 'access', 1, 1, 1),
(19, '2', 'app', 'helpdesk', 'add', 1, 1, 1),
(19, '2', 'app', 'helpdesk', 'delete', 1, 1, 1),
(19, '2', 'app', 'helpdesk', 'edit', 1, 1, 1),
(19, '2', 'app', 'helpdesk', 'view', 1, 1, 1),
(20, '1', 'app', 'admin', 'access', 1, 2, 1),
(20, '1', 'app', 'system', 'access', 1, 2, 1),
(20, '1', 'app', 'roles', 'access', 1, 2, 1),
(20, '1', 'app', 'users', 'access', 1, 2, 1),
(20, '1', 'app', 'admin', 'add', 1, 2, 1),
(20, '1', 'app', 'system', 'add', 1, 2, 1),
(20, '1', 'app', 'roles', 'add', 1, 2, 1),
(20, '1', 'app', 'users', 'add', 1, 2, 1),
(20, '1', 'app', 'admin', 'delete', 1, 2, 1),
(20, '1', 'app', 'system', 'delete', 1, 2, 1),
(20, '1', 'app', 'roles', 'delete', 1, 2, 1),
(20, '1', 'app', 'users', 'delete', 1, 2, 1),
(20, '1', 'app', 'admin', 'edit', 1, 2, 1),
(20, '1', 'app', 'system', 'edit', 1, 2, 1),
(20, '1', 'app', 'roles', 'edit', 1, 2, 1),
(20, '1', 'app', 'users', 'edit', 1, 2, 1),
(20, '1', 'app', 'admin', 'view', 1, 2, 1),
(20, '1', 'app', 'system', 'view', 1, 2, 1),
(20, '1', 'app', 'roles', 'view', 1, 2, 1),
(20, '1', 'app', 'users', 'view', 1, 2, 1),
(21, '1', 'app', 'calendar', 'access', 1, 2, 1),
(21, '1', 'app', 'events', 'access', 1, 2, 1),
(21, '1', 'app', 'companies', 'access', 1, 2, 1),
(21, '1', 'app', 'contacts', 'access', 1, 2, 1),
(21, '1', 'app', 'departments', 'access', 1, 2, 1),
(21, '1', 'app', 'files', 'access', 1, 2, 1),
(21, '1', 'app', 'file_folders', 'access', 1, 2, 1),
(21, '1', 'app', 'forums', 'access', 1, 2, 1),
(21, '1', 'app', 'help', 'access', 1, 2, 1),
(21, '1', 'app', 'projects', 'access', 1, 2, 1),
(21, '1', 'app', 'tasks', 'access', 1, 2, 1),
(21, '1', 'app', 'task_log', 'access', 1, 2, 1),
(21, '1', 'app', 'ticketsmith', 'access', 1, 2, 1),
(21, '1', 'app', 'public', 'access', 1, 2, 1),
(21, '1', 'app', 'helpdesk', 'access', 1, 2, 1),
(21, '1', 'app', 'smartsearch', 'access', 1, 2, 1),
(21, '1', 'app', 'calendar', 'add', 1, 2, 1),
(21, '1', 'app', 'events', 'add', 1, 2, 1),
(21, '1', 'app', 'companies', 'add', 1, 2, 1),
(21, '1', 'app', 'contacts', 'add', 1, 2, 1),
(21, '1', 'app', 'departments', 'add', 1, 2, 1),
(21, '1', 'app', 'files', 'add', 1, 2, 1),
(21, '1', 'app', 'file_folders', 'add', 1, 2, 1),
(21, '1', 'app', 'forums', 'add', 1, 2, 1),
(21, '1', 'app', 'help', 'add', 1, 2, 1),
(21, '1', 'app', 'projects', 'add', 1, 2, 1),
(21, '1', 'app', 'tasks', 'add', 1, 2, 1),
(21, '1', 'app', 'task_log', 'add', 1, 2, 1),
(21, '1', 'app', 'ticketsmith', 'add', 1, 2, 1),
(21, '1', 'app', 'public', 'add', 1, 2, 1),
(21, '1', 'app', 'helpdesk', 'add', 1, 2, 1),
(21, '1', 'app', 'smartsearch', 'add', 1, 2, 1),
(21, '1', 'app', 'calendar', 'delete', 1, 2, 1),
(21, '1', 'app', 'events', 'delete', 1, 2, 1),
(21, '1', 'app', 'companies', 'delete', 1, 2, 1),
(21, '1', 'app', 'contacts', 'delete', 1, 2, 1),
(21, '1', 'app', 'departments', 'delete', 1, 2, 1),
(21, '1', 'app', 'files', 'delete', 1, 2, 1),
(21, '1', 'app', 'file_folders', 'delete', 1, 2, 1),
(21, '1', 'app', 'forums', 'delete', 1, 2, 1),
(21, '1', 'app', 'help', 'delete', 1, 2, 1),
(21, '1', 'app', 'projects', 'delete', 1, 2, 1),
(21, '1', 'app', 'tasks', 'delete', 1, 2, 1),
(21, '1', 'app', 'task_log', 'delete', 1, 2, 1),
(21, '1', 'app', 'ticketsmith', 'delete', 1, 2, 1),
(21, '1', 'app', 'public', 'delete', 1, 2, 1),
(21, '1', 'app', 'helpdesk', 'delete', 1, 2, 1),
(21, '1', 'app', 'smartsearch', 'delete', 1, 2, 1),
(21, '1', 'app', 'calendar', 'edit', 1, 2, 1),
(21, '1', 'app', 'events', 'edit', 1, 2, 1),
(21, '1', 'app', 'companies', 'edit', 1, 2, 1),
(21, '1', 'app', 'contacts', 'edit', 1, 2, 1),
(21, '1', 'app', 'departments', 'edit', 1, 2, 1),
(21, '1', 'app', 'files', 'edit', 1, 2, 1),
(21, '1', 'app', 'file_folders', 'edit', 1, 2, 1),
(21, '1', 'app', 'forums', 'edit', 1, 2, 1),
(21, '1', 'app', 'help', 'edit', 1, 2, 1),
(21, '1', 'app', 'projects', 'edit', 1, 2, 1),
(21, '1', 'app', 'tasks', 'edit', 1, 2, 1),
(21, '1', 'app', 'task_log', 'edit', 1, 2, 1),
(21, '1', 'app', 'ticketsmith', 'edit', 1, 2, 1),
(21, '1', 'app', 'public', 'edit', 1, 2, 1),
(21, '1', 'app', 'helpdesk', 'edit', 1, 2, 1),
(21, '1', 'app', 'smartsearch', 'edit', 1, 2, 1),
(21, '1', 'app', 'calendar', 'view', 1, 2, 1),
(21, '1', 'app', 'events', 'view', 1, 2, 1),
(21, '1', 'app', 'companies', 'view', 1, 2, 1),
(21, '1', 'app', 'contacts', 'view', 1, 2, 1),
(21, '1', 'app', 'departments', 'view', 1, 2, 1),
(21, '1', 'app', 'files', 'view', 1, 2, 1),
(21, '1', 'app', 'file_folders', 'view', 1, 2, 1),
(21, '1', 'app', 'forums', 'view', 1, 2, 1),
(21, '1', 'app', 'help', 'view', 1, 2, 1),
(21, '1', 'app', 'projects', 'view', 1, 2, 1),
(21, '1', 'app', 'tasks', 'view', 1, 2, 1),
(21, '1', 'app', 'task_log', 'view', 1, 2, 1),
(21, '1', 'app', 'ticketsmith', 'view', 1, 2, 1),
(21, '1', 'app', 'public', 'view', 1, 2, 1),
(21, '1', 'app', 'helpdesk', 'view', 1, 2, 1),
(21, '1', 'app', 'smartsearch', 'view', 1, 2, 1),
(17, '2', 'app', 'admin', 'access', 1, 2, 1),
(17, '2', 'app', 'system', 'access', 1, 2, 1),
(17, '2', 'app', 'roles', 'access', 1, 2, 1),
(17, '2', 'app', 'users', 'access', 1, 2, 1),
(17, '2', 'app', 'admin', 'add', 1, 2, 1),
(17, '2', 'app', 'system', 'add', 1, 2, 1),
(17, '2', 'app', 'roles', 'add', 1, 2, 1),
(17, '2', 'app', 'users', 'add', 1, 2, 1),
(17, '2', 'app', 'admin', 'delete', 1, 2, 1),
(17, '2', 'app', 'system', 'delete', 1, 2, 1),
(17, '2', 'app', 'roles', 'delete', 1, 2, 1),
(17, '2', 'app', 'users', 'delete', 1, 2, 1),
(17, '2', 'app', 'admin', 'edit', 1, 2, 1),
(17, '2', 'app', 'system', 'edit', 1, 2, 1),
(17, '2', 'app', 'roles', 'edit', 1, 2, 1),
(17, '2', 'app', 'users', 'edit', 1, 2, 1),
(17, '2', 'app', 'admin', 'view', 1, 2, 1),
(17, '2', 'app', 'system', 'view', 1, 2, 1),
(17, '2', 'app', 'roles', 'view', 1, 2, 1),
(17, '2', 'app', 'users', 'view', 1, 2, 1),
(18, '2', 'app', 'calendar', 'access', 1, 2, 1),
(18, '2', 'app', 'events', 'access', 1, 2, 1),
(18, '2', 'app', 'companies', 'access', 1, 2, 1),
(18, '2', 'app', 'contacts', 'access', 1, 2, 1),
(18, '2', 'app', 'departments', 'access', 1, 2, 1),
(18, '2', 'app', 'files', 'access', 1, 2, 1),
(18, '2', 'app', 'file_folders', 'access', 1, 2, 1),
(18, '2', 'app', 'forums', 'access', 1, 2, 1),
(18, '2', 'app', 'help', 'access', 1, 2, 1),
(18, '2', 'app', 'projects', 'access', 1, 2, 1),
(18, '2', 'app', 'tasks', 'access', 1, 2, 1),
(18, '2', 'app', 'task_log', 'access', 1, 2, 1),
(18, '2', 'app', 'ticketsmith', 'access', 1, 2, 1),
(18, '2', 'app', 'public', 'access', 1, 2, 1),
(18, '2', 'app', 'helpdesk', 'access', 1, 2, 1),
(18, '2', 'app', 'smartsearch', 'access', 1, 2, 1),
(18, '2', 'app', 'calendar', 'add', 1, 2, 1),
(18, '2', 'app', 'events', 'add', 1, 2, 1),
(18, '2', 'app', 'companies', 'add', 1, 2, 1),
(18, '2', 'app', 'contacts', 'add', 1, 2, 1),
(18, '2', 'app', 'departments', 'add', 1, 2, 1),
(18, '2', 'app', 'files', 'add', 1, 2, 1),
(18, '2', 'app', 'file_folders', 'add', 1, 2, 1),
(18, '2', 'app', 'forums', 'add', 1, 2, 1),
(18, '2', 'app', 'help', 'add', 1, 2, 1),
(18, '2', 'app', 'projects', 'add', 1, 2, 1),
(18, '2', 'app', 'tasks', 'add', 1, 2, 1),
(18, '2', 'app', 'task_log', 'add', 1, 2, 1),
(18, '2', 'app', 'ticketsmith', 'add', 1, 2, 1),
(18, '2', 'app', 'public', 'add', 1, 2, 1),
(18, '2', 'app', 'helpdesk', 'add', 1, 2, 1),
(18, '2', 'app', 'smartsearch', 'add', 1, 2, 1),
(18, '2', 'app', 'calendar', 'delete', 1, 2, 1),
(18, '2', 'app', 'events', 'delete', 1, 2, 1),
(18, '2', 'app', 'companies', 'delete', 1, 2, 1),
(18, '2', 'app', 'contacts', 'delete', 1, 2, 1),
(18, '2', 'app', 'departments', 'delete', 1, 2, 1),
(18, '2', 'app', 'files', 'delete', 1, 2, 1),
(18, '2', 'app', 'file_folders', 'delete', 1, 2, 1),
(18, '2', 'app', 'forums', 'delete', 1, 2, 1),
(18, '2', 'app', 'help', 'delete', 1, 2, 1),
(18, '2', 'app', 'projects', 'delete', 1, 2, 1),
(18, '2', 'app', 'tasks', 'delete', 1, 2, 1),
(18, '2', 'app', 'task_log', 'delete', 1, 2, 1),
(18, '2', 'app', 'ticketsmith', 'delete', 1, 2, 1),
(18, '2', 'app', 'public', 'delete', 1, 2, 1),
(18, '2', 'app', 'helpdesk', 'delete', 1, 2, 1),
(18, '2', 'app', 'smartsearch', 'delete', 1, 2, 1),
(18, '2', 'app', 'calendar', 'view', 1, 2, 1),
(18, '2', 'app', 'events', 'view', 1, 2, 1),
(18, '2', 'app', 'companies', 'view', 1, 2, 1),
(18, '2', 'app', 'contacts', 'view', 1, 2, 1),
(18, '2', 'app', 'departments', 'view', 1, 2, 1),
(18, '2', 'app', 'files', 'view', 1, 2, 1),
(18, '2', 'app', 'file_folders', 'view', 1, 2, 1),
(18, '2', 'app', 'forums', 'view', 1, 2, 1),
(18, '2', 'app', 'help', 'view', 1, 2, 1),
(18, '2', 'app', 'projects', 'view', 1, 2, 1),
(18, '2', 'app', 'tasks', 'view', 1, 2, 1),
(18, '2', 'app', 'task_log', 'view', 1, 2, 1),
(18, '2', 'app', 'ticketsmith', 'view', 1, 2, 1),
(18, '2', 'app', 'public', 'view', 1, 2, 1),
(18, '2', 'app', 'helpdesk', 'view', 1, 2, 1),
(18, '2', 'app', 'smartsearch', 'view', 1, 2, 1),
(12, '1', 'sys', 'acl', 'access', 1, 3, 1),
(12, '2', 'sys', 'acl', 'access', 1, 3, 1),
(11, '1', 'app', 'admin', 'access', 1, 4, 1),
(11, '1', 'app', 'calendar', 'access', 1, 4, 1),
(11, '1', 'app', 'events', 'access', 1, 4, 1),
(11, '1', 'app', 'companies', 'access', 1, 4, 1),
(11, '1', 'app', 'contacts', 'access', 1, 4, 1),
(11, '1', 'app', 'departments', 'access', 1, 4, 1),
(11, '1', 'app', 'files', 'access', 1, 4, 1),
(11, '1', 'app', 'file_folders', 'access', 1, 4, 1),
(11, '1', 'app', 'forums', 'access', 1, 4, 1),
(11, '1', 'app', 'help', 'access', 1, 4, 1),
(11, '1', 'app', 'projects', 'access', 1, 4, 1),
(11, '1', 'app', 'system', 'access', 1, 4, 1),
(11, '1', 'app', 'tasks', 'access', 1, 4, 1),
(11, '1', 'app', 'task_log', 'access', 1, 4, 1),
(11, '1', 'app', 'ticketsmith', 'access', 1, 4, 1),
(11, '1', 'app', 'public', 'access', 1, 4, 1),
(11, '1', 'app', 'roles', 'access', 1, 4, 1),
(11, '1', 'app', 'users', 'access', 1, 4, 1),
(11, '1', 'app', 'helpdesk', 'access', 1, 4, 1),
(11, '1', 'app', 'smartsearch', 'access', 1, 4, 1),
(11, '1', 'app', 'admin', 'add', 1, 4, 1),
(11, '1', 'app', 'calendar', 'add', 1, 4, 1),
(11, '1', 'app', 'events', 'add', 1, 4, 1),
(11, '1', 'app', 'companies', 'add', 1, 4, 1),
(11, '1', 'app', 'contacts', 'add', 1, 4, 1),
(11, '1', 'app', 'departments', 'add', 1, 4, 1),
(11, '1', 'app', 'files', 'add', 1, 4, 1),
(11, '1', 'app', 'file_folders', 'add', 1, 4, 1),
(11, '1', 'app', 'forums', 'add', 1, 4, 1),
(11, '1', 'app', 'help', 'add', 1, 4, 1),
(11, '1', 'app', 'projects', 'add', 1, 4, 1),
(11, '1', 'app', 'system', 'add', 1, 4, 1),
(11, '1', 'app', 'tasks', 'add', 1, 4, 1),
(11, '1', 'app', 'task_log', 'add', 1, 4, 1),
(11, '1', 'app', 'ticketsmith', 'add', 1, 4, 1),
(11, '1', 'app', 'public', 'add', 1, 4, 1),
(11, '1', 'app', 'roles', 'add', 1, 4, 1),
(11, '1', 'app', 'users', 'add', 1, 4, 1),
(11, '1', 'app', 'helpdesk', 'add', 1, 4, 1),
(11, '1', 'app', 'smartsearch', 'add', 1, 4, 1),
(11, '1', 'app', 'admin', 'delete', 1, 4, 1),
(11, '1', 'app', 'calendar', 'delete', 1, 4, 1),
(11, '1', 'app', 'events', 'delete', 1, 4, 1),
(11, '1', 'app', 'companies', 'delete', 1, 4, 1),
(11, '1', 'app', 'contacts', 'delete', 1, 4, 1),
(11, '1', 'app', 'departments', 'delete', 1, 4, 1),
(11, '1', 'app', 'files', 'delete', 1, 4, 1),
(11, '1', 'app', 'file_folders', 'delete', 1, 4, 1),
(11, '1', 'app', 'forums', 'delete', 1, 4, 1),
(11, '1', 'app', 'help', 'delete', 1, 4, 1),
(11, '1', 'app', 'projects', 'delete', 1, 4, 1),
(11, '1', 'app', 'system', 'delete', 1, 4, 1),
(11, '1', 'app', 'tasks', 'delete', 1, 4, 1),
(11, '1', 'app', 'task_log', 'delete', 1, 4, 1),
(11, '1', 'app', 'ticketsmith', 'delete', 1, 4, 1),
(11, '1', 'app', 'public', 'delete', 1, 4, 1),
(11, '1', 'app', 'roles', 'delete', 1, 4, 1),
(11, '1', 'app', 'users', 'delete', 1, 4, 1),
(11, '1', 'app', 'helpdesk', 'delete', 1, 4, 1),
(11, '1', 'app', 'smartsearch', 'delete', 1, 4, 1),
(11, '1', 'app', 'admin', 'edit', 1, 4, 1),
(11, '1', 'app', 'calendar', 'edit', 1, 4, 1),
(11, '1', 'app', 'events', 'edit', 1, 4, 1),
(11, '1', 'app', 'companies', 'edit', 1, 4, 1),
(11, '1', 'app', 'contacts', 'edit', 1, 4, 1),
(11, '1', 'app', 'departments', 'edit', 1, 4, 1),
(11, '1', 'app', 'files', 'edit', 1, 4, 1),
(11, '1', 'app', 'file_folders', 'edit', 1, 4, 1),
(11, '1', 'app', 'forums', 'edit', 1, 4, 1),
(11, '1', 'app', 'help', 'edit', 1, 4, 1),
(11, '1', 'app', 'projects', 'edit', 1, 4, 1),
(11, '1', 'app', 'system', 'edit', 1, 4, 1),
(11, '1', 'app', 'tasks', 'edit', 1, 4, 1),
(11, '1', 'app', 'task_log', 'edit', 1, 4, 1),
(11, '1', 'app', 'ticketsmith', 'edit', 1, 4, 1),
(11, '1', 'app', 'public', 'edit', 1, 4, 1),
(11, '1', 'app', 'roles', 'edit', 1, 4, 1),
(11, '1', 'app', 'users', 'edit', 1, 4, 1),
(11, '1', 'app', 'helpdesk', 'edit', 1, 4, 1),
(11, '1', 'app', 'smartsearch', 'edit', 1, 4, 1),
(11, '1', 'app', 'admin', 'view', 1, 4, 1),
(11, '1', 'app', 'calendar', 'view', 1, 4, 1),
(11, '1', 'app', 'events', 'view', 1, 4, 1),
(11, '1', 'app', 'companies', 'view', 1, 4, 1),
(11, '1', 'app', 'contacts', 'view', 1, 4, 1),
(11, '1', 'app', 'departments', 'view', 1, 4, 1),
(11, '1', 'app', 'files', 'view', 1, 4, 1),
(11, '1', 'app', 'file_folders', 'view', 1, 4, 1),
(11, '1', 'app', 'forums', 'view', 1, 4, 1),
(11, '1', 'app', 'help', 'view', 1, 4, 1),
(11, '1', 'app', 'projects', 'view', 1, 4, 1),
(11, '1', 'app', 'system', 'view', 1, 4, 1),
(11, '1', 'app', 'tasks', 'view', 1, 4, 1),
(11, '1', 'app', 'task_log', 'view', 1, 4, 1),
(11, '1', 'app', 'ticketsmith', 'view', 1, 4, 1),
(11, '1', 'app', 'public', 'view', 1, 4, 1),
(11, '1', 'app', 'roles', 'view', 1, 4, 1),
(11, '1', 'app', 'users', 'view', 1, 4, 1),
(11, '1', 'app', 'helpdesk', 'view', 1, 4, 1),
(11, '1', 'app', 'smartsearch', 'view', 1, 4, 1),
(11, '2', 'app', 'admin', 'access', 1, 4, 1),
(11, '2', 'app', 'calendar', 'access', 1, 4, 1),
(11, '2', 'app', 'events', 'access', 1, 4, 1),
(11, '2', 'app', 'companies', 'access', 1, 4, 1),
(11, '2', 'app', 'contacts', 'access', 1, 4, 1),
(11, '2', 'app', 'departments', 'access', 1, 4, 1),
(11, '2', 'app', 'files', 'access', 1, 4, 1),
(11, '2', 'app', 'file_folders', 'access', 1, 4, 1),
(11, '2', 'app', 'forums', 'access', 1, 4, 1),
(11, '2', 'app', 'help', 'access', 1, 4, 1),
(11, '2', 'app', 'projects', 'access', 1, 4, 1),
(11, '2', 'app', 'system', 'access', 1, 4, 1),
(11, '2', 'app', 'tasks', 'access', 1, 4, 1),
(11, '2', 'app', 'task_log', 'access', 1, 4, 1),
(11, '2', 'app', 'ticketsmith', 'access', 1, 4, 1),
(11, '2', 'app', 'public', 'access', 1, 4, 1),
(11, '2', 'app', 'roles', 'access', 1, 4, 1),
(11, '2', 'app', 'users', 'access', 1, 4, 1),
(11, '2', 'app', 'helpdesk', 'access', 1, 4, 1),
(11, '2', 'app', 'smartsearch', 'access', 1, 4, 1),
(11, '2', 'app', 'admin', 'add', 1, 4, 1),
(11, '2', 'app', 'calendar', 'add', 1, 4, 1),
(11, '2', 'app', 'events', 'add', 1, 4, 1),
(11, '2', 'app', 'companies', 'add', 1, 4, 1),
(11, '2', 'app', 'contacts', 'add', 1, 4, 1),
(11, '2', 'app', 'departments', 'add', 1, 4, 1),
(11, '2', 'app', 'files', 'add', 1, 4, 1),
(11, '2', 'app', 'file_folders', 'add', 1, 4, 1),
(11, '2', 'app', 'forums', 'add', 1, 4, 1),
(11, '2', 'app', 'help', 'add', 1, 4, 1),
(11, '2', 'app', 'projects', 'add', 1, 4, 1),
(11, '2', 'app', 'system', 'add', 1, 4, 1),
(11, '2', 'app', 'tasks', 'add', 1, 4, 1),
(11, '2', 'app', 'task_log', 'add', 1, 4, 1),
(11, '2', 'app', 'ticketsmith', 'add', 1, 4, 1),
(11, '2', 'app', 'public', 'add', 1, 4, 1),
(11, '2', 'app', 'roles', 'add', 1, 4, 1),
(11, '2', 'app', 'users', 'add', 1, 4, 1),
(11, '2', 'app', 'helpdesk', 'add', 1, 4, 1),
(11, '2', 'app', 'smartsearch', 'add', 1, 4, 1),
(11, '2', 'app', 'admin', 'delete', 1, 4, 1),
(11, '2', 'app', 'calendar', 'delete', 1, 4, 1),
(11, '2', 'app', 'events', 'delete', 1, 4, 1),
(11, '2', 'app', 'companies', 'delete', 1, 4, 1),
(11, '2', 'app', 'contacts', 'delete', 1, 4, 1),
(11, '2', 'app', 'departments', 'delete', 1, 4, 1),
(11, '2', 'app', 'files', 'delete', 1, 4, 1),
(11, '2', 'app', 'file_folders', 'delete', 1, 4, 1),
(11, '2', 'app', 'forums', 'delete', 1, 4, 1),
(11, '2', 'app', 'help', 'delete', 1, 4, 1),
(11, '2', 'app', 'projects', 'delete', 1, 4, 1),
(11, '2', 'app', 'system', 'delete', 1, 4, 1),
(11, '2', 'app', 'tasks', 'delete', 1, 4, 1),
(11, '2', 'app', 'task_log', 'delete', 1, 4, 1),
(11, '2', 'app', 'ticketsmith', 'delete', 1, 4, 1),
(11, '2', 'app', 'public', 'delete', 1, 4, 1),
(11, '2', 'app', 'roles', 'delete', 1, 4, 1),
(11, '2', 'app', 'users', 'delete', 1, 4, 1),
(11, '2', 'app', 'helpdesk', 'delete', 1, 4, 1),
(11, '2', 'app', 'smartsearch', 'delete', 1, 4, 1),
(11, '2', 'app', 'admin', 'edit', 1, 4, 1),
(11, '2', 'app', 'calendar', 'edit', 1, 4, 1),
(11, '2', 'app', 'events', 'edit', 1, 4, 1),
(11, '2', 'app', 'companies', 'edit', 1, 4, 1),
(11, '2', 'app', 'contacts', 'edit', 1, 4, 1),
(11, '2', 'app', 'departments', 'edit', 1, 4, 1),
(11, '2', 'app', 'files', 'edit', 1, 4, 1),
(11, '2', 'app', 'file_folders', 'edit', 1, 4, 1),
(11, '2', 'app', 'forums', 'edit', 1, 4, 1),
(11, '2', 'app', 'help', 'edit', 1, 4, 1),
(11, '2', 'app', 'projects', 'edit', 1, 4, 1),
(11, '2', 'app', 'system', 'edit', 1, 4, 1),
(11, '2', 'app', 'tasks', 'edit', 1, 4, 1),
(11, '2', 'app', 'task_log', 'edit', 1, 4, 1),
(11, '2', 'app', 'ticketsmith', 'edit', 1, 4, 1),
(11, '2', 'app', 'public', 'edit', 1, 4, 1),
(11, '2', 'app', 'roles', 'edit', 1, 4, 1),
(11, '2', 'app', 'users', 'edit', 1, 4, 1),
(11, '2', 'app', 'helpdesk', 'edit', 1, 4, 1),
(11, '2', 'app', 'smartsearch', 'edit', 1, 4, 1),
(11, '2', 'app', 'admin', 'view', 1, 4, 1),
(11, '2', 'app', 'calendar', 'view', 1, 4, 1),
(11, '2', 'app', 'events', 'view', 1, 4, 1),
(11, '2', 'app', 'companies', 'view', 1, 4, 1),
(11, '2', 'app', 'contacts', 'view', 1, 4, 1),
(11, '2', 'app', 'departments', 'view', 1, 4, 1),
(11, '2', 'app', 'files', 'view', 1, 4, 1),
(11, '2', 'app', 'file_folders', 'view', 1, 4, 1),
(11, '2', 'app', 'forums', 'view', 1, 4, 1),
(11, '2', 'app', 'help', 'view', 1, 4, 1),
(11, '2', 'app', 'projects', 'view', 1, 4, 1),
(11, '2', 'app', 'system', 'view', 1, 4, 1),
(11, '2', 'app', 'tasks', 'view', 1, 4, 1),
(11, '2', 'app', 'task_log', 'view', 1, 4, 1),
(11, '2', 'app', 'ticketsmith', 'view', 1, 4, 1),
(11, '2', 'app', 'public', 'view', 1, 4, 1),
(11, '2', 'app', 'roles', 'view', 1, 4, 1),
(11, '2', 'app', 'users', 'view', 1, 4, 1),
(11, '2', 'app', 'helpdesk', 'view', 1, 4, 1),
(11, '2', 'app', 'smartsearch', 'view', 1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `dpversion`
--

CREATE TABLE IF NOT EXISTS `dpversion` (
  `code_version` varchar(10) NOT NULL DEFAULT '',
  `db_version` int(11) NOT NULL DEFAULT '0',
  `last_db_update` date NOT NULL DEFAULT '0000-00-00',
  `last_code_update` date NOT NULL DEFAULT '0000-00-00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dpversion`
--

INSERT INTO `dpversion` (`code_version`, `db_version`, `last_db_update`, `last_code_update`) VALUES
('2.1.7', 2, '2013-02-23', '2012-11-15');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_title` varchar(255) NOT NULL DEFAULT '',
  `event_start_date` datetime DEFAULT NULL,
  `event_end_date` datetime DEFAULT NULL,
  `event_parent` int(11) unsigned NOT NULL DEFAULT '0',
  `event_description` text,
  `event_times_recuring` int(11) unsigned NOT NULL DEFAULT '0',
  `event_recurs` int(11) unsigned NOT NULL DEFAULT '0',
  `event_remind` int(10) unsigned NOT NULL DEFAULT '0',
  `event_icon` varchar(20) DEFAULT 'obj/event',
  `event_owner` int(11) DEFAULT '0',
  `event_project` int(11) DEFAULT '0',
  `event_private` tinyint(3) DEFAULT '0',
  `event_type` tinyint(3) DEFAULT '0',
  `event_cwd` tinyint(3) DEFAULT '0',
  `event_notify` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `id_esd` (`event_start_date`),
  KEY `id_eed` (`event_end_date`),
  KEY `id_evp` (`event_parent`),
  KEY `idx_ev1` (`event_owner`),
  KEY `idx_ev2` (`event_project`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `events`
--


-- --------------------------------------------------------

--
-- Table structure for table `event_queue`
--

CREATE TABLE IF NOT EXISTS `event_queue` (
  `queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `queue_start` int(11) NOT NULL DEFAULT '0',
  `queue_type` varchar(40) NOT NULL DEFAULT '',
  `queue_repeat_interval` int(11) NOT NULL DEFAULT '0',
  `queue_repeat_count` int(11) NOT NULL DEFAULT '0',
  `queue_data` longblob NOT NULL,
  `queue_callback` varchar(127) NOT NULL DEFAULT '',
  `queue_owner` int(11) NOT NULL DEFAULT '0',
  `queue_origin_id` int(11) NOT NULL DEFAULT '0',
  `queue_module` varchar(40) NOT NULL DEFAULT '',
  `queue_module_type` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`queue_id`),
  KEY `queue_start` (`queue_start`),
  KEY `queue_module` (`queue_module`),
  KEY `queue_type` (`queue_type`),
  KEY `queue_origin_id` (`queue_origin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `event_queue`
--


-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_real_filename` varchar(255) NOT NULL DEFAULT '',
  `file_folder` int(11) NOT NULL DEFAULT '0',
  `file_project` int(11) NOT NULL DEFAULT '0',
  `file_task` int(11) NOT NULL DEFAULT '0',
  `file_name` varchar(255) NOT NULL DEFAULT '',
  `file_parent` int(11) DEFAULT '0',
  `file_description` text,
  `file_type` varchar(100) DEFAULT NULL,
  `file_owner` int(11) DEFAULT '0',
  `file_date` datetime DEFAULT NULL,
  `file_size` int(11) DEFAULT '0',
  `file_version` float NOT NULL DEFAULT '0',
  `file_icon` varchar(20) DEFAULT 'obj/',
  `file_category` int(11) DEFAULT '0',
  `file_checkout` varchar(255) NOT NULL DEFAULT '',
  `file_co_reason` text,
  `file_version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`),
  KEY `idx_file_task` (`file_task`),
  KEY `idx_file_project` (`file_project`),
  KEY `idx_file_parent` (`file_parent`),
  KEY `idx_file_vid` (`file_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `files`
--


-- --------------------------------------------------------

--
-- Table structure for table `files_index`
--

CREATE TABLE IF NOT EXISTS `files_index` (
  `file_id` int(11) NOT NULL DEFAULT '0',
  `word` varchar(50) NOT NULL DEFAULT '',
  `word_placement` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`,`word`,`word_placement`),
  KEY `idx_fwrd` (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `files_index`
--


-- --------------------------------------------------------

--
-- Table structure for table `file_folders`
--

CREATE TABLE IF NOT EXISTS `file_folders` (
  `file_folder_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_folder_parent` int(11) NOT NULL DEFAULT '0',
  `file_folder_name` varchar(255) NOT NULL DEFAULT '',
  `file_folder_description` text,
  PRIMARY KEY (`file_folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `file_folders`
--


-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `forum_id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_project` int(11) NOT NULL DEFAULT '0',
  `forum_status` tinyint(4) NOT NULL DEFAULT '-1',
  `forum_owner` int(11) NOT NULL DEFAULT '0',
  `forum_name` varchar(50) NOT NULL DEFAULT '',
  `forum_create_date` datetime DEFAULT '0000-00-00 00:00:00',
  `forum_last_date` datetime DEFAULT '0000-00-00 00:00:00',
  `forum_last_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_message_count` int(11) NOT NULL DEFAULT '0',
  `forum_description` varchar(255) DEFAULT NULL,
  `forum_moderated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`),
  KEY `idx_fproject` (`forum_project`),
  KEY `idx_fowner` (`forum_owner`),
  KEY `forum_status` (`forum_status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `forums`
--


-- --------------------------------------------------------

--
-- Table structure for table `forum_messages`
--

CREATE TABLE IF NOT EXISTS `forum_messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_forum` int(11) NOT NULL DEFAULT '0',
  `message_parent` int(11) NOT NULL DEFAULT '0',
  `message_author` int(11) NOT NULL DEFAULT '0',
  `message_editor` int(11) NOT NULL DEFAULT '0',
  `message_title` varchar(255) NOT NULL DEFAULT '',
  `message_date` datetime DEFAULT '0000-00-00 00:00:00',
  `message_body` text,
  `message_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`message_id`),
  KEY `idx_mparent` (`message_parent`),
  KEY `idx_mdate` (`message_date`),
  KEY `idx_mforum` (`message_forum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `forum_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `forum_visits`
--

CREATE TABLE IF NOT EXISTS `forum_visits` (
  `visit_user` int(10) NOT NULL DEFAULT '0',
  `visit_forum` int(10) NOT NULL DEFAULT '0',
  `visit_message` int(10) NOT NULL DEFAULT '0',
  `visit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `idx_fv` (`visit_user`,`visit_forum`,`visit_message`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forum_visits`
--


-- --------------------------------------------------------

--
-- Table structure for table `forum_watch`
--

CREATE TABLE IF NOT EXISTS `forum_watch` (
  `watch_user` int(10) unsigned NOT NULL DEFAULT '0',
  `watch_forum` int(10) unsigned DEFAULT NULL,
  `watch_topic` int(10) unsigned DEFAULT NULL,
  KEY `idx_fw1` (`watch_user`,`watch_forum`),
  KEY `idx_fw2` (`watch_user`,`watch_topic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Links users to the forums/messages they are watching';

--
-- Dumping data for table `forum_watch`
--


-- --------------------------------------------------------

--
-- Table structure for table `gacl_acl`
--

CREATE TABLE IF NOT EXISTS `gacl_acl` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT 'system',
  `allow` int(11) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '0',
  `return_value` longtext,
  `note` longtext,
  `updated_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gacl_enabled_acl` (`enabled`),
  KEY `gacl_section_value_acl` (`section_value`),
  KEY `gacl_updated_date_acl` (`updated_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_acl`
--

INSERT INTO `gacl_acl` (`id`, `section_value`, `allow`, `enabled`, `return_value`, `note`, `updated_date`) VALUES
(10, 'user', 1, 1, NULL, NULL, 1361846449),
(11, 'user', 1, 1, NULL, NULL, 1361846449),
(12, 'user', 1, 1, NULL, NULL, 1361846449),
(13, 'user', 1, 1, NULL, NULL, 1361846449),
(14, 'user', 1, 1, NULL, NULL, 1361846450),
(15, 'user', 1, 1, NULL, NULL, 1361846450),
(16, 'user', 1, 1, NULL, NULL, 1361846450),
(17, 'user', 1, 1, NULL, NULL, 1434574594),
(18, 'user', 1, 1, NULL, NULL, 1434574602),
(19, 'user', 1, 1, NULL, NULL, 1434574612),
(20, 'user', 1, 1, NULL, NULL, 1434574682),
(21, 'user', 1, 1, NULL, NULL, 1434574690),
(22, 'user', 1, 1, NULL, NULL, 1434574699);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_acl_sections`
--

CREATE TABLE IF NOT EXISTS `gacl_acl_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_acl_sections` (`value`),
  KEY `gacl_hidden_acl_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_acl_sections`
--

INSERT INTO `gacl_acl_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
(1, 'system', 1, 'System', 0),
(2, 'user', 2, 'User', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_acl_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_acl_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_acl_seq`
--

INSERT INTO `gacl_acl_seq` (`id`) VALUES
(22);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aco`
--

CREATE TABLE IF NOT EXISTS `gacl_aco` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aco` (`section_value`,`value`),
  KEY `gacl_hidden_aco` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aco`
--

INSERT INTO `gacl_aco` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'system', 'login', 1, 'Login', 0),
(11, 'application', 'access', 1, 'Access', 0),
(12, 'application', 'view', 2, 'View', 0),
(13, 'application', 'add', 3, 'Add', 0),
(14, 'application', 'edit', 4, 'Edit', 0),
(15, 'application', 'delete', 5, 'Delete', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aco_map`
--

CREATE TABLE IF NOT EXISTS `gacl_aco_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aco_map`
--

INSERT INTO `gacl_aco_map` (`acl_id`, `section_value`, `value`) VALUES
(10, 'system', 'login'),
(11, 'application', 'access'),
(11, 'application', 'add'),
(11, 'application', 'delete'),
(11, 'application', 'edit'),
(11, 'application', 'view'),
(12, 'application', 'access'),
(13, 'application', 'access'),
(13, 'application', 'view'),
(14, 'application', 'access'),
(15, 'application', 'access'),
(15, 'application', 'add'),
(15, 'application', 'delete'),
(15, 'application', 'edit'),
(15, 'application', 'view'),
(16, 'application', 'access'),
(16, 'application', 'view'),
(17, 'application', 'access'),
(17, 'application', 'add'),
(17, 'application', 'delete'),
(17, 'application', 'edit'),
(17, 'application', 'view'),
(18, 'application', 'access'),
(18, 'application', 'add'),
(18, 'application', 'delete'),
(18, 'application', 'view'),
(19, 'application', 'access'),
(19, 'application', 'add'),
(19, 'application', 'delete'),
(19, 'application', 'edit'),
(19, 'application', 'view'),
(20, 'application', 'access'),
(20, 'application', 'add'),
(20, 'application', 'delete'),
(20, 'application', 'edit'),
(20, 'application', 'view'),
(21, 'application', 'access'),
(21, 'application', 'add'),
(21, 'application', 'delete'),
(21, 'application', 'edit'),
(21, 'application', 'view'),
(22, 'application', 'access'),
(22, 'application', 'add'),
(22, 'application', 'delete'),
(22, 'application', 'edit'),
(22, 'application', 'view');

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aco_sections`
--

CREATE TABLE IF NOT EXISTS `gacl_aco_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aco_sections` (`value`),
  KEY `gacl_hidden_aco_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aco_sections`
--

INSERT INTO `gacl_aco_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'system', 1, 'System', 0),
(11, 'application', 2, 'Application', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aco_sections_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_aco_sections_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aco_sections_seq`
--

INSERT INTO `gacl_aco_sections_seq` (`id`) VALUES
(11);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aco_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_aco_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aco_seq`
--

INSERT INTO `gacl_aco_seq` (`id`) VALUES
(15);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro`
--

CREATE TABLE IF NOT EXISTS `gacl_aro` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aro` (`section_value`,`value`),
  KEY `gacl_hidden_aro` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro`
--

INSERT INTO `gacl_aro` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'user', '1', 1, 'admin', 0),
(11, 'user', '2', 1, 'testuser', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_groups`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_groups` (
  `id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`value`),
  KEY `gacl_parent_id_aro_groups` (`parent_id`),
  KEY `gacl_value_aro_groups` (`value`),
  KEY `gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_groups`
--

INSERT INTO `gacl_aro_groups` (`id`, `parent_id`, `lft`, `rgt`, `name`, `value`) VALUES
(10, 0, 1, 10, 'Roles', 'role'),
(11, 10, 2, 3, 'Administrator', 'admin'),
(12, 10, 4, 5, 'Anonymous', 'anon'),
(13, 10, 6, 7, 'Guest', 'guest'),
(14, 10, 8, 9, 'Project worker', 'normal');

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_groups_id_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_groups_id_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_groups_id_seq`
--

INSERT INTO `gacl_aro_groups_id_seq` (`id`) VALUES
(14);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_groups_map`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_groups_map`
--

INSERT INTO `gacl_aro_groups_map` (`acl_id`, `group_id`) VALUES
(10, 10),
(11, 11),
(12, 11),
(13, 13),
(14, 12),
(15, 14),
(16, 13),
(16, 14);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_map`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_map`
--

INSERT INTO `gacl_aro_map` (`acl_id`, `section_value`, `value`) VALUES
(17, 'user', '2'),
(18, 'user', '2'),
(19, 'user', '2'),
(20, 'user', '1'),
(21, 'user', '1'),
(22, 'user', '1');

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_sections`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aro_sections` (`value`),
  KEY `gacl_hidden_aro_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_sections`
--

INSERT INTO `gacl_aro_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'user', 1, 'Users', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_sections_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_sections_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_sections_seq`
--

INSERT INTO `gacl_aro_sections_seq` (`id`) VALUES
(10);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_aro_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_aro_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_aro_seq`
--

INSERT INTO `gacl_aro_seq` (`id`) VALUES
(11);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo`
--

CREATE TABLE IF NOT EXISTS `gacl_axo` (
  `id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_axo` (`section_value`,`value`),
  KEY `gacl_hidden_axo` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo`
--

INSERT INTO `gacl_axo` (`id`, `section_value`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'sys', 'acl', 1, 'ACL Administration', 0),
(11, 'app', 'admin', 1, 'User Administration', 0),
(12, 'app', 'calendar', 2, 'Calendar', 0),
(13, 'app', 'events', 2, 'Events', 0),
(14, 'app', 'companies', 3, 'Companies', 0),
(15, 'app', 'contacts', 4, 'Contacts', 0),
(16, 'app', 'departments', 5, 'Departments', 0),
(17, 'app', 'files', 6, 'Files', 0),
(18, 'app', 'file_folders', 6, 'File Folders', 0),
(19, 'app', 'forums', 7, 'Forums', 0),
(20, 'app', 'help', 8, 'Help', 0),
(21, 'app', 'projects', 9, 'Projects', 0),
(22, 'app', 'system', 10, 'System Administration', 0),
(23, 'app', 'tasks', 11, 'Tasks', 0),
(24, 'app', 'task_log', 11, 'Task Logs', 0),
(25, 'app', 'ticketsmith', 12, 'Tickets', 0),
(26, 'app', 'public', 13, 'Public', 0),
(27, 'app', 'roles', 14, 'Roles Administration', 0),
(28, 'app', 'users', 15, 'User Table', 0),
(29, 'app', 'helpdesk', 1, 'HelpDesk', 0),
(30, 'app', 'smartsearch', 1, 'SmartSearch', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_groups`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_groups` (
  `id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`value`),
  KEY `gacl_parent_id_axo_groups` (`parent_id`),
  KEY `gacl_value_axo_groups` (`value`),
  KEY `gacl_lft_rgt_axo_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_groups`
--

INSERT INTO `gacl_axo_groups` (`id`, `parent_id`, `lft`, `rgt`, `name`, `value`) VALUES
(10, 0, 1, 8, 'Modules', 'mod'),
(11, 10, 2, 3, 'All Modules', 'all'),
(12, 10, 4, 5, 'Admin Modules', 'admin'),
(13, 10, 6, 7, 'Non-Admin Modules', 'non_admin');

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_groups_id_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_groups_id_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_groups_id_seq`
--

INSERT INTO `gacl_axo_groups_id_seq` (`id`) VALUES
(13);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_groups_map`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_groups_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_groups_map`
--

INSERT INTO `gacl_axo_groups_map` (`acl_id`, `group_id`) VALUES
(11, 11),
(13, 13),
(14, 13),
(15, 13),
(17, 12),
(18, 13),
(20, 12),
(21, 13);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_map`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_map` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_map`
--

INSERT INTO `gacl_axo_map` (`acl_id`, `section_value`, `value`) VALUES
(12, 'sys', 'acl'),
(16, 'app', 'users'),
(19, 'app', 'helpdesk'),
(22, 'app', 'helpdesk');

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_sections`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_sections` (
  `id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int(11) NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_axo_sections` (`value`),
  KEY `gacl_hidden_axo_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_sections`
--

INSERT INTO `gacl_axo_sections` (`id`, `value`, `order_value`, `name`, `hidden`) VALUES
(10, 'sys', 1, 'System', 0),
(11, 'app', 2, 'Application', 0),
(12, 'companies', 0, 'Companies Record', 0);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_sections_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_sections_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_sections_seq`
--

INSERT INTO `gacl_axo_sections_seq` (`id`) VALUES
(12);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_axo_seq`
--

CREATE TABLE IF NOT EXISTS `gacl_axo_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_axo_seq`
--

INSERT INTO `gacl_axo_seq` (`id`) VALUES
(30);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_groups_aro_map`
--

CREATE TABLE IF NOT EXISTS `gacl_groups_aro_map` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `aro_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`aro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_groups_aro_map`
--

INSERT INTO `gacl_groups_aro_map` (`group_id`, `aro_id`) VALUES
(11, 10),
(11, 11);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_groups_axo_map`
--

CREATE TABLE IF NOT EXISTS `gacl_groups_axo_map` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `axo_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`axo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_groups_axo_map`
--

INSERT INTO `gacl_groups_axo_map` (`group_id`, `axo_id`) VALUES
(11, 11),
(11, 12),
(11, 13),
(11, 14),
(11, 15),
(11, 16),
(11, 17),
(11, 18),
(11, 19),
(11, 20),
(11, 21),
(11, 22),
(11, 23),
(11, 24),
(11, 25),
(11, 26),
(11, 27),
(11, 28),
(11, 29),
(11, 30),
(12, 11),
(12, 22),
(12, 27),
(12, 28),
(13, 12),
(13, 13),
(13, 14),
(13, 15),
(13, 16),
(13, 17),
(13, 18),
(13, 19),
(13, 20),
(13, 21),
(13, 23),
(13, 24),
(13, 25),
(13, 26),
(13, 29),
(13, 30);

-- --------------------------------------------------------

--
-- Table structure for table `gacl_phpgacl`
--

CREATE TABLE IF NOT EXISTS `gacl_phpgacl` (
  `name` varchar(230) NOT NULL DEFAULT '',
  `value` varchar(230) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gacl_phpgacl`
--

INSERT INTO `gacl_phpgacl` (`name`, `value`) VALUES
('schema_version', '2.1'),
('version', '3.3.2');

-- --------------------------------------------------------

--
-- Table structure for table `helpdesk_items`
--

CREATE TABLE IF NOT EXISTS `helpdesk_items` (
  `item_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_title` varchar(64) NOT NULL DEFAULT '',
  `item_summary` text,
  `item_calltype` int(3) unsigned NOT NULL DEFAULT '0',
  `item_source` int(3) unsigned NOT NULL DEFAULT '0',
  `item_os` varchar(48) NOT NULL DEFAULT '',
  `item_application` varchar(48) NOT NULL DEFAULT '',
  `item_priority` int(3) unsigned NOT NULL DEFAULT '0',
  `item_severity` int(3) unsigned NOT NULL DEFAULT '0',
  `item_status` int(3) unsigned NOT NULL DEFAULT '0',
  `item_assigned_to` int(11) NOT NULL DEFAULT '0',
  `item_created_by` int(11) NOT NULL DEFAULT '0',
  `item_notify` int(1) NOT NULL DEFAULT '1',
  `item_requestor` varchar(48) NOT NULL DEFAULT '',
  `item_requestor_id` int(11) NOT NULL DEFAULT '0',
  `item_requestor_email` varchar(128) NOT NULL DEFAULT '',
  `item_requestor_phone` varchar(30) NOT NULL DEFAULT '',
  `item_requestor_type` tinyint(4) NOT NULL DEFAULT '0',
  `item_created` datetime DEFAULT NULL,
  `item_modified` datetime DEFAULT NULL,
  `item_parent` int(10) unsigned NOT NULL DEFAULT '0',
  `item_project_id` int(11) NOT NULL DEFAULT '0',
  `item_company_id` int(11) NOT NULL DEFAULT '0',
  `item_department_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `helpdesk_items`
--

INSERT INTO `helpdesk_items` (`item_id`, `item_title`, `item_summary`, `item_calltype`, `item_source`, `item_os`, `item_application`, `item_priority`, `item_severity`, `item_status`, `item_assigned_to`, `item_created_by`, `item_notify`, `item_requestor`, `item_requestor_id`, `item_requestor_email`, `item_requestor_phone`, `item_requestor_type`, `item_created`, `item_modified`, `item_parent`, `item_project_id`, `item_company_id`, `item_department_id`) VALUES
(17, 'test44', 'ddd', 0, 0, 'Not Applicable', 'eABC', 0, 0, 1, 0, 1, 1, '44', 0, '', '', 0, '2013-05-10 11:24:05', '0000-00-00 00:00:00', 0, 0, 3, 0),
(14, 'test 5', 'test', 0, 0, 'Not Applicable', 'eABC', 0, 0, 1, 0, 1, 1, 'Test', 0, '', '', 0, '2013-05-10 09:40:05', '0000-00-00 00:00:00', 0, 0, 3, 0),
(15, '4545', 'tsetts', 0, 0, 'Not Applicable', 'Not Applicable', 0, 0, 1, 0, 1, 1, '43343', 0, '', '', 0, '2013-05-10 11:19:46', '0000-00-00 00:00:00', 0, 0, 1, 1),
(16, '454588', '4545435', 0, 0, 'Not Applicable', 'Not Applicable', 0, 0, 1, 0, 1, 1, '4545', 0, '', '', 0, '2013-05-10 11:20:59', '0000-00-00 00:00:00', 0, 0, 1, 0),
(10, 'Tes compt', 'test', 0, 0, 'Not Applicable', 'Archer', 0, 0, 1, 0, 1, 1, 'Mike', 0, '', '', 0, '2013-05-10 09:35:37', '0000-00-00 00:00:00', 0, 0, 2, 0),
(13, 'get', 'get', 1, 0, 'Not Applicable', 'Archer', 0, 0, 1, 0, 1, 1, 'get', 0, 'get', '', 0, '2013-05-10 09:39:14', '0000-00-00 00:00:00', 0, 0, 1, 1),
(9, 'Mike  Test 2', 'test', 0, 0, 'Not Applicable', 'eABC', 0, 0, 1, 0, 1, 1, 'asdf', 0, '', '', 0, '2013-05-10 09:30:32', '0000-00-00 00:00:00', 0, 0, 1, 1),
(20, 'erwer', 'adsf', 0, 0, 'Not Applicable', 'Not Applicable', 0, 0, 1, 0, 1, 1, 'sadfasdf', 0, '', '', 0, '2013-05-10 11:26:45', '0000-00-00 00:00:00', 0, 0, 2, 0),
(23, 'test', 'test summary', 1, 2, 'Not Applicable', 'Archer', 0, 0, 1, 0, 1, 1, 'Chris', 0, '', '', 0, '2013-05-10 15:28:44', '0000-00-00 00:00:00', 0, 0, 1, 0),
(24, 'test', 'tewst', 1, 0, 'Not Applicable', 'Access unlimited', 0, 0, 1, 0, 1, 1, 'tes', 0, '', '', 0, '2013-06-12 08:58:20', '0000-00-00 00:00:00', 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `helpdesk_item_status`
--

CREATE TABLE IF NOT EXISTS `helpdesk_item_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status_item_id` int(11) NOT NULL,
  `status_code` tinyint(4) NOT NULL,
  `status_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_modified_by` int(11) NOT NULL,
  `status_comment` text,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `helpdesk_item_status`
--

INSERT INTO `helpdesk_item_status` (`status_id`, `status_item_id`, `status_code`, `status_date`, `status_modified_by`, `status_comment`) VALUES
(15, 4, 17, '2013-05-06 12:16:12', 1, ''),
(22, 1, 17, '2013-05-10 09:22:58', 1, ''),
(23, 3, 17, '2013-05-10 09:23:05', 1, ''),
(24, 6, 17, '2013-05-10 09:23:11', 1, ''),
(25, 7, 17, '2013-05-10 09:23:17', 1, ''),
(26, 2, 17, '2013-05-10 09:24:04', 1, ''),
(27, 5, 17, '2013-05-10 09:24:20', 1, ''),
(28, 8, 17, '2013-05-10 09:24:28', 1, ''),
(29, 9, 0, '2013-05-10 09:31:09', 1, 'Created'),
(30, 10, 0, '2013-05-10 09:36:10', 1, 'Created'),
(31, 10, 15, '2013-05-10 09:36:36', 1, 'changed from "Access Unlimited" to "Archer"'),
(33, 11, 17, '2013-05-10 09:38:19', 1, ''),
(35, 12, 17, '2013-05-10 09:39:06', 1, ''),
(36, 13, 0, '2013-05-10 09:39:40', 1, 'Created'),
(37, 13, 15, '2013-05-10 09:39:48', 1, 'changed from "Access Unlimited" to "Archer"'),
(38, 14, 0, '2013-05-10 09:40:30', 1, 'Created'),
(39, 14, 15, '2013-05-10 09:41:54', 1, 'changed from "Archer" to "eABC"'),
(40, 15, 0, '2013-05-10 11:20:05', 1, 'Created'),
(41, 16, 0, '2013-05-10 11:21:16', 1, 'Created'),
(42, 17, 0, '2013-05-10 11:24:25', 1, 'Created'),
(44, 18, 17, '2013-05-10 11:25:33', 1, ''),
(46, 19, 17, '2013-05-10 11:26:17', 1, ''),
(47, 20, 0, '2013-05-10 11:27:01', 1, 'Created'),
(49, 21, 17, '2013-05-10 11:28:04', 1, ''),
(51, 22, 17, '2013-05-10 11:29:17', 1, ''),
(52, 23, 0, '2013-05-10 15:29:23', 1, 'Created'),
(53, 24, 0, '2013-06-12 08:58:50', 1, 'Created');

-- --------------------------------------------------------

--
-- Table structure for table `helpdesk_item_watchers`
--

CREATE TABLE IF NOT EXISTS `helpdesk_item_watchers` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `notify` char(1) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `helpdesk_item_watchers`
--


-- --------------------------------------------------------

--
-- Stand-in structure for view `maint_letter_batch`
--
CREATE TABLE IF NOT EXISTS `maint_letter_batch` (
`Company` varchar(100)
,`Contact_First` varchar(30)
,`Contact_Last` varchar(30)
,`Company_Address1` varchar(50)
,`Company_address2` varchar(50)
,`Company_City` varchar(30)
,`Company_State` varchar(30)
,`Company_Zip` varchar(11)
,`Company_Phone` varchar(30)
,`Title` varchar(50)
,`Maintenance Date` date
);
-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
  `mod_id` int(11) NOT NULL AUTO_INCREMENT,
  `mod_name` varchar(64) NOT NULL DEFAULT '',
  `mod_directory` varchar(64) NOT NULL DEFAULT '',
  `mod_version` varchar(10) NOT NULL DEFAULT '',
  `mod_setup_class` varchar(64) NOT NULL DEFAULT '',
  `mod_type` varchar(64) NOT NULL DEFAULT '',
  `mod_active` int(1) unsigned NOT NULL DEFAULT '0',
  `mod_ui_name` varchar(20) NOT NULL DEFAULT '',
  `mod_ui_icon` varchar(64) NOT NULL DEFAULT '',
  `mod_ui_order` tinyint(3) NOT NULL DEFAULT '0',
  `mod_ui_active` int(1) unsigned NOT NULL DEFAULT '0',
  `mod_description` varchar(255) NOT NULL DEFAULT '',
  `permissions_item_table` char(100) DEFAULT NULL,
  `permissions_item_field` char(100) DEFAULT NULL,
  `permissions_item_label` char(100) DEFAULT NULL,
  PRIMARY KEY (`mod_id`,`mod_directory`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`mod_id`, `mod_name`, `mod_directory`, `mod_version`, `mod_setup_class`, `mod_type`, `mod_active`, `mod_ui_name`, `mod_ui_icon`, `mod_ui_order`, `mod_ui_active`, `mod_description`, `permissions_item_table`, `permissions_item_field`, `permissions_item_label`) VALUES
(1, 'Companies', 'companies', '1.0.0', '', 'core', 1, 'Companies', 'handshake.png', 1, 1, '', 'companies', 'company_id', 'company_name'),
(2, 'Projects', 'projects', '1.0.0', '', 'core', 1, 'Projects', 'applet3-48.png', 2, 1, '', 'projects', 'project_id', 'project_name'),
(3, 'Tasks', 'tasks', '1.0.0', '', 'core', 1, 'Tasks', 'applet-48.png', 3, 1, '', 'tasks', 'task_id', 'task_name'),
(4, 'Calendar', 'calendar', '1.0.0', '', 'core', 1, 'Calendar', 'myevo-appointments.png', 4, 1, '', 'events', 'event_id', 'event_title'),
(5, 'Files', 'files', '1.0.0', '', 'core', 1, 'Files', 'folder5.png', 5, 1, '', 'files', 'file_id', 'file_name'),
(6, 'Contacts', 'contacts', '1.0.0', '', 'core', 1, 'Contacts', 'monkeychat-48.png', 6, 1, '', 'contacts', 'contact_id', 'contact_title'),
(7, 'Forums', 'forums', '1.0.0', '', 'core', 1, 'Forums', 'support.png', 7, 1, '', 'forums', 'forum_id', 'forum_name'),
(8, 'Tickets', 'ticketsmith', '1.0.0', '', 'core', 0, 'Tickets', 'ticketsmith.gif', 8, 1, '', '', '', ''),
(9, 'User Administration', 'admin', '1.0.0', '', 'core', 1, 'User Admin', 'helix-setup-users.png', 10, 1, '', 'users', 'user_id', 'user_username'),
(10, 'System Administration', 'system', '1.0.0', '', 'core', 1, 'System Admin', '48_my_computer.png', 11, 1, '', '', '', ''),
(11, 'Departments', 'departments', '1.0.0', '', 'core', 1, 'Departments', 'users.gif', 12, 0, '', 'departments', 'dept_id', 'dept_name'),
(12, 'Help', 'help', '1.0.0', '', 'core', 1, 'Help', 'dp.gif', 13, 0, '', '', '', ''),
(13, 'Public', 'public', '1.0.0', '', 'core', 1, 'Public', 'users.gif', 14, 0, '', '', '', ''),
(14, 'HelpDesk', 'helpdesk', '0.31', 'CSetupHelpDesk', 'user', 1, 'Help Desk', 'helpdesk.png', 9, 1, 'Help Desk is a bug, feature request, complaint and suggestion tracking centre', 'companies', 'company_id', 'company_name'),
(15, 'SmartSearch', 'smartsearch', '2.0', 'SSearchNS', 'user', 1, 'SmartSearch', 'kfind.png', 14, 1, 'A module to search keywords and find the needle in the haystack', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_user` int(11) NOT NULL DEFAULT '0',
  `permission_grant_on` varchar(12) NOT NULL DEFAULT '',
  `permission_item` int(11) NOT NULL DEFAULT '0',
  `permission_value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `idx_pgrant_on` (`permission_grant_on`,`permission_item`,`permission_user`),
  KEY `idx_puser` (`permission_user`),
  KEY `idx_pvalue` (`permission_value`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_user`, `permission_grant_on`, `permission_item`, `permission_value`) VALUES
(1, 1, 'all', -1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_company` int(11) NOT NULL DEFAULT '0',
  `project_company_internal` int(11) NOT NULL DEFAULT '0',
  `project_department` int(11) NOT NULL DEFAULT '0',
  `project_name` varchar(255) DEFAULT NULL,
  `project_short_name` varchar(10) DEFAULT NULL,
  `project_owner` int(11) DEFAULT '0',
  `project_url` varchar(255) DEFAULT NULL,
  `project_demo_url` varchar(255) DEFAULT NULL,
  `project_start_date` datetime DEFAULT NULL,
  `project_end_date` datetime DEFAULT NULL,
  `project_status` int(11) DEFAULT '0',
  `project_percent_complete` tinyint(4) DEFAULT '0',
  `project_color_identifier` varchar(6) DEFAULT 'eeeeee',
  `project_description` text,
  `project_target_budget` decimal(10,2) DEFAULT '0.00',
  `project_actual_budget` decimal(10,2) DEFAULT '0.00',
  `project_creator` int(11) DEFAULT '0',
  `project_private` tinyint(3) unsigned DEFAULT '0',
  `project_departments` char(100) DEFAULT NULL,
  `project_contacts` char(100) DEFAULT NULL,
  `project_priority` tinyint(4) DEFAULT '0',
  `project_type` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`),
  KEY `idx_project_owner` (`project_owner`),
  KEY `idx_sdate` (`project_start_date`),
  KEY `idx_edate` (`project_end_date`),
  KEY `project_short_name` (`project_short_name`),
  KEY `idx_proj1` (`project_company`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_company`, `project_company_internal`, `project_department`, `project_name`, `project_short_name`, `project_owner`, `project_url`, `project_demo_url`, `project_start_date`, `project_end_date`, `project_status`, `project_percent_complete`, `project_color_identifier`, `project_description`, `project_target_budget`, `project_actual_budget`, `project_creator`, `project_private`, `project_departments`, `project_contacts`, `project_priority`, `project_type`) VALUES
(1, 1, 0, 0, 'test', 'test', 1, NULL, NULL, '2013-05-03 00:00:00', NULL, 0, 0, 'FFFFFF', NULL, '0.00', '0.00', 1, 0, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_contacts`
--

CREATE TABLE IF NOT EXISTS `project_contacts` (
  `project_id` int(10) NOT NULL,
  `contact_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_contacts`
--


-- --------------------------------------------------------

--
-- Table structure for table `project_departments`
--

CREATE TABLE IF NOT EXISTS `project_departments` (
  `project_id` int(10) NOT NULL,
  `department_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_departments`
--


-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(24) NOT NULL DEFAULT '',
  `role_description` varchar(255) NOT NULL DEFAULT '',
  `role_type` int(3) unsigned NOT NULL DEFAULT '0',
  `role_module` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(60) NOT NULL DEFAULT '',
  `session_user` int(11) NOT NULL DEFAULT '0',
  `session_data` longblob,
  `session_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `session_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`session_id`),
  KEY `session_updated` (`session_updated`),
  KEY `session_created` (`session_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `session_user`, `session_data`, `session_updated`, `session_created`) VALUES
('nm8lokrupq65nmfh1q6teanre4', 61, 0x4c414e4755414745537c613a353a7b733a353a22656e5f4155223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202841757329223b693a323b733a31333a22456e676c697368202841757329223b693a333b733a333a22656e61223b7d733a353a22656e5f4341223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202843616e29223b693a323b733a31333a22456e676c697368202843616e29223b693a333b733a333a22656e63223b7d733a353a22656e5f4742223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028474229223b693a323b733a31323a22456e676c6973682028474229223b693a333b733a333a22656e67223b7d733a353a22656e5f4e5a223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c69736820284e5a29223b693a323b733a31323a22456e676c69736820284e5a29223b693a333b733a333a22656e7a223b7d733a353a22656e5f5553223b613a353a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028555329223b693a323b733a31323a22456e676c6973682028555329223b693a333b733a333a22656e75223b693a343b733a31303a2249534f383835392d3135223b7d7d41707055497c4f3a363a22434170705549223a32343a7b733a353a227374617465223b613a31323a7b733a31333a2243616c496478436f6d70616e79223b733a313a2230223b733a31323a2243616c49647846696c746572223b733a323a226d79223b733a31333a2243616c44617956696577546162223b733a313a2231223b733a31343a225461736b44617953686f77417263223b693a303b733a31343a225461736b44617953686f774c6f77223b693a313b733a31353a225461736b44617953686f77486f6c64223b693a303b733a31343a225461736b44617953686f7744796e223b693a303b733a31343a225461736b44617953686f7750696e223b693a303b733a32303a225461736b44617953686f77456d70747944617465223b693a303b733a31323a225341564544504c4143452d31223b733a33303a226d3d6465706172746d656e747326613d7669657726646570745f69643d31223b733a31303a225341564544504c414345223b733a31303a226d3d68656c706465736b223b733a31373a22446570744964784465706172746d656e74223b693a313b7d733a373a22757365725f6964223b733a313a2232223b733a31353a22757365725f66697273745f6e616d65223b733a343a2254657374223b733a31343a22757365725f6c6173745f6e616d65223b733a343a2255736572223b733a31323a22757365725f636f6d70616e79223b733a313a2230223b733a31353a22757365725f6465706172746d656e74223b693a303b733a31303a22757365725f656d61696c223b733a31353a227465737475736572406d652e636f6d223b733a393a22757365725f74797065223b733a313a2231223b733a31303a22757365725f7072656673223b613a373a7b733a363a224c4f43414c45223b733a323a22656e223b733a373a2254414256494557223b733a313a2230223b733a31323a22534844415445464f524d4154223b733a383a2225642f256d2f2559223b733a31303a2254494d45464f524d4154223b733a383a2225493a254d202570223b733a373a2255495354594c45223b733a373a2264656661756c74223b733a31333a225441534b41535349474e4d4158223b733a333a22313030223b733a31303a2255534552464f524d4154223b733a343a2275736572223b7d733a31323a226461795f73656c6563746564223b4e3b733a31313a22757365725f6c6f63616c65223b733a323a22656e223b733a393a22757365725f6c616e67223b613a343a7b693a303b733a31313a22656e5f41552e7574662d38223b693a313b733a333a22656e61223b693a323b733a353a22656e5f4155223b693a333b733a323a22656e223b7d733a31313a22626173655f6c6f63616c65223b733a323a22656e223b733a31363a22626173655f646174655f6c6f63616c65223b4e3b733a333a226d7367223b733a303a22223b733a353a226d73674e6f223b693a303b733a31353a2264656661756c745265646972656374223b733a303a22223b733a333a22636667223b613a313a7b733a31313a226c6f63616c655f7761726e223b623a303b7d733a31333a2276657273696f6e5f6d616a6f72223b693a323b733a31333a2276657273696f6e5f6d696e6f72223b693a313b733a31333a2276657273696f6e5f7061746368223b693a373b733a31343a2276657273696f6e5f737472696e67223b733a353a22322e312e37223b733a31343a226c6173745f696e736572745f6964223b733a323a223631223b733a31303a2270726f6a6563745f6964223b693a303b7d616c6c5f746162737c613a343a7b733a383a2263616c656e646172223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a38323a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f63616c656e6461725f7461622e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d733a393a22636f6d70616e696573223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a353a2246696c6573223b733a343a2266696c65223b733a37373a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f66696c65732f636f6d70616e6965735f7461622e66696c6573223b733a363a226d6f64756c65223b733a353a2266696c6573223b7d733a343a2276696577223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39343a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f636f6d70616e6965735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d733a31313a226465706172746d656e7473223b613a313a7b733a343a2276696577223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a39303a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d693a313b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39363a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d733a383a2268656c706465736b223b613a303a7b7d7d, '2015-06-17 16:38:41', '2015-06-17 16:38:20'),
('q6c08phclgm7lgiihf4m81e9o1', 62, 0x4c414e4755414745537c613a353a7b733a353a22656e5f4155223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202841757329223b693a323b733a31333a22456e676c697368202841757329223b693a333b733a333a22656e61223b7d733a353a22656e5f4341223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202843616e29223b693a323b733a31333a22456e676c697368202843616e29223b693a333b733a333a22656e63223b7d733a353a22656e5f4742223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028474229223b693a323b733a31323a22456e676c6973682028474229223b693a333b733a333a22656e67223b7d733a353a22656e5f4e5a223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c69736820284e5a29223b693a323b733a31323a22456e676c69736820284e5a29223b693a333b733a333a22656e7a223b7d733a353a22656e5f5553223b613a353a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028555329223b693a323b733a31323a22456e676c6973682028555329223b693a333b733a333a22656e75223b693a343b733a31303a2249534f383835392d3135223b7d7d41707055497c4f3a363a22434170705549223a32343a7b733a353a227374617465223b613a31323a7b733a31333a2243616c496478436f6d70616e79223b733a313a2230223b733a31323a2243616c49647846696c746572223b733a323a226d79223b733a31333a2243616c44617956696577546162223b733a313a2231223b733a31343a225461736b44617953686f77417263223b693a303b733a31343a225461736b44617953686f774c6f77223b693a313b733a31353a225461736b44617953686f77486f6c64223b693a303b733a31343a225461736b44617953686f7744796e223b693a303b733a31343a225461736b44617953686f7750696e223b693a303b733a32303a225461736b44617953686f77456d70747944617465223b693a303b733a31323a225341564544504c4143452d31223b733a33373a226d3d636f6d70616e69657326613d7669657726636f6d70616e795f69643d34267461623d32223b733a31303a225341564544504c414345223b733a31313a226d3d636f6d70616e696573223b733a393a22436f6d705677546162223b733a313a2232223b7d733a373a22757365725f6964223b733a313a2232223b733a31353a22757365725f66697273745f6e616d65223b733a343a2254657374223b733a31343a22757365725f6c6173745f6e616d65223b733a343a2255736572223b733a31323a22757365725f636f6d70616e79223b733a313a2230223b733a31353a22757365725f6465706172746d656e74223b693a303b733a31303a22757365725f656d61696c223b733a31353a227465737475736572406d652e636f6d223b733a393a22757365725f74797065223b733a313a2231223b733a31303a22757365725f7072656673223b613a373a7b733a363a224c4f43414c45223b733a323a22656e223b733a373a2254414256494557223b733a313a2230223b733a31323a22534844415445464f524d4154223b733a383a2225642f256d2f2559223b733a31303a2254494d45464f524d4154223b733a383a2225493a254d202570223b733a373a2255495354594c45223b733a373a2264656661756c74223b733a31333a225441534b41535349474e4d4158223b733a333a22313030223b733a31303a2255534552464f524d4154223b733a343a2275736572223b7d733a31323a226461795f73656c6563746564223b4e3b733a31313a22757365725f6c6f63616c65223b733a323a22656e223b733a393a22757365725f6c616e67223b613a343a7b693a303b733a31313a22656e5f41552e7574662d38223b693a313b733a333a22656e61223b693a323b733a353a22656e5f4155223b693a333b733a323a22656e223b7d733a31313a22626173655f6c6f63616c65223b733a323a22656e223b733a31363a22626173655f646174655f6c6f63616c65223b4e3b733a333a226d7367223b733a303a22223b733a353a226d73674e6f223b693a303b733a31353a2264656661756c745265646972656374223b733a303a22223b733a333a22636667223b613a313a7b733a31313a226c6f63616c655f7761726e223b623a303b7d733a31333a2276657273696f6e5f6d616a6f72223b693a323b733a31333a2276657273696f6e5f6d696e6f72223b693a313b733a31333a2276657273696f6e5f7061746368223b693a373b733a31343a2276657273696f6e5f737472696e67223b733a353a22322e312e37223b733a31343a226c6173745f696e736572745f6964223b733a323a223632223b733a31303a2270726f6a6563745f6964223b693a303b7d616c6c5f746162737c613a343a7b733a383a2263616c656e646172223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a38323a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f63616c656e6461725f7461622e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d733a393a22636f6d70616e696573223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a353a2246696c6573223b733a343a2266696c65223b733a37373a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f66696c65732f636f6d70616e6965735f7461622e66696c6573223b733a363a226d6f64756c65223b733a353a2266696c6573223b7d733a343a2276696577223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39343a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f636f6d70616e6965735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d733a31313a226465706172746d656e7473223b613a313a7b733a343a2276696577223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a39303a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d693a313b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39363a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d733a363a227075626c6963223b613a303a7b7d7d, '2015-06-18 08:14:51', '2015-06-18 07:42:55'),
('ulrcggp9rcjngpm1283qapsi87', 60, 0x4c414e4755414745537c613a353a7b733a353a22656e5f4155223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202841757329223b693a323b733a31333a22456e676c697368202841757329223b693a333b733a333a22656e61223b7d733a353a22656e5f4341223b613a343a7b693a303b733a323a22656e223b693a313b733a31333a22456e676c697368202843616e29223b693a323b733a31333a22456e676c697368202843616e29223b693a333b733a333a22656e63223b7d733a353a22656e5f4742223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028474229223b693a323b733a31323a22456e676c6973682028474229223b693a333b733a333a22656e67223b7d733a353a22656e5f4e5a223b613a343a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c69736820284e5a29223b693a323b733a31323a22456e676c69736820284e5a29223b693a333b733a333a22656e7a223b7d733a353a22656e5f5553223b613a353a7b693a303b733a323a22656e223b693a313b733a31323a22456e676c6973682028555329223b693a323b733a31323a22456e676c6973682028555329223b693a333b733a333a22656e75223b693a343b733a31303a2249534f383835392d3135223b7d7d41707055497c4f3a363a22434170705549223a32343a7b733a353a227374617465223b613a31323a7b733a31333a2243616c496478436f6d70616e79223b733a313a2230223b733a31323a2243616c49647846696c746572223b733a323a226d79223b733a31333a2243616c44617956696577546162223b733a313a2231223b733a31343a225461736b44617953686f77417263223b693a303b733a31343a225461736b44617953686f774c6f77223b693a313b733a31353a225461736b44617953686f77486f6c64223b693a303b733a31343a225461736b44617953686f7744796e223b693a303b733a31343a225461736b44617953686f7750696e223b693a303b733a32303a225461736b44617953686f77456d70747944617465223b693a303b733a31323a225341564544504c4143452d31223b733a33313a226d3d636f6d70616e69657326613d7669657726636f6d70616e795f69643d31223b733a31303a225341564544504c414345223b733a31313a226d3d636f6d70616e696573223b733a31373a22446570744964784465706172746d656e74223b693a313b7d733a373a22757365725f6964223b733a313a2232223b733a31353a22757365725f66697273745f6e616d65223b733a343a2254657374223b733a31343a22757365725f6c6173745f6e616d65223b733a343a2255736572223b733a31323a22757365725f636f6d70616e79223b733a313a2230223b733a31353a22757365725f6465706172746d656e74223b693a303b733a31303a22757365725f656d61696c223b733a31353a227465737475736572406d652e636f6d223b733a393a22757365725f74797065223b733a313a2231223b733a31303a22757365725f7072656673223b613a373a7b733a363a224c4f43414c45223b733a323a22656e223b733a373a2254414256494557223b733a313a2230223b733a31323a22534844415445464f524d4154223b733a383a2225642f256d2f2559223b733a31303a2254494d45464f524d4154223b733a383a2225493a254d202570223b733a373a2255495354594c45223b733a373a2264656661756c74223b733a31333a225441534b41535349474e4d4158223b733a333a22313030223b733a31303a2255534552464f524d4154223b733a343a2275736572223b7d733a31323a226461795f73656c6563746564223b4e3b733a31313a22757365725f6c6f63616c65223b733a323a22656e223b733a393a22757365725f6c616e67223b613a343a7b693a303b733a31313a22656e5f41552e7574662d38223b693a313b733a333a22656e61223b693a323b733a353a22656e5f4155223b693a333b733a323a22656e223b7d733a31313a22626173655f6c6f63616c65223b733a323a22656e223b733a31363a22626173655f646174655f6c6f63616c65223b4e3b733a333a226d7367223b733a303a22223b733a353a226d73674e6f223b693a303b733a31353a2264656661756c745265646972656374223b733a303a22223b733a333a22636667223b613a313a7b733a31313a226c6f63616c655f7761726e223b623a303b7d733a31333a2276657273696f6e5f6d616a6f72223b693a323b733a31333a2276657273696f6e5f6d696e6f72223b693a313b733a31333a2276657273696f6e5f7061746368223b693a373b733a31343a2276657273696f6e5f737472696e67223b733a353a22322e312e37223b733a31343a226c6173745f696e736572745f6964223b733a323a223630223b733a31303a2270726f6a6563745f6964223b693a303b7d616c6c5f746162737c613a353a7b733a383a2263616c656e646172223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a38323a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f63616c656e6461725f7461622e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d733a393a22636f6d70616e696573223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a353a2246696c6573223b733a343a2266696c65223b733a37373a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f66696c65732f636f6d70616e6965735f7461622e66696c6573223b733a363a226d6f64756c65223b733a353a2266696c6573223b7d733a343a2276696577223b613a313a7b693a303b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39343a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f636f6d70616e6965735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d733a363a2273797374656d223b613a303a7b7d733a383a2268656c706465736b223b613a303a7b7d733a31313a226465706172746d656e7473223b613a313a7b733a343a2276696577223b613a323a7b693a303b613a333a7b733a343a226e616d65223b733a383a2250726f6a65637473223b733a343a2266696c65223b733a39303a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a65637473223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d693a313b613a333a7b733a343a226e616d65223b733a31343a2250726f6a656374732067616e7474223b733a343a2266696c65223b733a39363a22433a5c50726f6772616d2046696c65735c5a656e645c417061636865325c6874646f63735c6470746573742f6d6f64756c65732f70726f6a656374732f6465706172746d656e74735f7461622e766965772e70726f6a656374735f67616e7474223b733a363a226d6f64756c65223b733a383a2270726f6a65637473223b7d7d7d7d, '2015-06-18 10:53:20', '2015-06-17 14:01:52');

-- --------------------------------------------------------

--
-- Table structure for table `syskeys`
--

CREATE TABLE IF NOT EXISTS `syskeys` (
  `syskey_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `syskey_name` varchar(48) NOT NULL DEFAULT '',
  `syskey_label` varchar(255) NOT NULL DEFAULT '',
  `syskey_type` int(1) unsigned NOT NULL DEFAULT '0',
  `syskey_sep1` char(2) DEFAULT '\n',
  `syskey_sep2` char(2) NOT NULL DEFAULT '|',
  PRIMARY KEY (`syskey_id`),
  UNIQUE KEY `syskey_name` (`syskey_name`),
  UNIQUE KEY `idx_syskey_name` (`syskey_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `syskeys`
--

INSERT INTO `syskeys` (`syskey_id`, `syskey_name`, `syskey_label`, `syskey_type`, `syskey_sep1`, `syskey_sep2`) VALUES
(1, 'SelectList', 'Enter values for list', 0, '\n', '|'),
(2, 'CustomField', 'Serialized array in the following format:\r\n<KEY>|<SERIALIZED ARRAY>\r\n\r\nSerialized Array:\r\n[type] => text | checkbox | select | textarea | label\r\n[name] => <Field''s name>\r\n[options] => <html capture options>\r\n[selects] => <options for select and checkbox>', 0, '\n', '|'),
(3, 'ColorSelection', 'Hex color values for type=>color association.', 0, '\n', '|'),
(4, 'HelpDeskList', 'Enter values for list', 0, '\n', '|');

-- --------------------------------------------------------

--
-- Table structure for table `sysvals`
--

CREATE TABLE IF NOT EXISTS `sysvals` (
  `sysval_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sysval_key_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sysval_title` varchar(48) NOT NULL DEFAULT '',
  `sysval_value` text NOT NULL,
  PRIMARY KEY (`sysval_id`),
  UNIQUE KEY `idx_sysval_title` (`sysval_title`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `sysvals`
--

INSERT INTO `sysvals` (`sysval_id`, `sysval_key_id`, `sysval_title`, `sysval_value`) VALUES
(1, 1, 'ProjectStatus', '0|Not Defined\r\n1|Proposed\r\n2|In Planning\r\n3|In Progress\r\n4|On Hold\r\n5|Complete\r\n6|Template\r\n7|Archived'),
(2, 1, 'CompanyType', '0|Not Applicable\n1|Client\n2|Vendor\n3|Supplier\n4|Consultant\n5|Government\n6|Internal'),
(3, 1, 'TaskDurationType', '1|hours\n24|days'),
(4, 1, 'EventType', '0|General\n1|Appointment\n2|Meeting\n3|All Day Event\n4|Anniversary\n5|Reminder'),
(5, 1, 'TaskStatus', '0|Active\n-1|Inactive'),
(6, 1, 'TaskType', '0|Unknown\n1|Administrative\n2|Operative'),
(7, 1, 'ProjectType', '0|Unknown\n1|Administrative\n2|Operative'),
(8, 3, 'ProjectColors', 'Web|FFE0AE\nEngineering|AEFFB2\nHelpDesk|FFFCAE\nSystem Administration|FFAEAE'),
(9, 1, 'FileType', '0|Unknown\r\n1|Document\r\n2|Application'),
(10, 1, 'TaskPriority', '-1|low\n0|normal\n1|high'),
(11, 1, 'ProjectPriority', '-1|low\n0|normal\n1|high'),
(12, 1, 'ProjectPriorityColor', '-1|#E5F7FF\n0|\n1|#FFDCB3'),
(13, 1, 'TaskLogReference', '0|Not Defined\n1|Email\n2|Helpdesk\n3|Phone Call\n4|Fax'),
(14, 1, 'TaskLogReferenceImage', '0| 1|./images/obj/email.gif 2|./modules/helpdesk/images/helpdesk.png 3|./images/obj/phone.gif 4|./images/icons/stock_print-16.png'),
(15, 1, 'UserType', '0|Default User\r\n1|Administrator\r\n2|CEO\r\n3|Director\r\n4|Branch Manager\r\n5|Manager\r\n6|Supervisor\r\n7|Employee'),
(16, 1, 'ProjectRequiredFields', 'f.project_name.value.length|<3\r\nf.project_color_identifier.value.length|<3\r\nf.project_company.options[f.project_company.selectedIndex].value|<1'),
(17, 2, 'TicketNotify', '0|admin@example.com\n1|admin@example.com\n2|admin@example.com\r\n3|admin@example.com\r\n4|admin@example.com'),
(18, 1, 'TicketPriority', '0|Low\n1|Normal\n2|High\n3|Highest\n4|911'),
(19, 1, 'TicketStatus', '0|Open\n1|Closed\n2|Deleted'),
(20, 4, 'HelpDeskPriority', '0|Not Specified\n1|Low\n2|Medium\n3|High'),
(21, 4, 'HelpDeskSeverity', '0|Not Specified\n1|No Impact\n2|Low\n3|Medium\n4|High\n5|Critical'),
(22, 4, 'HelpDeskCallType', '0|Not Specified\n1|Bug\n2|Feature Request\n3|Complaint\n4|Suggestion'),
(23, 4, 'HelpDeskSource', '0|Not Specified\n1|E-Mail\n2|Phone\n3|Fax\n4|In Person\n5|E-Lodged\n6|WWW'),
(24, 4, 'HelpDeskOS', 'Not Applicable\nLinux\nUnix\nSolaris 8\nSolaris 9\nRed Hat 6\nRed Hat 7\nRed Hat 8\nWindows 95\nWindow 98\nWindows 2000\nWindow 2000 Server\nWindows XP'),
(25, 4, 'HelpDeskApplic', 'Not Applicable\r\neABC\r\nM3\r\nBPS\r\nMSI\r\nABC\r\nClutch\r\nArcher \r\nDaily Insight \r\nAspen\r\nAccess unlimited'),
(26, 4, 'HelpDeskStatus', '0|Unassigned\n1|Open\n2|Closed\n3|On Hold\n4|Testing'),
(27, 4, 'HelpDeskAuditTrail', '0|Created\n1|Title\n2|Requestor Name\n3|Requestor E-mail\n4|Requestor Phone\n5|Assigned To\n6|Notify by e-mail\n7|Company\n8|Project\n9|Call Type\n10|Call Source\n11|Status\n12|Priority\n13|Severity\n14|Operating System\n15|Application\n16|Summary\n17|Deleted'),
(28, 4, 'HelpDeskAppication', 'Not Applicable|eABC|M3|BPS|MSI|ABC|Clutch|Archer|Daily Insight|Aspen|Access unlimited'),
(29, 1, 'AUMaintenancePeriod', '0|Not Applicable,1|Annually,2|Monthly,3|Quarterly'),
(30, 1, 'BatchSystemType', '0|Select Type,1|Archer,2|EABC,3|ABC,4|Blockmate');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) DEFAULT NULL,
  `task_parent` int(11) DEFAULT '0',
  `task_milestone` tinyint(1) DEFAULT '0',
  `task_project` int(11) NOT NULL DEFAULT '0',
  `task_owner` int(11) NOT NULL DEFAULT '0',
  `task_start_date` datetime DEFAULT NULL,
  `task_duration` float unsigned DEFAULT '0',
  `task_duration_type` int(11) NOT NULL DEFAULT '1',
  `task_hours_worked` float unsigned DEFAULT '0',
  `task_end_date` datetime DEFAULT NULL,
  `task_status` int(11) DEFAULT '0',
  `task_priority` tinyint(4) DEFAULT '0',
  `task_percent_complete` tinyint(4) DEFAULT '0',
  `task_description` text,
  `task_target_budget` decimal(10,2) DEFAULT '0.00',
  `task_related_url` varchar(255) DEFAULT NULL,
  `task_creator` int(11) NOT NULL DEFAULT '0',
  `task_order` int(11) NOT NULL DEFAULT '0',
  `task_client_publish` tinyint(1) NOT NULL DEFAULT '0',
  `task_dynamic` tinyint(1) NOT NULL DEFAULT '0',
  `task_access` int(11) NOT NULL DEFAULT '0',
  `task_notify` int(11) NOT NULL DEFAULT '0',
  `task_departments` char(100) DEFAULT NULL,
  `task_contacts` char(100) DEFAULT NULL,
  `task_custom` longtext,
  `task_type` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `idx_task_parent` (`task_parent`),
  KEY `idx_task_project` (`task_project`),
  KEY `idx_task_owner` (`task_owner`),
  KEY `idx_task_order` (`task_order`),
  KEY `idx_task1` (`task_start_date`),
  KEY `idx_task2` (`task_end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `task_contacts`
--

CREATE TABLE IF NOT EXISTS `task_contacts` (
  `task_id` int(10) NOT NULL,
  `contact_id` int(10) NOT NULL,
  KEY `idx_task_contacts` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_contacts`
--


-- --------------------------------------------------------

--
-- Table structure for table `task_departments`
--

CREATE TABLE IF NOT EXISTS `task_departments` (
  `task_id` int(10) NOT NULL,
  `department_id` int(10) NOT NULL,
  KEY `idx_task_departments` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_departments`
--


-- --------------------------------------------------------

--
-- Table structure for table `task_dependencies`
--

CREATE TABLE IF NOT EXISTS `task_dependencies` (
  `dependencies_task_id` int(11) NOT NULL,
  `dependencies_req_task_id` int(11) NOT NULL,
  PRIMARY KEY (`dependencies_task_id`,`dependencies_req_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_dependencies`
--


-- --------------------------------------------------------

--
-- Table structure for table `task_log`
--

CREATE TABLE IF NOT EXISTS `task_log` (
  `task_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_log_task` int(11) NOT NULL DEFAULT '0',
  `task_log_help_desk_id` int(11) NOT NULL DEFAULT '0',
  `task_log_name` varchar(255) DEFAULT NULL,
  `task_log_description` text,
  `task_log_creator` int(11) NOT NULL DEFAULT '0',
  `task_log_hours` float NOT NULL DEFAULT '0',
  `task_log_date` datetime DEFAULT NULL,
  `task_log_costcode` varchar(8) NOT NULL DEFAULT '',
  `task_log_problem` tinyint(1) DEFAULT '0',
  `task_log_reference` tinyint(4) DEFAULT '0',
  `task_log_related_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`task_log_id`),
  KEY `idx_log_task` (`task_log_task`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `task_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE IF NOT EXISTS `tickets` (
  `ticket` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_company` int(10) NOT NULL DEFAULT '0',
  `ticket_project` int(10) NOT NULL DEFAULT '0',
  `author` varchar(100) NOT NULL DEFAULT '',
  `recipient` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `attachment` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(15) NOT NULL DEFAULT '',
  `assignment` int(10) unsigned NOT NULL DEFAULT '0',
  `parent` int(10) unsigned NOT NULL DEFAULT '0',
  `activity` int(10) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `cc` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `signature` text,
  PRIMARY KEY (`ticket`),
  KEY `parent` (`parent`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tickets`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_contact` int(11) NOT NULL DEFAULT '0',
  `user_username` varchar(255) NOT NULL DEFAULT '',
  `user_password` varchar(32) NOT NULL DEFAULT '',
  `user_parent` int(11) NOT NULL DEFAULT '0',
  `user_type` tinyint(3) NOT NULL DEFAULT '0',
  `user_company` int(11) DEFAULT '0',
  `user_department` int(11) DEFAULT '0',
  `user_owner` int(11) NOT NULL DEFAULT '0',
  `user_signature` text,
  PRIMARY KEY (`user_id`),
  KEY `idx_uid` (`user_username`),
  KEY `idx_pwd` (`user_password`),
  KEY `idx_user_parent` (`user_parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_contact`, `user_username`, `user_password`, `user_parent`, `user_type`, `user_company`, `user_department`, `user_owner`, `user_signature`) VALUES
(1, 1, 'admin', '76a2173be6393254e72ffa4d6df1030a', 0, 1, 0, 0, 0, ''),
(2, 2, 'testuser', '12a9928698ae76fbaaae9a2627fefff9', 0, 1, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_access_log`
--

CREATE TABLE IF NOT EXISTS `user_access_log` (
  `user_access_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `user_ip` varchar(15) NOT NULL,
  `date_time_in` datetime DEFAULT '0000-00-00 00:00:00',
  `date_time_out` datetime DEFAULT '0000-00-00 00:00:00',
  `date_time_last_action` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_access_log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=63 ;

--
-- Dumping data for table `user_access_log`
--

INSERT INTO `user_access_log` (`user_access_log_id`, `user_id`, `user_ip`, `date_time_in`, `date_time_out`, `date_time_last_action`) VALUES
(1, 1, '127.0.0.1', '2013-02-25 18:41:02', '2015-06-18 07:47:42', '2013-02-25 19:10:47'),
(2, 1, '66.27.193.10', '2013-02-25 20:16:42', '2013-03-10 19:27:13', '2013-02-25 20:20:41'),
(3, 1, '66.27.193.10', '2013-03-02 16:30:55', '2015-06-18 07:47:42', '2013-03-02 16:33:15'),
(4, 1, '192.168.242.254', '2013-03-07 10:11:12', '2013-03-11 08:49:00', '2013-03-07 17:20:09'),
(5, 1, '192.168.242.254', '2013-03-07 16:42:45', '2015-06-18 07:47:42', '2013-03-07 17:13:13'),
(6, 1, '66.27.193.10', '2013-03-08 06:09:06', '2013-03-10 08:10:49', '2013-03-08 21:49:12'),
(7, 1, '66.27.193.10', '2013-03-08 06:10:33', '2013-03-10 07:52:46', '2013-03-08 06:11:41'),
(8, 1, '66.27.193.10', '2013-03-08 06:23:01', '2015-06-18 07:47:42', '2013-03-09 07:08:14'),
(9, 1, '66.27.193.10', '2013-03-10 07:52:55', '2015-06-18 07:47:42', '2013-03-10 07:54:11'),
(10, 1, '66.27.193.10', '2013-03-10 08:11:01', '2015-06-18 07:47:42', '2013-03-10 08:20:22'),
(11, 1, '66.27.193.10', '2013-03-10 19:27:27', '2015-06-18 07:47:42', '2013-03-10 19:27:51'),
(12, 1, '192.168.242.254', '2013-03-11 08:49:05', '2015-06-18 07:47:42', '2013-03-11 08:53:06'),
(13, 1, '192.168.242.254', '2013-03-11 08:50:01', '2015-06-18 07:47:42', '2013-03-11 08:50:40'),
(14, 1, '192.168.242.254', '2013-03-11 08:51:32', '2015-06-18 07:47:42', '2013-03-11 08:51:54'),
(15, 1, '192.168.251.164', '2013-03-11 09:09:55', '2015-06-18 07:47:42', '2013-03-11 09:10:16'),
(16, 1, '192.168.242.254', '2013-04-12 14:50:31', '2013-04-12 14:54:29', '2013-04-12 14:54:11'),
(17, 1, '192.168.242.254', '2013-04-12 14:54:34', '2013-04-19 09:04:20', '2013-04-12 15:00:06'),
(18, 1, '192.168.242.254', '2013-04-15 10:57:37', '0000-00-00 00:00:00', '2013-04-15 10:57:39'),
(19, 1, '192.168.242.254', '2013-04-15 10:57:39', '2013-05-02 11:21:16', '2013-04-15 11:06:03'),
(20, 1, '66.27.193.10', '2013-04-18 20:17:44', '2015-06-18 07:47:42', '2013-04-18 20:18:03'),
(21, 1, '192.168.242.254', '2013-04-19 09:04:22', '2013-04-25 16:45:27', '2013-04-19 09:04:38'),
(22, 1, '192.168.242.254', '2013-04-25 16:45:29', '2013-05-02 12:28:50', '2013-04-25 16:45:43'),
(23, 1, '192.168.242.254', '2013-05-02 11:21:18', '2013-05-06 08:37:42', '2013-05-03 11:52:19'),
(24, 1, '192.168.242.254', '2013-05-02 12:28:51', '2013-05-06 11:36:39', '2013-05-03 12:01:50'),
(25, 1, '127.0.0.1', '2013-05-03 10:57:45', '2015-06-18 07:47:42', '2013-05-03 11:24:39'),
(26, 1, '192.168.242.254', '2013-05-06 08:39:09', '2013-05-10 08:54:47', '2013-05-06 12:19:07'),
(27, 1, '192.168.242.254', '2013-05-06 11:36:42', '2013-05-10 15:28:05', '2013-05-06 12:58:01'),
(28, 1, '192.168.242.254', '2013-05-10 08:54:48', '2015-06-18 07:47:42', '2013-05-10 11:29:18'),
(29, 1, '192.168.242.254', '2013-05-10 15:28:07', '2015-06-18 07:47:42', '2013-05-10 15:50:40'),
(30, 1, '192.168.242.254', '2013-05-13 09:09:07', '2013-05-15 16:34:59', '2013-05-13 09:10:07'),
(31, 1, '192.168.242.254', '2013-05-15 15:05:40', '2015-06-18 07:47:42', '2013-05-15 15:05:45'),
(32, 1, '192.168.242.132', '2013-05-15 16:05:39', '2015-06-18 07:47:42', '2013-05-15 16:44:54'),
(33, 1, '192.168.242.254', '2013-05-15 16:35:01', '2013-05-28 08:34:15', '2013-05-17 14:58:51'),
(34, 1, '192.168.242.254', '2013-05-15 17:00:00', '2015-06-18 07:47:42', '2013-05-15 17:10:16'),
(35, 1, '192.168.242.254', '2013-05-28 08:34:19', '2013-06-10 11:52:08', '2013-05-29 16:29:58'),
(36, 1, '192.168.242.254', '2013-05-30 08:49:45', '2013-05-30 11:18:14', '2013-05-30 11:13:53'),
(37, 1, '192.168.242.254', '2013-05-30 11:18:16', '2013-05-30 11:36:58', '2013-05-30 11:27:57'),
(38, 1, '192.168.242.254', '2013-05-30 11:36:59', '2013-06-05 10:00:03', '2013-05-30 15:36:19'),
(39, 1, '192.168.242.254', '2013-06-05 10:00:06', '2013-06-05 10:01:36', '2013-06-05 10:01:32'),
(40, 1, '192.168.242.254', '2013-06-05 10:01:38', '2013-06-06 10:53:40', '2013-06-06 10:53:37'),
(41, 1, '192.168.242.254', '2013-06-06 10:53:41', '2013-06-10 08:27:50', '2013-06-06 10:53:50'),
(42, 1, '66.27.193.10', '2013-06-06 12:44:33', '2015-06-18 07:47:42', '2013-06-06 12:44:42'),
(43, 1, '192.168.242.254', '2013-06-10 08:27:51', '2013-06-12 08:43:31', '2013-06-12 08:43:21'),
(44, 1, '192.168.242.254', '2013-06-10 11:52:09', '2015-06-18 07:47:42', '2013-06-11 09:49:20'),
(45, 1, '127.0.0.1', '2013-06-10 20:55:12', '2015-06-18 07:47:42', '2013-06-10 20:55:26'),
(46, 1, '66.27.193.10', '2013-06-10 20:56:33', '2015-06-18 07:47:42', '2013-06-10 20:56:41'),
(47, 1, '192.168.242.254', '2013-06-10 20:57:36', '2015-06-18 07:47:42', '2013-06-10 21:30:14'),
(48, 1, '192.168.242.254', '2013-06-12 08:43:32', '2013-06-12 08:43:39', '2013-06-12 08:43:32'),
(49, 1, '192.168.242.254', '2013-06-12 08:43:40', '2013-06-12 08:56:20', '2013-06-12 08:46:42'),
(50, 1, '192.168.242.254', '2013-06-12 08:56:22', '2013-06-14 09:35:19', '2013-06-12 09:25:40'),
(51, 1, '192.168.242.254', '2013-06-12 10:59:02', '2013-06-14 13:17:56', '2013-06-12 11:03:08'),
(52, 1, '192.168.242.254', '2013-06-14 09:35:21', '2013-06-17 14:34:18', '2013-06-14 13:54:08'),
(53, 1, '192.168.242.254', '2013-06-14 13:17:58', '2015-06-18 07:47:42', '2013-06-14 13:28:14'),
(54, 1, '192.168.242.254', '2013-06-17 14:34:22', '2015-06-18 07:47:42', '2013-06-17 14:36:04'),
(55, 1, '192.168.242.254', '2015-06-17 13:45:39', '2015-06-17 13:54:07', '2015-06-17 13:45:39'),
(56, 1, '192.168.242.254', '2015-06-17 13:54:11', '2015-06-17 13:58:29', '2015-06-17 13:58:26'),
(57, 1, '192.168.242.254', '2015-06-17 13:58:31', '2015-06-17 13:59:25', '2015-06-17 13:59:18'),
(58, 1, '192.168.242.254', '2015-06-17 13:59:30', '2015-06-17 14:00:49', '2015-06-17 14:00:46'),
(59, 1, '192.168.242.254', '2015-06-17 14:00:54', '2015-06-17 14:01:45', '2015-06-17 14:01:40'),
(60, 2, '192.168.242.254', '2015-06-17 14:01:52', '0000-00-00 00:00:00', '2015-06-18 10:53:20'),
(61, 2, '192.168.242.132', '2015-06-17 16:38:20', '0000-00-00 00:00:00', '2015-06-17 16:38:41'),
(62, 2, '192.168.242.254', '2015-06-18 07:42:55', '0000-00-00 00:00:00', '2015-06-18 08:14:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_events`
--

CREATE TABLE IF NOT EXISTS `user_events` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL DEFAULT '0',
  KEY `uek1` (`user_id`,`event_id`),
  KEY `uek2` (`event_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_events`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE IF NOT EXISTS `user_preferences` (
  `pref_user` varchar(12) NOT NULL DEFAULT '',
  `pref_name` varchar(72) NOT NULL DEFAULT '',
  `pref_value` varchar(32) NOT NULL DEFAULT '',
  KEY `pref_user` (`pref_user`,`pref_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_preferences`
--

INSERT INTO `user_preferences` (`pref_user`, `pref_name`, `pref_value`) VALUES
('0', 'LOCALE', 'en'),
('0', 'TABVIEW', '0'),
('0', 'SHDATEFORMAT', '%d/%m/%Y'),
('0', 'TIMEFORMAT', '%I:%M %p'),
('0', 'UISTYLE', 'default'),
('0', 'TASKASSIGNMAX', '100'),
('0', 'USERFORMAT', 'user'),
('1', 'LOCALE', 'en_AU'),
('1', 'SHDATEFORMAT', '%d/%b/%Y'),
('1', 'CURRENCYFORM', 'en_AU'),
('1', 'EVENTFILTER', 'my'),
('1', 'MAILALL', '0'),
('1', 'TASKLOGEMAIL', '0'),
('1', 'TASKLOGNOTE', '0');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_tasks`
--

CREATE TABLE IF NOT EXISTS `user_tasks` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` tinyint(4) NOT NULL DEFAULT '0',
  `task_id` int(11) NOT NULL DEFAULT '0',
  `perc_assignment` int(11) NOT NULL DEFAULT '100',
  `user_task_priority` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`user_id`,`task_id`),
  KEY `user_type` (`user_type`),
  KEY `idx_user_tasks` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_tasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_task_pin`
--

CREATE TABLE IF NOT EXISTS `user_task_pin` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `task_id` int(10) NOT NULL DEFAULT '0',
  `task_pinned` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_task_pin`
--


-- --------------------------------------------------------

--
-- Structure for view `au_batching_contracts`
--
DROP TABLE IF EXISTS `au_batching_contracts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.%.%` SQL SECURITY DEFINER VIEW `au_batching_contracts` AS select `c`.`company_name` AS `Company`,left(`d`.`dept_name`,5) AS `Batching_Serial_Number`,ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) AS `Plant_Name`,`d`.`dept_batching_maintenance` AS `End_Date`,(case when (isnull(`d`.`dept_url`) or (`d`.`dept_url` = '')) then cast('0' as decimal(14,2)) when (`d`.`dept_url` like '%,%') then cast(replace(`d`.`dept_url`,',','') as decimal(14,2)) else cast(`d`.`dept_url` as decimal(14,2)) end) AS `Amount` from ((`departments` `d` join `companies` `c`) join `contacts` `cl`) where ((`d`.`dept_company` = `c`.`company_id`) and (`c`.`company_type` = 1) and (`cl`.`contact_company` = `c`.`company_id`) and (`cl`.`contact_type` like '%Maint%')) union select `companies`.`company_name` AS `Company`,'Access Unlimited' AS `Batching_Serial_Number`,'AU' AS `AU`,str_to_date(`companies`.`application_date`,'%m/%d/%Y') AS `End_Date`,`companies`.`application_amount` AS `Amount` from `companies` where (`companies`.`company_application` like '%access unlimited%');

-- --------------------------------------------------------

--
-- Structure for view `batching_departments`
--
DROP TABLE IF EXISTS `batching_departments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.%.%` SQL SECURITY DEFINER VIEW `batching_departments` AS select `c`.`company_name` AS `Company`,left(`d`.`dept_name`,5) AS `Batching_Serial_Number`,ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) AS `Plant_Name`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 1 day) else (last_day(`d`.`dept_batching_maintenance`) + interval 1 day) end) AS `Start_Date`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 12 month) else (last_day(`d`.`dept_batching_maintenance`) + interval 12 month) end) AS `End_Date`,(case when (isnull(`d`.`dept_url`) or (`d`.`dept_url` = '')) then cast('0' as decimal(14,2)) when (`d`.`dept_url` like '%,%') then cast(replace(`d`.`dept_url`,',','') as decimal(14,2)) else cast(`d`.`dept_url` as decimal(14,2)) end) AS `Amount`,`c`.`company_address1` AS `Company_Address1`,`c`.`company_address2` AS `Company_address2`,`c`.`company_city` AS `Company_City`,`c`.`company_state` AS `Company_State`,`c`.`company_zip` AS `Company_Zip`,`c`.`company_phone1` AS `Company_Phone` from ((`departments` `d` join `companies` `c`) join `contacts` `cl`) where ((`d`.`dept_company` = `c`.`company_id`) and (`c`.`company_type` = 1) and (`d`.`dept_batching_maintenance` < '2014-7-30') and (`cl`.`contact_company` = `c`.`company_id`) and (`cl`.`contact_type` like '%Maint%')) order by `c`.`company_name`;

-- --------------------------------------------------------

--
-- Structure for view `batching_maintenance1`
--
DROP TABLE IF EXISTS `batching_maintenance1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.%.%` SQL SECURITY DEFINER VIEW `batching_maintenance1` AS select `c`.`company_name` AS `Company`,left(`d`.`dept_name`,5) AS `Batching_Serial_Number`,ltrim(right(`d`.`dept_name`,(char_length(`d`.`dept_name`) - 5))) AS `Plant_Name`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 1 day) else (last_day(`d`.`dept_batching_maintenance`) + interval 1 day) end) AS `Start_Date`,(case when isnull(`d`.`dept_batching_maintenance`) then (last_day(curdate()) + interval 12 month) else (last_day(`d`.`dept_batching_maintenance`) + interval 12 month) end) AS `End_Date`,`d`.`dept_url` AS `Amount`,`c`.`company_address1` AS `Company_Address1`,`c`.`company_address2` AS `Company_address2`,`c`.`company_city` AS `Company_City`,`c`.`company_state` AS `Company_State`,`c`.`company_zip` AS `Company_Zip`,`c`.`company_phone1` AS `Company_Phone` from (`departments` `d` join `companies` `c`) where ((`d`.`dept_company` = `c`.`company_id`) and (`c`.`company_type` = 1) and (`d`.`dept_batching_maintenance` < '2015-12-31') and (`d`.`dept_url` <> '0')) order by `c`.`company_name`;

-- --------------------------------------------------------

--
-- Structure for view `maint_letter_batch`
--
DROP TABLE IF EXISTS `maint_letter_batch`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`192.168.%.%` SQL SECURITY DEFINER VIEW `maint_letter_batch` AS select `c`.`company_name` AS `Company`,`c1`.`contact_first_name` AS `Contact_First`,`c1`.`contact_last_name` AS `Contact_Last`,`c`.`company_address1` AS `Company_Address1`,`c`.`company_address2` AS `Company_address2`,`c`.`company_city` AS `Company_City`,`c`.`company_state` AS `Company_State`,`c`.`company_zip` AS `Company_Zip`,`c`.`company_phone1` AS `Company_Phone`,`c1`.`contact_title` AS `Title`,max(`d`.`dept_batching_maintenance`) AS `Maintenance Date` from ((`contacts` `c1` join `companies` `c`) join `departments` `d`) where ((`c1`.`contact_company` = `c`.`company_id`) and (`d`.`dept_company` = `c`.`company_id`) and (`c1`.`contact_type` like '%Maint%') and (`c`.`company_type` = 1) and ((`c1`.`contact_email` = ' ') or isnull(`c1`.`contact_email`)) and (`d`.`dept_batching_maintenance` < '2013-11-01')) group by `c1`.`contact_first_name`,`c1`.`contact_last_name`,`c`.`company_address1`,`c`.`company_address2`,`c`.`company_city`,`c`.`company_state`,`c`.`company_zip`,`c`.`company_phone1`,`c1`.`contact_title` order by `c`.`company_name`;
