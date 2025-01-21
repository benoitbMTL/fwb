import requests
import sys
import time
from bs4 import BeautifulSoup
import ssl
import socket
from urllib.parse import urlparse

# Disable SSL warnings
import warnings
from urllib3.exceptions import InsecureRequestWarning
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
    """Log in to the DVWA and return an authenticated session."""
    login_url = f"{base_url}/login.php"
    session = requests.Session()

    # Get the login page to retrieve the CSRF token
    response = session.get(login_url, verify=False)
    if response.status_code != 200:
        raise Exception(f"Failed to load login page. Status code: {response.status_code}")

    # Extract the CSRF token using BeautifulSoup
    soup = BeautifulSoup(response.text, "html.parser")
    csrf_token = soup.find("input", {"name": "user_token"})
    if csrf_token:
        csrf_token = csrf_token["value"]
    else:
        raise Exception("Failed to extract CSRF token from the login page.")

    # Prepare login data
    login_data = {
        "username": username,
        "password": password,
        "Login": "Login",
        "user_token": csrf_token,
    }

    # Custom headers to mimic the browser's request
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
        "Content-Type": "application/x-www-form-urlencoded",
        "Referer": login_url,
        "Origin": base_url,
    }

    # Perform the login
    login_response = session.post(login_url, data=login_data, headers=headers, verify=False)

    # Check the response content for login confirmation
    if "You have logged in as 'admin'" not in login_response.text:
        raise Exception("Login failed. The server did not confirm the login.")

    return session

def make_requests(base_url, session, endpoint, count):
    """Make multiple requests to the specified endpoint."""
    target_url = f"{base_url}{endpoint}"

    for i in range(count):
        try:
            # Get SSL Session ID
            ssl_session_id = get_ssl_session_id(base_url)

            # Perform a GET request to the target endpoint
            response = session.get(target_url, verify=False)

            # Extract specific cookies
            phpsessid = session.cookies.get("PHPSESSID", "Not Set")
            security = session.cookies.get("security", "Not Set")
            cookiesession1 = session.cookies.get("cookiesession1", "Not Set")

            # Print the formatted output
            print(f"Request {i + 1}:")
            print(f"  - GET {target_url}")
            print(f"  - HTTP Status Code: {response.status_code}")
            print(f"  - Cookies: PHPSESSID={phpsessid}; security={security}; cookiesession1={cookiesession1}")
            print(f"  - SSL Session ID: {ssl_session_id}\n")
        except Exception as e:
            print(f"Error during request {i + 1}: {e}")
        time.sleep(2)  # Wait 2 seconds between requests

def main():
    # Base configuration
    base_url = "https://dvwa.corp.fabriclab.ca"
    endpoint = "/vulnerabilities/exec/"
    username = "admin"
    password = "password"
    default_request_count = 10

    # Parse command-line arguments for request count
    if len(sys.argv) > 1:
        try:
            request_count = int(sys.argv[1])
        except ValueError:
            request_count = default_request_count
    else:
        request_count = default_request_count

    # Login and perform requests
    try:
        session = login_to_dvwa(base_url, username, password)
        make_requests(base_url, session, endpoint, request_count)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
