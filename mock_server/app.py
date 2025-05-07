# mock_server/app.py

from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory "database"
dispatches = {}
next_id = 1


@app.route('/api/dispatches', methods=['GET'])
def get_all_dispatches():
    return jsonify({'total': len(dispatches), 'dispatches': dispatches}), 200


@app.route('/api/dispatch/<int:dispatch_id>', methods=['GET'])
def get_dispatch(dispatch_id):
    dispatch = dispatches.get(dispatch_id)
    if not dispatch:
        return jsonify({'error': 'Dispatch not found'}), 404
    return jsonify({'dispatch_id': dispatch_id, 'data': dispatch}), 200


@app.route('/api/dispatch', methods=['POST'])
def create_dispatch():
    global next_id

    data = request.get_json()
    required_fields = ['incident_id', 'location', 'type', 'priority']

    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400

    dispatch_id = next_id
    dispatches[dispatch_id] = data
    next_id += 1

    return jsonify({
        'message': 'Dispatch created',
        'dispatch_id': dispatch_id,
        'data': data
    }), 201


@app.route('/api/dispatch/<int:dispatch_id>', methods=['PUT'])
def update_dispatch(dispatch_id):
    if dispatch_id not in dispatches:
        return jsonify({'error': 'Dispatch not found'}), 404

    data = request.get_json()
    if not data:
        return jsonify({'error': 'No data provided'}), 400

    # Update existing dispatch with new data
    dispatches[dispatch_id].update(data)

    return jsonify({
        'message': 'Dispatch updated',
        'dispatch_id': dispatch_id,
        'data': dispatches[dispatch_id]
    }), 200


@app.route('/api/dispatch/<int:dispatch_id>', methods=['DELETE'])
def delete_dispatch(dispatch_id):
    if dispatch_id not in dispatches:
        return jsonify({'error': 'Dispatch not found'}), 404

    del dispatches[dispatch_id]
    return jsonify({'message': f'Dispatch {dispatch_id} deleted'}), 200


if __name__ == '__main__':
    app.run(debug=True)
