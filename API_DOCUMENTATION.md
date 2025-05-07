## 🛠️ Fire Dispatch API Documentation

This is a simple mock API for practicing test automation with Robot Framework. It supports basic CRUD operations.

---

### 🌐 Base URL

```
http://localhost:5000
```

> Make sure the Flask server is running before sending requests.

---

### 📡 Endpoints

| Method | Endpoint                  | Description                        |
|--------|---------------------------|------------------------------------|
| GET    | `/api/dispatches`         | Get a list of all dispatches       |
| GET    | `/api/dispatch/<id>`      | Get a specific dispatch by ID      |
| POST   | `/api/dispatch`           | Create a new dispatch              |
| PUT    | `/api/dispatch/<id>`      | Update an existing dispatch        |
| DELETE | `/api/dispatch/<id>`      | Delete a dispatch                  |

---

### 📥 Request Body Format (POST / PUT)

All `POST` and `PUT` requests should send data in JSON format with these fields:

```json
{
  "incident_id": 1,
  "location": "Downtown",
  "type": "Fire",
  "priority": "High"
}
```

- `incident_id` (number)
- `location` (string)
- `type` (string)
- `priority` (string)

---

### ✅ Success Response Example

```json
{
  "message": "Dispatch created",
  "dispatch_id": 1,
  "data": {
    "incident_id": 1,
    "location": "Downtown",
    "type": "Fire",
    "priority": "High"
  }
}
```

---

### ❌ Error Response Example

```json
{
  "error": "Missing required fields"
}
```

Common errors:
- 400: Missing or invalid request data
- 404: Dispatch not found

---

## ▶️ How to Run the API Locally

1. Install Flask if not already installed:

```bash
pip install flask
```

2. Navigate to the directory containing `app.py`:

```bash
cd path/to/mock_server
```

3. Start the server:

```bash
python app.py
```

4. The API will be available at `http://localhost:5000`.

