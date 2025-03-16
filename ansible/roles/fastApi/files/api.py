from flask import Flask, jsonify, send_from_directory
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__, static_folder='static', static_url_path='')

app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL', 'postgresql+psycopg2://cytech_usr:password@192.168.100.121/cytech')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Tablecytech(db.Model):
    __tablename__ = 'tablecytech'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

@app.route('/')
def serve_home():
    return send_from_directory(app.static_folder, 'index.html')

@app.route('/api/noms', methods=['GET'])
def get_exemples():
    try:
        exemples = Tablecytech.query.all()
        return jsonify([exemple.name for exemple in exemples])
    except Exception as e:
        return jsonify({"error": str(e)}), 500

with app.app_context():
    db.create_all()