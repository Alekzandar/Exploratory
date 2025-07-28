from flask import Flask, jsonify, request
from flask_cors import CORS
import uuid

# Initialize the Flask app
app = Flask(__name__)
# Enable CORS for all routes, allowing the frontend to communicate with this API
CORS(app)

# In-memory "database"
# A real application would use a database like PostgreSQL or MongoDB.
# We use a dictionary to store items, with UUIDs as keys.
grocery_items = {
    str(uuid.uuid4()): {"name": "Milk"},
    str(uuid.uuid4()): {"name": "Bread"},
    str(uuid.uuid4()): {"name": "Cheese"},
}

@app.route('/api/items', methods=['GET'])
def get_items():
    """
    Endpoint to retrieve all grocery items.
    """
    # Convert the dictionary to a list of items, adding the id to each item.
    items_list = [{"id": id, "name": details["name"]} for id, details in grocery_items.items()]
    return jsonify(items_list)

@app.route('/api/items', methods=['POST'])
def add_item():
    """
    Endpoint to add a new item to the grocery list.
    """
    data = request.get_json()
    if not data or 'name' not in data or not data['name'].strip():
        return jsonify({"error": "Item name is required"}), 400

    item_id = str(uuid.uuid4())
    new_item = {"name": data['name'].strip()}
    grocery_items[item_id] = new_item
    
    # Return the newly created item, including its ID.
    return jsonify({"id": item_id, "name": new_item["name"]}), 201

@app.route('/api/items/<item_id>', methods=['DELETE'])
def delete_item(item_id):
    """
    Endpoint to delete a specific item by its ID.
    """
    if item_id in grocery_items:
        del grocery_items[item_id]
        # Return a success message with a 200 OK status.
        return jsonify({"message": "Item deleted successfully"}), 200
    else:
        # If the item is not found, return a 404 Not Found error.
        return jsonify({"error": "Item not found"}), 404

# This allows the file to be run directly for local development.
# Vercel will use a WSGI server and won't run this part.
if __name__ == '__main__':
    app.run(debug=True, port=5001)
