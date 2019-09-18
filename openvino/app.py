#!/usr/bin/python3
import subprocess
from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def classification_sample():
    return 'Classification sample'

@app.route('/image', methods=['POST'])
def do_classification():
    if request.headers['Content-Type'] == 'application/octet-stream':
        f = open('./image', 'wb')
        f.write(request.data)
        return subprocess.check_output("classification_sample_async -i ./image -m $MODEL_PATH/$MODEL_NAME.xml", shell=True)
    else:
        return "415 Unsupported Media Type ;)"

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
