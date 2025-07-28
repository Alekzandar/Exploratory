from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
import uuid, os

# Initialize the Flask app
app = Flask(__name__)


# Override instance path to a writable directory on Vercel
app.instance_path = '/tmp/instance'
os.makedirs(app.instance_path, exist_ok=True)

# Enable CORS for all routes, allowing the frontend to communicate with this API
CORS(app)

# RETIRED:
# In-memory "database"
# A real application would use a database like PostgreSQL or MongoDB.
# We use a dictionary to store items, with UUIDs as keys.
# grocery_items = {
    #str(uuid.uuid4()): {"name": "Milk"},
    #str(uuid.uuid4()): {"name": "Bread"},
    #str(uuid.uuid4()): {"name": "Cheese"},
    #}

db_url = os.environ.get('DATABASE_URL')
if not db_url:
    raise RuntimeError("DATABASE_URL environment variable is not set")

app.config['SQLALCHEMY_DATABASE_URI'] = db_url.replace("postgres://", "postgresql://")
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
# Initialize the DB
db = SQLAlchemy(app)

# Define GroceryItem model
class GroceryItem(db.Model):
    id = db.Column(db.String(36), primary_key=True) # UUID-style string
    name = db.Column(db.String(100), nullable=False)


@app.route('/api/items', methods=['GET'])
def get_items():
    items = GroceryItem.query.all()
    return jsonify([{"id": item.id, "name": item.name} for item in items])

@app.route("/api/items", methods=["POST"])
def add_item():
    data = request.get_json()
    new_item = GroceryItem(
        id=str(uuid.uuid4()),  # ✅ Generate valid UUID here
        name=data["name"]
    )
    db.session.add(new_item)
    db.session.commit()
    return jsonify({"message": "Item added"}), 201

@app.route('/api/items/<item_id>', methods=['DELETE'])
def delete_item(item_id):
    item = GroceryItem.query.get(item_id)
    if not item:
        return jsonify({"error": "Item not found"}), 404

    db.session.delete(item)
    db.session.commit()
    return jsonify({"message": "Item deleted successfully"}), 200

@app.route('/env')
def show_env():
    return jsonify({"DATABASE_URL": os.environ.get('DATABASE_URL') or "NOT SET"})

# This allows the file to be run directly for local development.
# Vercel will use a WSGI server and won't run this part.
if __name__ == '__main__':
    app.run(debug=True, port=5001)
