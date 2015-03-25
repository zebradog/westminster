<?php
/**
 * @file
 * zebradog_schedule.features.user_permission.inc
 */

/**
 * Implements hook_user_default_permissions().
 */
function zebradog_schedule_user_default_permissions() {
  $permissions = array();

  // Exported permission: 'administer own schedule'.
  $permissions['administer own schedule'] = array(
    'name' => 'administer own schedule',
    'roles' => array(
      'authenticated user' => 'authenticated user',
      'content editor' => 'content editor',
    ),
    'module' => 'zebradog_schedule',
  );

  return $permissions;
}
