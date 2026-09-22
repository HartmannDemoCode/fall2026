---
title: React Forms
description: Exercises for Frontend Week III about controlled components and forms
weight: 6
draft: false
---

# React Forms and controlled components


### 1. Getting the project configured

- Create a React project with [Vite](/toolbox/react/vite)
- Cleaning up stuff

### 2. the data we will use

    [
      {
        "id": 1,
        "age": "22",
        "name": "Steve",
        "email": "steve@test.com",
        "gender": "male"
      },
      {
        "id": 2,
        "age": "19",
        "name": "Michelle",
        "email": "michelle@test.com",
        "gender": "female"
      },
      {
        "id": 3,
        "age": "30",
        "name": "Anna",
        "email": "anna@test.com",
        "gender": "female"
      },
      {
        "id": 4,
        "age": "45",
        "name": "Karl",
        "email": "karl@test.com",
        "gender": "male"
      },
      {
        "id": 5,
        "age": "15",
        "name": "Michael",
        "email": "michael@test.com",
        "gender": "male"
      }
    ]
```

### 3. Creating components

- PersonForm.jsx

```html
<form>
    <label htmlFor="id">Id</label>
    <input name="id" id="1" type="number" readOnly placeholder="id" />
    <label htmlFor="name">Name</label>
    <input name="name" id="name" type="text" placeholder="name" />
    <label htmlFor="age">Age</label>
    <input name="age" id="age" type="number" min="1" max="120" placeholder="age" />
    <label htmlFor="email">Email</label>
    <input name="email" id="email" type="email" placeholder="email" />
    <label htmlFor="gender">Gender</label>
    <select name="gender" id="gender">
        <option defaultChecked>Select Gender</option>
        <option value="male">Male</option>
        <option value="female">Female</option>
        <option value="other">Other</option>
    </select>
    <button type="submit">Submit</button>
</form>
```

- PersonList.jsx

```html
<table className="table table-striped">
    <thead>
        <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Age</th>
        <th>Email</th>
        <th>Gender</th>
        <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <tr>
        <td>1</td>
        <td>Bingo</td>
        <td>34</td>
        <td>bingo@gmail.com</td>
        <td>Malicious</td>
        <td>
            <button>Edit</button>
            <button>Delete</button>
        </td>
        </tr>
    </tbody>
    </table>
```

### 4. Setting up states

### 5. Using the person data

Create a new folder `data` and a file `persistence.js`:
and add the json data to the file and export it as a function `getPersons()` that returns the data.

### 6. Showing the persons

### 7. Inserting new persons

```react
const handleSubmit = (evt) => {
    evt.preventDefault();
    const formPerson = new FormData(evt.target);
    const person = Object.fromEntries(formPerson.entries());
    console.log(person);
    // fetch with POST
}

```

### 8. Editing persons

### 9. Deleting persons

### 10. Styling with html and css

- Make it look smashing ;-)
