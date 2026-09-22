---
title: Routing in React
description: Exercises for Frontend Week III
weight: 1
draft: false
---

## Exercise: React and Routing

Open the React Router tutorial: [React Router Tutorial](https://reactrouter.com/start/declarative/routing) for reference.

1. Create a new project with Vite: `npx create-vite@latest` and clean up in the usual way before you continue.
2. Install `npm i react-router` see documentation here: [version 7](https://reactrouter.com/start/declarative/installation)

We are going to create a image gallery app with routing.

3. Create a navigation bar with links to:

   - Images (showing a gallery of images)
   - Add an image  (With a form to add a new image from url, title and description)
   - Find an image (With an input field to write an id number to show an image with that id)

4. Add appropriate routes with components for each link.
5. Use the `json-server` to create a fake REST API for your app. You can use a `db.json` file with this format:
```json
{
   "images": [
      {
         "id": 1,
         "title": "Image 1",
         "description": "This is the first image",
         "url": "https://via.placeholder.com/150"
      },
      {
         "id": 2,
         "title": "Image 2",
         "description": "This is the second image",
         "url": "https://via.placeholder.com/150"
      },
      {
         "id": 3,
         "title": "Image 3",
         "description": "This is the third image",
         "url": "https://via.placeholder.com/150"
      },
      {
         "id": 4,
         "title": "Image 4",
         "description": "This is the fourth image",
         "url": "https://via.placeholder.com/150"
      }
   ]
}
6. Implement a `ImageList` component to show a list of all the images.
   - Make each image a clickable link.
7. Add a `Details` component that can show details about an image when the image is clicked on in the list of images (this one should get the id of the image, that was clicked like this: `images/:id`).
8. Implement the `AddImage` component with a form that can add another image to the list.
9. Implement the `FindImage` component with a single input field to enter an image id and a button to load image data below the input field.
10. Add a `NoMatch` component and add a route to let it handle "unknown" routes.
11. Change the image links to be `NavLinks` as in [here](https://reactrouter.com/start/declarative/navigating).
