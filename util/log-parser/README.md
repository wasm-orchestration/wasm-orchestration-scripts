# Kubernetes Log Parser

Log parser for the customized Kubernetes version (additional logging).

Installation instructions:

1. Install the `python3-virtualenv` package:

    ```bash
    apt update
    apt install python3-virtualenv
    ```

2. Create a new virtualenvironment in the `util/log-parser` folder and activate it:

    ```bash
    virtualenv -p python3 util/log-parser/venv
    source util/log-parser/venv
    ```

3. Install the required dependencies:

    ```bash
    pip install -r util/log-parser/requirements.txt
    ```

4. Start the monitoring script:

    ```bash
    python util/log-parser/main.py
    ```