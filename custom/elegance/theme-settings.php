<?php

use Drupal\Core\Form\FormStateInterface;

function elegance_form_system_theme_settings_alter(&$form, FormStateInterface $form_state) {
  $form['elegance_settings'] = [
    '#type' => 'details',
    '#title' => t('Elegance Settings'),
    '#open' => TRUE,
  ];

  $form['elegance_settings']['color_scheme'] = [
    '#type' => 'color',
    '#title' => t('Primary Color'),
    '#default_value' => theme_get_setting('color_scheme'),
  ];

  $form['elegance_settings']['font_family'] = [
    '#type' => 'select',
    '#title' => t('Font Family'),
    '#options' => [
      'Open Sans' => 'Open Sans',
      'Arial' => 'Arial',
      'Helvetica' => 'Helvetica',
    ],
    '#default_value' => theme_get_setting('font_family'),
  ];
}
