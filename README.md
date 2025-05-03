Robot Framwork Interface Project

This mini-project simulates interface API testing using a mock server built with Flask and test automation written in Robot Framework.


📂 Project Structure

robot-framework-interface-project/
│
├── mock_server/
│   ├── app.py              # Flask mock server
│   └── requirements.txt    # Python dependencies
│
├── tests/
│   ├── resources/          # Robot test cases
│   ├── suites/             # Keywords
│   └── variables/          # (Optional) Variables
│
├── README.md               # Project documentation
└── .gitignore              # Ignore unnecessary files



🚀 How to Run
1. Install Python dependencies
Open your terminal or Git Bash and run:

pip install -r mock_server/requirements.txt



2. Start the Mock Server
Run:

python mock_server/app.py

The server will start at:
http://localhost:5000



3. Run Robot Framework tests
In VSCode new terminal, run:

robot tests/suites/



🛠️ Tools Used
VS Code
Python
Flask
Robot Framework
RequestsLibrary



✨ About This Mini-Project
This mini-project is part of my QA Automation learning journey.  :D

It is built to demonstrate:
Build and manage a mock API server.
Create structured and maintainable Robot Framework tests.
Simulate real-world interface API testing scenarios.