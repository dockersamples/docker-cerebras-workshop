#!/bin/bash

# Fix MkDocs configuration issues
echo "🔧 Fixing MkDocs configuration..."

# Backup original files
cp mkdocs.yml mkdocs.yml.backup
cp requirements.txt requirements.txt.backup

echo "✅ Created backups of original files"

# Update mkdocs.yml with fixed configuration
cat > mkdocs.yml << 'EOF'
site_name: Docker Cerebras Multi-Agent Workshop
site_description: A comprehensive workshop for building multi-agent systems with Docker and Cerebras AI
site_author: Docker Workshop Team
site_url: https://yourusername.github.io/docker-cerebras-workshop

repo_name: yourusername/docker-cerebras-workshop
repo_url: https://github.com/yourusername/docker-cerebras-workshop

theme:
  name: material
  palette:
    # Palette toggle for light mode
    - scheme: default
      primary: blue
      accent: blue
      toggle:
        icon: material/brightness-7 
        name: Switch to dark mode
    # Palette toggle for dark mode
    - scheme: slate
      primary: blue
      accent: blue
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.top
    - navigation.tracking
    - search.highlight
    - search.share
    - toc.integrate
    - content.code.copy

plugins:
  - search

markdown_extensions:
  - abbr
  - admonition
  - attr_list
  - def_list
  - footnotes
  - md_in_html
  - toc:
      permalink: true
  - pymdownx.arithmatex:
      generic: true
  - pymdownx.betterem:
      smart_enable: all
  - pymdownx.caret
  - pymdownx.details
  - pymdownx.emoji:
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
      emoji_index: !!python/name:material.extensions.emoji.twemoji
  - pymdownx.highlight:
      anchor_linenums: true
  - pymdownx.inlinehilite
  - pymdownx.keys
  - pymdownx.magiclink:
      repo_url_shorthand: true
      user: squidfunk
      repo: mkdocs-material
  - pymdownx.mark
  - pymdownx.smartsymbols
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tabbed:
      alternate_style: true
  - pymdownx.tasklist:
      custom_checkbox: true
  - pymdownx.tilde

nav:
  - Home:
    - Introduction: index.md
    - Prerequisites: prerequisites.md
    - System Overview: overview.md
  - Setup:
    - Getting Started: getting-started.md
    - Environment Setup: environment-setup.md
    - Deployment: deployment.md
  - Hands-On:
    - Basic Interaction: basic-interaction.md
    - Local Agent Tasks: local-agent.md
    - Cerebras Analysis: cerebras-analysis.md
    - Agent Routing: agent-routing.md
  - Advanced:
    - Advanced Features: advanced-features.md
    - Troubleshooting: troubleshooting.md
    - Best Practices: best-practices.md
    - Next Steps: next-steps.md

extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/ajeetraina/docker-cerebras-demo
      name: Source Repository
  generator: false

copyright: Copyright &copy; 2025 Docker Workshop Team
EOF

echo "✅ Updated mkdocs.yml with fixed emoji configuration"

# Update requirements.txt with proper dependencies
cat > requirements.txt << 'EOF'
mkdocs>=1.5.0
mkdocs-material>=9.4.0
pymdown-extensions>=10.0.0
EOF

echo "✅ Updated requirements.txt with correct dependencies"

# Reinstall dependencies
if [ -d "venv" ]; then
    source venv/bin/activate || source venv/Scripts/activate
fi

pip install -r requirements.txt

echo "✅ Reinstalled dependencies"

# Test the build
mkdocs build

if [ $? -eq 0 ]; then
    echo "🎉 MkDocs build successful!"
    echo ""
    echo "You can now run:"
    echo "  mkdocs serve    # Start development server"
    echo "  mkdocs build    # Build static site"
    echo "  mkdocs gh-deploy # Deploy to GitHub Pages"
else
    echo "❌ Build failed. Please check the error messages above."
    exit 1
fi
