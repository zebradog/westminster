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

  // Exported menu link: management_:admin/config/content/formats/%
  $menu_links['management_:admin/config/content/formats/%'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/config/content/formats/%',
    'router_path' => 'admin/config/content/formats/%',
    'link_title' => '',
    'options' => array(
      'identifier' => 'management_:admin/config/content/formats/%',
    ),
    'module' => 'system',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 1,
    'expanded' => 0,
    'weight' => 0,
    'customized' => 0,
    'parent_identifier' => 'management_text-formats:admin/config/content/formats',
  );
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
  // Exported menu link: management_categories:admin/structure/taxonomy/categories
  $menu_links['management_categories:admin/structure/taxonomy/categories'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/structure/taxonomy/categories',
    'router_path' => 'admin/structure/taxonomy/%',
    'link_title' => 'Categories',
    'options' => array(
      'attributes' => array(
        'title' => '',
      ),
      'identifier' => 'management_categories:admin/structure/taxonomy/categories',
    ),
    'module' => 'menu',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 0,
    'expanded' => 0,
    'weight' => -49,
    'customized' => 1,
    'parent_identifier' => 'management_manage:admin/manage-content',
  );
  // Exported menu link: management_content:admin/content
  $menu_links['management_content:admin/content'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/content',
    'router_path' => 'admin/content',
    'link_title' => 'Content',
    'options' => array(
      'attributes' => array(
        'title' => 'Find and manage content.',
      ),
      'identifier' => 'management_content:admin/content',
    ),
    'module' => 'system',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 1,
    'expanded' => 0,
    'weight' => -10,
    'customized' => 0,
    'parent_identifier' => 'management_administration:admin',
  );
  // Exported menu link: management_display:admin/structure/taxonomy/displays/add
  $menu_links['management_display:admin/structure/taxonomy/displays/add'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/structure/taxonomy/displays/add',
    'router_path' => 'admin/structure/taxonomy/%/add',
    'link_title' => 'Display',
    'options' => array(
      'attributes' => array(
        'title' => '',
      ),
      'identifier' => 'management_display:admin/structure/taxonomy/displays/add',
    ),
    'module' => 'menu',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 0,
    'expanded' => 0,
    'weight' => 0,
    'customized' => 1,
    'parent_identifier' => 'management_create:node/add',
  );
  // Exported menu link: management_displays:admin/structure/taxonomy/displays
  $menu_links['management_displays:admin/structure/taxonomy/displays'] = array(
    'menu_name' => 'management',
    'link_path' => 'admin/structure/taxonomy/displays',
    'router_path' => 'admin/structure/taxonomy/%',
    'link_title' => 'Displays',
    'options' => array(
      'attributes' => array(
        'title' => '',
      ),
      'identifier' => 'management_displays:admin/structure/taxonomy/displays',
    ),
    'module' => 'menu',
    'hidden' => 0,
    'external' => 0,
    'has_children' => 0,
    'expanded' => 0,
    'weight' => 0,
    'customized' => 1,
    'parent_identifier' => 'management_manage:admin/manage-content',
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
    'router_path' => 'admin/schedule',
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
    'has_children' => 0,
    'expanded' => 0,
    'weight' => -47,
    'customized' => 1,
  );
  // Translatables
  // Included for use with string extractors like potx.
  t('Administration');
  t('Categories');
  t('Content');
  t('Display');
  t('Displays');
  t('Preview');
  t('Schedule');


  return $menu_links;
}
