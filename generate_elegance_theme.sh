#!/bin/bash

# Navigate to the custom themes directory
cd custom || exit

# Create the Elegance theme directory
mkdir -p elegance/{css,js,templates}

# Navigate to the Elegance theme directory
cd elegance || exit

# Create elegance.info.yml
cat > elegance.info.yml << 'EOL'
name: 'Elegance'
type: theme
description: 'A modern, minimalist theme inspired by Apple’s design philosophy.'
package: Custom
core_version_requirement: ^10 || ^11
base theme: classy
libraries:
  - elegance/global-styling
regions:
  header: Header
  navigation: Navigation
  content: Content
  sidebar: Sidebar
  footer: Footer
EOL

# Create elegance.libraries.yml
cat > elegance.libraries.yml << 'EOL'
global-styling:
  css:
    theme:
      css/style.css: {}
      https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap: { type: external }
  js:
    js/script.js: {}
EOL

# Create CSS file
cat > css/style.css << 'EOL'
:root {
  --primary-color: #333333;
  --secondary-color: #666666;
  --accent-color: #4CAF50;
  --background-color: #F7F7F7;
}

body {
  background-color: var(--background-color);
  color: var(--primary-color);
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
  line-height: 1.5;
  margin: 0;
  padding: 0;
}

a {
  color: var(--accent-color);
  text-decoration: none;
}

header, footer {
  background-color: var(--secondary-color);
  color: #fff;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}

.row {
  display: flex;
  flex-wrap: wrap;
  margin: -15px;
}

.col {
  padding: 15px;
}

.col-1 { width: 8.33%; }
.col-2 { width: 16.66%; }
.col-3 { width: 25%; }
.col-4 { width: 33.33%; }
.col-5 { width: 41.66%; }
.col-6 { width: 50%; }
.col-7 { width: 58.33%; }
.col-8 { width: 66.66%; }
.col-9 { width: 75%; }
.col-10 { width: 83.33%; }
.col-11 { width: 91.66%; }
.col-12 { width: 100%; }

h1 {
  font-size: 24px;
  margin-bottom: 20px;
}

h2 {
  font-size: 18px;
  margin-bottom: 20px;
}

h3 {
  font-size: 14px;
  margin-bottom: 15px;
}

p {
  font-size: 16px;
  margin-bottom: 15px;
}

.header, .footer {
  padding: 20px 0;
}

.navigation-menu {
  display: flex;
  list-style: none;
}

.navigation-menu li {
  margin-right: 20px;
}

.hamburger {
  display: none;
}

.hero {
  background-size: cover;
  background-position: center;
  padding: 100px 0;
  color: #fff;
  text-align: center;
}

.content-section {
  padding: 60px 0;
}

.cta-button {
  background-color: var(--accent-color);
  color: #fff;
  padding: 15px 30px;
  display: inline-block;
  transition: background-color 0.3s ease;
}

.cta-button:hover {
  background-color: #388E3C;
}

@media (max-width: 1199px) {
  .container {
    max-width: 960px;
  }
}

@media (max-width: 991px) {
  .container {
    max-width: 768px;
  }
}

@media (max-width: 767px) {
  .container {
    max-width: 480px;
  }

  .navigation-menu {
    display: none;
  }

  .hamburger {
    display: block;
  }
}

@media (max-width: 479px) {
  .container {
    max-width: 100%;
    padding: 0 10px;
  }
}
EOL

# Create JavaScript file
cat > js/script.js << 'EOL'
document.addEventListener('DOMContentLoaded', function() {
  var hamburger = document.querySelector('.hamburger');
  var navMenu = document.querySelector('.navigation-menu');
  hamburger.addEventListener('click', function() {
    navMenu.classList.toggle('active');
  });
});
EOL

# Create page.html.twig
cat > templates/page.html.twig << 'EOL'
<!DOCTYPE html>
<html lang="{{ language.getId }}">
<head>
  <head-placeholder token="{{ placeholder_token }}">
    <meta charset="utf-8">
    {{ attach_library('elegance/global-styling') }}
  </head-placeholder>
</head>
<body>
  <header class="header">
    <div class="container">
      {{ page.header }}
      <div class="hamburger">☰</div>
      <nav class="navigation-menu">
        {{ page.navigation }}
      </nav>
    </div>
  </header>
  {{ page.hero }}
  <main class="main-content">
    <div class="container">
      {{ page.content }}
    </div>
  </main>
  <footer class="footer">
    <div class="container">
      {{ page.footer }}
    </div>
  </footer>
</body>
</html>
EOL

# Create block--hero.html.twig
cat > templates/block--hero.html.twig << 'EOL'
<section class="hero" style="background-image: url('{{ content.field_background_image.0 }}');">
  <div class="container">
    {{ content }}
  </div>
</section>
EOL

# Create menu--main.html.twig
cat > templates/menu--main.html.twig << 'EOL'
{% if items %}
  <ul class="navigation-menu">
    {% for item in items %}
      <li{{ item.attributes }}>
        {{ link(item.title, item.url) }}
      </li>
    {% endfor %}
  </ul>
{% endif %}
EOL

# Create theme-settings.php
cat > theme-settings.php << 'EOL'
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
EOL

# Create elegance.settings.yml
cat > elegance.settings.yml << 'EOL'
color_scheme: '#333333'
font_family: 'Open Sans'
EOL

# Set permissions (optional but recommended)
chmod -R 755 ../elegance
