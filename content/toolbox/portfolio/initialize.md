---
title: "Initialize Hugo site"
description: "Instructions for choosing and customizing a Hugo theme for your portfolio"
weight: 2
draft: false
---

Now picking a theme for your Hugo portfolio site is essential to define its
look and feel. Here’s how to choose and customize a theme:

## Choosing a Hugo Theme

1. Visit the [Hugo Themes](https://themes.gohugo.io/) website to browse available themes.
2. Look for themes that suit your style and the type of content you plan to showcase in your portfolio.
3. Once you find a theme you like, click on it to view more details and installation instructions.

Assuming that you have chosen the "Blowfish" theme for your portfolio, here are the steps to install and customize it:

## Installing the Blowfish theme and setting up Hugo

The Blowfish developers just launched a new CLI tool to help you get started with Blowfish. It will create a new Hugo project, install the theme and set up the theme configuration files for you:

1. Open your terminal and navigate to your Hugo site directory.
2. Use the following command to create a new Hugo site with the Blowfish theme:

```bash
npm i -g blowfish-tools
```

1. Then run:

```bash
blowfish-tools new portfolio
```

Use the CLI tool to customize your theme settings.

1. Navigate into your new site directory:

```bash
cd portfolio
blowfish-tools
```

1. Initialize a new Git repository:

```bash
git init
```

1. Add a remote repository (replace `<your-repo-url>` with your GitHub repository URL):

```bash
git remote add origin <your-repo-url>
```

Now your Hugo site is initialized and ready for further customization!

## Customizing the Theme

Read more in the [Blowfish documentation](https://blowfish.page/docs/) on how to customize colors, fonts, and layout to match your personal branding.
