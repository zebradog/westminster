<?php
/**
 * @file
 * Enables modules and site configuration for a zebradog site installation.
 */
function zebradog_install_tasks() {
  $tasks = array();
  $tasks['enable_modules'] = array(
    'display_name' => t('Enabling modules'),
    'display' => FALSE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_modules',
  );
  $tasks['enable_bootstrap'] = array(
    'display_name' => t('Enabling bootstrap theme'),
    'display' => FALSE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_bootstrap',
  );
  return $tasks;
}
function enable_modules() {
  $modules = array(
    'filter',
    'oauth_common',
    'services_oauth',
  );
  foreach ($modules as $module) {
    drush_invoke('dl',$module);
    drush_invoke('en',$module);
  }
}
function enable_bootstrap() {
  theme_enable('bootstrap');
}
