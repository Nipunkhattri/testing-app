const todoForm = document.getElementById("todo-form");
const todoInput = document.getElementById("todo-input");
const todoList = document.getElementById("todo-list");
const todoCount = document.getElementById("todo-count");

async function request(url, options) {
  const response = await fetch(url, {
    headers: { "Content-Type": "application/json" },
    ...options
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Request failed." }));
    throw new Error(error.message);
  }

  if (response.status === 204) {
    return null;
  }

  return response.json();
}

function updateCount(todos) {
  const remaining = todos.filter(todo => !todo.completed).length;
  todoCount.textContent = `${remaining} task${remaining === 1 ? "" : "s"} left`;
}

function createTodoItem(todo) {
  const item = document.createElement("li");
  item.className = `todo-item${todo.completed ? " completed" : ""}`;

  const text = document.createElement("p");
  text.className = "todo-text";
  text.textContent = todo.text;

  const actions = document.createElement("div");
  actions.className = "todo-actions";

  const toggleButton = document.createElement("button");
  toggleButton.className = "toggle-btn";
  toggleButton.textContent = todo.completed ? "Undo" : "Done";
  toggleButton.addEventListener("click", async () => {
    await request(`/api/todos/${todo.id}/toggle`, { method: "PATCH" });
    await loadTodos();
  });

  const deleteButton = document.createElement("button");
  deleteButton.className = "delete-btn";
  deleteButton.textContent = "Delete";
  deleteButton.addEventListener("click", async () => {
    await request(`/api/todos/${todo.id}`, { method: "DELETE" });
    await loadTodos();
  });

  actions.append(toggleButton, deleteButton);
  item.append(text, actions);
  return item;
}

async function loadTodos() {
  const todos = await request("/api/todos");
  todoList.innerHTML = "";

  if (!todos.length) {
    const emptyState = document.createElement("li");
    emptyState.className = "empty-state";
    emptyState.textContent = "No tasks yet. Add one to get started.";
    todoList.appendChild(emptyState);
  } else {
    todos.forEach(todo => {
      todoList.appendChild(createTodoItem(todo));
    });
  }

  updateCount(todos);
}

todoForm.addEventListener("submit", async event => {
  event.preventDefault();

  const text = todoInput.value.trim();
  if (!text) {
    return;
  }

  await request("/api/todos", {
    method: "POST",
    body: JSON.stringify({ text })
  });

  todoInput.value = "";
  await loadTodos();
});

loadTodos().catch(error => {
  todoList.innerHTML = `<li class="empty-state">${error.message}</li>`;
});
