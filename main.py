import platform
import requests

print("-- Python -------------------------------------")
print("Python version:", platform.python_version())
print("requests version:", requests.__version__)
print("--- HTTP test ---------------------------------")
print("https://httpbin.org/get", requests.get("https://httpbin.org/get", params={"hello": "world"}).status_code)
