from flask import Flask, request, jsonify
import boto3
from botocore.exceptions import ClientError
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# AWS Cognito configuration
USER_POOL_ID = 'your_user_pool_id'
APP_CLIENT_ID = 'your_app_client_id'
REGION = 'your_region'

# Initialize Cognito client
cognito_client = boto3.client('cognito-idp', region_name=REGION)

def get_cognito_user(access_token):
    try:
        response = cognito_client.get_user(
            AccessToken=access_token
        )
        return response
    except ClientError as e:
        print(e)
        return None

def token_required(f):
    def decorator(*args, **kwargs):
        access_token = request.headers.get('Authorization')
        if access_token is None:
            return jsonify({'message': 'Token is missing!'}), 401

        user = get_cognito_user(access_token)
        if user is None:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(user, *args, **kwargs)
    return decorator

@app.route('/public', methods=['GET'])
def public_route():
    return jsonify({'message': 'This is a public route'})

@app.route('/protected', methods=['GET'])
@token_required
def protected_route(user):
    return jsonify({'message': f'This is a protected route. Hello {user["Username"]}!'})

if __name__ == '__main__':
    app.run(debug=True)