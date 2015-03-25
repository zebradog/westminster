<?php

// Provide < PHP 5.3 support for the __DIR__ constant.
if (!defined('__DIR__')) {
  define('__DIR__', dirname(__FILE__));
}
require_once __DIR__ . '/../bootstrap/includes/bootstrap.inc';
require_once __DIR__ . '/../bootstrap/includes/theme.inc';
require_once __DIR__ . '/../bootstrap/includes/pager.inc';
require_once __DIR__ . '/../bootstrap/includes/form.inc';
require_once __DIR__ . '/../bootstrap/includes/admin.inc';
require_once __DIR__ . '/../bootstrap/includes/menu.inc';

// Load module specific files in the modules directory.
$includes = file_scan_directory(__DIR__ . '/../includes/modules', '/\.inc$/');
foreach ($includes as $include) {
  if (module_exists($include->name)) {
    require_once $include->uri;
  }
}

// Auto-rebuild the theme registry during theme development.
if (theme_get_setting('bootstrap_rebuild_registry') && !defined('MAINTENANCE_MODE')) {
  // Rebuild .info data.
  system_rebuild_theme_data();
  // Rebuild theme registry.
  drupal_theme_rebuild();
}

/*currently used to hide the display since the scheduling is currently only being used for the lobby wall*/
function zebradog_ui_form_scheduled_content_node_form_alter(&$form, &$form_state, $form_id) {
    // $form['field_display']['#access'] = FALSE;
    // drupal_get_messages('status',true); //remove status messages that should not to appear on the form
}

function zebradog_ui_form_node_delete_confirm_alter(&$form, &$form_state, $form_id){
    if($form['#node']->type == "scheduled_content"){
        $form['description']['#markup'] = 'Are you sure want to delete this Scheduled Event? '.$form['description']['#markup'];
    }
}

//redirect after login
function zebradog_ui_user_login(&$edit, $account) {
    if (!isset($_POST['form_id']) || $_POST['form_id'] != 'user_pass_reset') {
        if(in_array('content editor', $account->roles)) {
            $_GET['destination'] = 'admin/manage-content';
        }
    }
}

function zebradog_ui_preprocess_html(&$vars) {
  $params = drupal_get_query_parameters();
  // Add 'embed' body class when appropriate
  if (array_key_exists('embed',$params)) $vars['classes_array'][] = 'embed';
}
