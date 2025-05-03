# mock_server/app.py

from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/dispatch', methods=['POST'])
def receive_dispatch():
    data = request.get_json()
    if not all(key in data for key in ('incident_id', 'location', 'type', 'priority')):
        return jsonify({"status": "Error", "message": "Missing fields"}), 400
    print(f"Received dispatch: {data}")
    return jsonify({"status": "Received"}), 200

if __name__ == '__main__':
    app.run(host="127.0.0.1", port=5000, debug=True)
