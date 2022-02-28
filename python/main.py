from os import getenv
from flask import Flask
import platform

app = Flask(__name__)


@app.get("/")
def hello():
    return {
        "message": "Hi from Python!",
        "version": platform.python_version(),
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=getenv("PORT", 5000))
