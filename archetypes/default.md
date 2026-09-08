---
# This archetype is used by Hugo when creating a new page.
# Hugo reads this file and copies its front matter into a new markdown file.
# Example: "hugo new content/backend/new-topic.md" will create a file
# using the defaults defined here.
# You can change the defaults here without affecting the rest of the site.
date: {{ .Date }}
draft: true
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
---
