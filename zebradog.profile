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
  $tasks['enable_blocks'] = array(
    'display_name' => t('Enabling blocks'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_blocks',
  );
  $tasks['enable_terms'] = array(
    'display_name' => t('Enabling vocabulary terms'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => 'INSTALL_TASK_IF_REACHED',
    'function' => 'enable_taxonomy_terms',
  );
  return $tasks;
}
function enable_bootstrap() {
  theme_enable(array('bootstrap','zd_ui'));
  variable_set('theme_default','zd_ui');
  variable_set('admin_theme','seven');
  variable_set('node_admin_theme','zd_ui');
}
function enable_blocks() {
  $blocks = array(
    'management' => array(
      'module' => 'system',
      'delta' => 'management',
      'region' => 'navigation',
      'weight' => '-9',
      'theme' => 'zd_ui',
      'css_class' => 'management-menu',
      'title' => '<none>',
    ),
    'user-menu' => array(
      'module' => 'system',
      'delta' => 'user-menu',
      'region' => 'navigation',
      'weight' => '0',
      'theme' => 'zd_ui',
      'css_class' => 'user-menu',
      'title' => '<none>',
    ),
    'login' => array(
      'module' => 'user',
      'delta' => 'login',
      'region' => 'navigation',
      'weight' => '-6',
      'theme' => 'zd_ui',
      'css_class' => 'user-menu',
      'title' => '<none>',
    ),
  );
  foreach ($blocks as $key => $block) {
    db_update('block')
      ->fields(array (
                 'status' => 1,
                 'weight' => $block[ 'weight' ],
                 'region' => $block[ 'region' ],
                 'css_class' => $block[ 'css_class' ],
                 'title' => $block[ 'title' ],
               ))
      ->condition('module', $block[ 'module' ])
      ->condition('delta', $block[ 'delta' ])
      ->condition('theme', $block[ 'theme' ])
      ->execute();
  }
}

/**
 * Implementation of hook_install().
 */
function enable_taxonomy_terms(){
// Category taxonomy terms
  $categories = array(
    -32 => 'Eastern Province',   // 0
    -31 => 'Upstream',
    -30 => 'Support',
    -29 => 'Aramco History',
    -28 => 'Environment',
    -27 => 'Downstream',
    -26 => 'Joint Ventures',
    -25 => 'Lifestyle',
    -24 => 'Saudi Arabia',
    -23 => 'Recruiting',
    -22 => 'Operations Areas',
    -21 => 'Community Services',
  );
  _zebradog_terms_load_terms($categories, 'categories');
  $upstream = array(
    -31 => 'Exploration',      // Upstream
    -30 => 'Drilling',         // Upstream
  );
  _zebradog_terms_load_terms($categories, 'categories','Upstream');
  $downstream = array(
    -31 => 'Refining',
    -30 => 'Distribution',
  );
  _zebradog_terms_load_terms($categories, 'categories','Downstream');
  $lifestyle = array(
    -31 => 'Education',
    -30 => 'Healthcare',
    -29 => 'Communities',
    -28 => 'Leisure',
    -27 => 'Travel',
    -26 => 'Shopping',
    -25 => 'Transportation',
  );
  $lifestyle_travel = array(
    -31 => 'Vacation/School Trips',
    -30 => 'Repat Trips',
  );
  _zebradog_terms_load_terms($lifestyle, 'categories','Lifestyle');
  _zebradog_terms_load_terms($lifestyle, 'categories','Travel');



  $saudi_arabia = array(
    -31 => 'Regions',
    -30 => 'Saudi Arabian History',
    -29 => 'Geography',
    -28 => 'Biology',
    -27 => 'Climate',
    -26 => 'Culture',
  );
  $saudi_arabia_regions = array(
    -31 => 'Central Area',
  );
  _zebradog_terms_load_terms($saudi_arabia, 'categories','Saudi Arabia');
  _zebradog_terms_load_terms($saudi_arabia_regions, 'categories','Regions');
  $operations_areas = array(
    -31 => 'Maps',
    -30 => 'International Operations',
    -29 => 'Operations in Saudi Arabia',
  );
  $operations_areas_in_saudi_arabia = array(
    -31 => 'Udhaliyah',
    -30 => 'Abqaiq',
    -29 => 'Dhahran',
    -28 => 'Ras Tanura',
  );
  _zebradog_terms_load_terms($operations_areas, 'categories', 'Operation Areas');
  _zebradog_terms_load_terms($operations_areas_in_saudi_arabia, 'categories', 'Operations in Saudi Arabia');

  $community_services = array(
    -31 => 'ASC Community Services',
    -30 => 'SA Community Services',
  );
  _zebradog_terms_load_terms($community_services, 'categories', 'Community Services');

// Displays taxonomy terms
  $displays = array(
    -32 => 'Lobby',
    -31 => 'Tradeshow',
  );
  _zebradog_terms_load_terms($displays, 'displays');
// Scenarios taxonomy terms
  $scenarios = array(
    -32 => 'Interactive Content',
    -31 => 'Slideshow Scenario',
    -30 => 'Video Scenario',
  );
  _zebradog_terms_load_terms($scenarios, 'scenario_type');
}

/**
 * Custom function to load an array of terms into a specified vocabulary.
 */
function _zebradog_terms_load_terms($terms, $vocab_name, $parent = NULL){
  $vocab = taxonomy_vocabulary_machine_name_load($vocab_name);
  $parent_tid = 0;
  if (!is_null($parent)) {
    $parent_term = array_shift(taxonomy_get_term_by_name($parent, $vocab_name));
    $parent_tid  = $parent_term->tid;
  }
  foreach ($terms as $weight=>$term) {
    $data         = new stdClass();
    $data->name   = $term;
    $data->vid    = $vocab->vid;
    $data->weight = $weight;
    $data->parent = $parent_tid;
    taxonomy_term_save($data);
  }
}

