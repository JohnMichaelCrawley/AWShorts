from flask import Flask;
app = Flask(__name__)

@app.route('/')
def home():
    return "<h1>Hello from Flask application running in ECS (Fargate) pushed from CI/CD to ECR then to ECS!</h1>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)