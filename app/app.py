from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def hello_cyberark():
    return 'Hello CyberArk User'


@app.route("/health")
def health():
    return jsonify({'status': 'ok'})


if __name__ == "__main__":
    app.run(host='0.0.0.0')
