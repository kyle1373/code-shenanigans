from flask import Flask, request, jsonify
from flask_cors import CORS
from cognito import token_required
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)

app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

@app.route('/public', methods=['GET'])
def public_route():
    return jsonify({'message': 'This is a public route'})

@app.route('/protected', methods=['GET'])
@token_required
def protected_route(user):
    return jsonify({'message': f'This is a protected route. Hello {user["Username"]}!'})

if __name__ == '__main__':
    app.run(debug=True)