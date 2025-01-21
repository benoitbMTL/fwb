import time
import requests
import ssl
import socket
import warnings
from urllib.parse import urlparse
from urllib3.exceptions import InsecureRequestWarning
import sys

# Disable warnings for unverified HTTPS requests
warnings.simplefilter("ignore", InsecureRequestWarning)

def get_ssl_session_id(url):
    """Get the SSL Session ID for a given URL."""
    parsed_url = urlparse(url)
    hostname = parsed_url.hostname
    port = parsed_url.port or 443  # Default HTTPS port

    # Create an SSL context and disable certificate verification
    context = ssl.create_default_context()
    context.check_hostname = False
    context.verify_mode = ssl.CERT_NONE

    with socket.create_connection((hostname, port)) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            session_id = ssock.session.id.hex()
            return session_id

def login_to_dvwa(base_url, username, password):
    """Authenticate to the DVWA and return a session object."""
    login_url = f"{base_url}/login.php"
    session = requests.Session()

    # Perform login
    login_data = {
        "username": username,
        "password": password,
        "Login": "Login"
    }
    login_response = session.post(login_url, data=login_data, verify=False)
    
    if "PHPSESSID" not in login_response.cookies:
        raise Exception("Login failed. No PHPSESSID received.")
    
    print("Login successful!")
    return session

def simulate_requests(base_url, session, endpoint, count):
    """Simulate multiple HTTPS requests to the given endpoint."""
    target_url = f"{base_url}{endpoint}"
    for i in range(count):
        try:
            session_id = get_ssl_session_id(base_url)

            # Make the request to the target endpoint
            response = session.get(target_url, verify=False)
            phpsessid = session.cookies.get("PHPSESSID", "Not Set")

            # Print the formatted output
            print(f"Request {i + 1}:")
            print(f"  - GET {target_url}")
            print(f"  - HTTP Status Code: {response.status_code}")
            print(f"  - PHPSESSID: {phpsessid}")
            print(f"  - SSL Session ID: {session_id}\n")
        except Exception as e:
            print(f"Error during request {i + 1}: {e}")
        time.sleep(2)  # Wait 2 seconds between requests

def main():
    # Default configurations
    base_url = "https://dvwa.fortiweb.fabriclab.ca"
    endpoint = "/vulnerabilities/exec/"
    username = "admin"
    password = "password"
    default_request_count = 10

    # Parse arguments for request count
    if len(sys.argv) > 1:
        try:
            request_count = int(sys.argv[1])
        except ValueError:
            print("Invalid argument for request count. Using default value.")
            request_count = default_request_count
    else:
        request_count = default_request_count

    print(f"Starting simulation with {request_count} requests to {endpoint}...")

    # Login and simulate requests
    try:
        session = login_to_dvwa(base_url, username, password)
        simulate_requests(base_url, session, endpoint, request_count)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
