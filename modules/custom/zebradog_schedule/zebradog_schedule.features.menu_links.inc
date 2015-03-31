<?php
/**
 * @file
 * zebradog_schedule.features.menu_links.inc
 */

/**
 * Implements hook_menu_default_menu_links().
 */
function zebradog_schedule_menu_default_menu_links() {
  $menu_links = array();

  // Exported menu link: management_administration:admin
  $menu_links['management_administration:admin'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin',
    'router_path' => 'admin',
    'link_title' => 'Administration',
    'options' => array(
      'attributes' => array(
        'title' => '',
      ),
      'identifier' => 'management_administration:admin',
    ),
    'module' => 'system',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 1,
    'expanded' => 0,
    'weight' => -46,
    'customized' => 1,
  );
  // Exported menu link: management_preview:admin/display
  $menu_links['management_preview:admin/display'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/display',
    'router_path' => 'admin',
    'link_title' => 'Preview',
    'options' => array(
      'attributes' => array(
        'title' => '',
      ),
      'identifier' => 'management_preview:admin/display',
    ),
    'module' => 'menu',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 0,
    'expanded' => 0,
    'weight' => -48,
    'customized' => 1,
  );
  // Exported menu link: management_schedule:admin/schedule
  $menu_links['management_schedule:admin/schedule'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/schedule',
    'router_path' => 'admin',
    'link_title' => 'Schedule',
    'options' => array(
      'attributes' => array(
        'title' => 'Schedule',
      ),
      'identifier' => 'management_schedule:admin/schedule',
    ),
    'module' => 'system',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 1,
    'expanded' => 1,
    'weight' => -47,
    'customized' => 1,
  );
  // Translatables
  // Included for use with string extractors like potx.
  t('Administration');
  t('Lobby Schedule');
  t('Preview');
  t('Schedule');
  t('Tradeshow Schedule');


  return $menu_links;
}
