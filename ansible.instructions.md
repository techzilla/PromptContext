---
applyTo: '**/inventory/**/*.yml, **/playbooks/**/*.yml, **/roles/**/*.yml, **/tasks/**/*.yml, **/handlers/**/*.yml, **/vars/**/*.yml, **/defaults/**/*.yml'
---

# GitHub Copilot Instructions for Ansible

## Goals

## Prohibitions

## Requirements
- Use block style YAML except in the following:
  - Empty Lists/Dictionaries
  - Jinja2 expressions that would me more readable in flow style
- Only comment sections that would confuse expert readers
## Prefrences
