const http = require("http");
const fs = require("fs");
const path = require("path");

const PORT = process.env.PORT || 3000;
const PUBLIC_DIR = path.join(__dirname, "public");

let todos = [
  { id: 1, text: "Build a Node.js todo app", completed: true },
  { id: 2, text: "Add a new task", completed: false }
];

function sendJson(res, statusCode, data) {
  res.writeHead(statusCode, { "Content-Type": "application/json" });
  res.end(JSON.stringify(data));
}

function serveFile(res, filePath) {
  fs.readFile(filePath, (err, content) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("Not found");
      return;
    }

    const ext = path.extname(filePath);
    const contentTypes = {
      ".html": "text/html; charset=utf-8",
      ".css": "text/css; charset=utf-8",
      ".js": "application/javascript; charset=utf-8"
    };

    res.writeHead(200, {
      "Content-Type": contentTypes[ext] || "application/octet-stream"
    });
    res.end(content);
  });
}

function collectBody(req) {
  return new Promise((resolve, reject) => {
    let body = "";

    req.on("data", chunk => {
      body += chunk.toString();
    });

    req.on("end", () => {
      if (!body) {
        resolve({});
        return;
      }

      try {
        resolve(JSON.parse(body));
      } catch (error) {
        reject(error);
      }
    });

    req.on("error", reject);
  });
}

function handleApi(req, res) {
  if (req.method === "GET" && req.url === "/api/todos") {
    sendJson(res, 200, todos);
    return true;
  }

  if (req.method === "POST" && req.url === "/api/todos") {
    collectBody(req)
      .then(({ text }) => {
        if (!text || !text.trim()) {
          sendJson(res, 400, { message: "Todo text is required." });
          return;
        }

        const todo = {
          id: Date.now(),
          text: text.trim(),
          completed: false
        };

        todos.unshift(todo);
        sendJson(res, 201, todo);
      })
      .catch(() => {
        sendJson(res, 400, { message: "Invalid JSON body." });
      });

    return true;
  }

  const toggleMatch = req.url.match(/^\/api\/todos\/(\d+)\/toggle$/);
  if (req.method === "PATCH" && toggleMatch) {
    const todoId = Number(toggleMatch[1]);
    const todo = todos.find(item => item.id === todoId);

    if (!todo) {
      sendJson(res, 404, { message: "Todo not found." });
      return true;
    }

    todo.completed = !todo.completed;
    sendJson(res, 200, todo);
    return true;
  }

  const deleteMatch = req.url.match(/^\/api\/todos\/(\d+)$/);
  if (req.method === "DELETE" && deleteMatch) {
    const todoId = Number(deleteMatch[1]);
    const originalLength = todos.length;
    todos = todos.filter(item => item.id !== todoId);

    if (todos.length === originalLength) {
      sendJson(res, 404, { message: "Todo not found." });
      return true;
    }

    sendJson(res, 200, { success: true });
    return true;
  }

  return false;
}

const server = http.createServer((req, res) => {
  if (req.url.startsWith("/api/")) {
    const handled = handleApi(req, res);
    if (!handled) {
      sendJson(res, 404, { message: "API route not found." });
    }
    return;
  }

  const requestedPath = req.url === "/" ? "/index.html" : req.url;
  const filePath = path.join(PUBLIC_DIR, requestedPath);

  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403, { "Content-Type": "text/plain" });
    res.end("Forbidden");
    return;
  }

  serveFile(res, filePath);
});

server.listen(PORT, () => {
  console.log(`Todo app running at http://localhost:${PORT}`);
});
