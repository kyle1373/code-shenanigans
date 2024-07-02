import boto3
from botocore.exceptions import ClientError
import os
from dotenv import load_dotenv
from flask import Flask, request, jsonify

load_dotenv()

COGNITO_USER_POOL_ID = os.getenv('COGNITO_USER_POOL_ID')
COGNITO_CLIENT_ID = os.getenv('COGNITO_CLIENT_ID')
COGNITO_REGION = os.getenv('COGNITO_REGION')

cognito_client = boto3.client('cognito-idp', region_name=COGNITO_REGION)

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
        auth_header = request.headers.get('Authorization')
        if auth_header is None or not auth_header.startswith('Bearer '):
            return jsonify({'message': 'Token is missing or invalid!'}), 401

        access_token = auth_header.split(' ')[1]
        user = get_cognito_user(access_token)
        if user is None:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(user, *args, **kwargs)
    return decorator
