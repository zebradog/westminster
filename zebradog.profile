<?php
/**
 * @file
 * Enables modules and site configuration for a zebradog site installation.
 */
function zebradog_install_tasks() {
  $tasks = array();
  $tasks['enable_themes'] = array(
    'display_name' => t('Enabling themes'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_bootstrap',
  );
  return $tasks;
}
function enable_bootstrap() {
  theme_enable('bootstrap');
  theme_enable('zd_ui');
  variable_set('theme_default','zd_ui');
  variable_set('admin_theme','seven');
  variable_set('node_admin_theme','zd_ui');
}

