<?php
/**
 * @file
 * Enables modules and site configuration for a zebradog site installation.
 */
function zebradog_install_tasks() {
  $tasks = array();
  $tasks['enable_bootstrap'] = array(
    'display_name' => t('Enabling bootstrap theme'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_bootstrap',
  );
  return $tasks;
}
function enable_bootstrap() {
  theme_enable('bootstrap');
  theme_enable('zebradog_ui');
}
