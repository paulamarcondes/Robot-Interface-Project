# 🤖 Robot Framework Interface Project

This mini-project simulates interface API testing using a mock server built with Flask and test automation written in Robot Framework.

---

## 📂 Project Structure

```
robot-framework-interface-project/
├── mock_server/            
│   ├── app.py                          # Flask application code
│   └── requirements.txt                # Python dependencies for the mock server
├── robot_reports/ 
├── tests/                  
│   ├── resources/         
│   │   ├── dispatch_keywords.robot     # Keywords
│   │   └── dispatch_variables.robot    # Variables
│   ├── negative_dispatch_tests.robot   # Negative test cases
│   └── positive_dispatch_tests.robot   # Positive test cases
├── README.md
├── API_DOCUMENTATION.md
└── .gitignore
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

---

## ✨ About This Mini-Project

This mini-project is part of my QA Automation learning journey. 😄

It is built to demonstrate:

- Building and managing a mock API server.
- Creating structured and maintainable Robot Framework tests.
- Simulating real-world interface API testing scenarios.
