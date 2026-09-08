# Study material for 1st sem on WEB
## How to use this repository

This repository contains study material for the 1st semester on WEB. The material is organized into different folders, each corresponding to a specific topic or week of the course. These are all placed in the `content/frontend` folder. Each folder contains markdown files with explanations, examples, and exercises related to the topic. You can navigate through the folders and files to find the material you need. The material is intended to be used as a supplement to the lectures and exercises provided in the course. It is recommended to read through the material and try out the examples and exercises to reinforce your understanding of the concepts. You can also use the material to prepare for exams.

## How to deploy this repository
This repository is based on the Hugo static site generator. To deploy this repository, you will need to have Hugo installed on your local machine. You can find instructions for installing Hugo on the official Hugo website: https://gohugo.io/getting-started/installing/. Once you have Hugo installed, you can clone this repository to your local machine and run the following command in the root directory of the repository:
```
hugo server
```
This will start a local development server and you can view the site in your web browser at http://localhost:1313. You can make changes to the markdown files and see the changes reflected in the browser in real-time. When you are ready to deploy the site, you can run the following command to generate the static files:
```
hugo
```
This will generate the static files in the `public` directory. You can then upload the contents of the `public` directory to your web server or hosting service to make the site available online.

There is also a workflow file in .github/workflows/deploy.yml that will automatically deploy the site to GitHub Pages whenever changes are pushed to the main branch. You will need to configure the workflow file with your GitHub Pages settings and secrets to enable automatic deployment.

## 