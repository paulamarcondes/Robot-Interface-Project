# 🤖 Robot Framework Interface Project

This mini-project simulates interface API testing using a mock server built with Flask and test automation written in Robot Framework.

---

## 📂 Project Structure

```
robot-framework-interface-project/
├── mock_server/
│   ├── app.py              # Flask mock server
│   └── requirements.txt    # Python dependencies
├── tests/
│   ├── resources/          # Robot test resources
│   ├── suites/             # Robot test suites
│   └── variables/          # (Optional) Variables
├── README.md               # Project documentation
└── .gitignore              # Ignore unnecessary files
```

---

## 🚀 How to Run

### 1. Install Python dependencies

Open your terminal and run:

```bash
pip install -r mock_server/requirements.txt
```

### 2. Start the Mock Server

Run:

```bash
python mock_server/app.py
```

The server will start at:

```
http://localhost:5000
```

### 3. Run Robot Framework tests

In a new VS Code terminal, run:

```bash
robot tests/suites/
```

---

## 🛠️ Tools Used

- **VS Code**
- **Python**
- **Flask**
- **Robot Framework**
- **RequestsLibrary**

---

## ✨ About This Mini-Project

This mini-project is part of my QA Automation learning journey. 😄

It is built to demonstrate:

- Building and managing a mock API server.
- Creating structured and maintainable Robot Framework tests.
- Simulating real-world interface API testing scenarios.
