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
    'Eastern Province',
    'Upstream' => array(
      'Exploration',
      'Drilling',
    ),
    'Support',
    'Aramco History',
    'Environment',
    'Downstream' => array(
      'Refining',
      'Distribution',
    ),
    'Joint Ventures',
    'Lifestyle' => array(
      'Education',
      'Healthcare',
      'Communities',
      'Leisure',
      'Travel' => array(
        'Vacation/School Trips',
        'Repat Trips',
      ),
      'Shopping',
      'Transportation',
    ),
    'Saudi Arabia' => array(
      'Regions' => array(
        'Central Area',
      ),
      'Saudi Arabian History',
      'Geography',
      'Biology',
      'Climate',
      'Culture',
    ),
    'Recruiting',
    'Operations Areas' => array(
      'Maps',
      'International Operations',
      'Operations in Saudi Arabia' => array(
        'Udhaliyah',
        'Abqaiq',
        'Dhahran',
        'Ras Tanura',
      ),
    ),
    'Community Services' => array(
      'ASC Community Services',
      'SA Community Services',
    ),
  );
  _zebradog_terms_load_terms($categories, 'Categories');
// Displays taxonomy terms
  $displays = array(
    'Lobby',
    'Tradeshow',
  );
  _zebradog_terms_load_terms($displays, 'Displays');
// Map Categories taxonomy terms
  $map_categories = array(
    'Affiliate',
    'Bulk Plant',
    'Distribution & Shipping',
    'Gas Plant',
    'Joint/Equity Refinery',
    'Oil Processing Complex',
    'Refining & Chemicals',
    'Sales & Marketing',
    'Saudi Aramco Headquarters',
    'Saudi Aramco Refinery',
    'Seawater Treatment Plant',
    'Services',
    'Terminal',
  );
  _zebradog_terms_load_terms($map_categories, 'Map Categories');
// Secnarios taxonomy terms
  $scenarios = array(
    'Interactive Content',
    'Slideshow Scenario',
    'Video Scenario',
  );
  _zebradog_terms_load_terms($scenarios, 'Scenario Types');
}

/**
 * Custom function to load an array of terms into a specified vocabulary.
 */
function _zebradog_terms_load_terms($terms, $vocab_name){
  $vocab = taxonomy_vocabulary_machine_name_load($vocab_name);
  if ($vocab == false) {
    drupal_set_message('Error while attempting to install vocabulary ' . $vocab_name, 'error');
  } else {
    foreach($terms as $term){
      $parent_tid = 0;
      if (!is_array($term)) {
        $tid = _zebradog_save_term($term,$vocab->vid,$parent_tid);
      } else {
        foreach ($term as $subterm)
        {
          if (!is_array($subterm)) {
            $tid = _zebradog_save_term($subterm,$vocab->vid,$subparent_tid);
            if ($parent_tid == 0) $parent_tid = $tid;
          } else {
            $subparent_tid = 0;
            foreach ($subterm as $subsub)
            {
              $tid = _zebradog_save_term($subterm,$vocab->vid,$subparent_tid);
              if ($subparent_tid == 0) $subparent_tid = $tid;
            }
          }
        }
      }
    }
  }
}
function _zebradog_save_term($term,$vid,$parent_tid) {
  $data = new stdClass();
  $data->name = $term;
  $data->vid = $vid;
  $data->parent = $parent_tid;
  taxonomy_term_save($data);
  return $data->tid;
}

