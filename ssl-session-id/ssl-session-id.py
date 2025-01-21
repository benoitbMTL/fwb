import requests
import sys
import time
from bs4 import BeautifulSoup

# Disable SSL warnings
import warnings
from urllib3.exceptions import InsecureRequestWarning
warnings.simplefilter("ignore", InsecureRequestWarning)

def login_to_dvwa(base_url, username, password):
    """Log in to the DVWA and return an authenticated session."""
    print("[DEBUG] Attempting to log in to the DVWA...")

    login_url = f"{base_url}/login.php"
    session = requests.Session()

    # Get the login page to retrieve the CSRF token
    print(f"[DEBUG] Sending GET request to {login_url} to retrieve CSRF token...")
    response = session.get(login_url, verify=False)
    print(f"[DEBUG] Response status code: {response.status_code}")

    if response.status_code != 200:
        raise Exception(f"Failed to load login page. Status code: {response.status_code}")

    # Extract the CSRF token using BeautifulSoup
    print("[DEBUG] Parsing CSRF token from the login page...")
    soup = BeautifulSoup(response.text, "html.parser")
    csrf_token = soup.find("input", {"name": "user_token"})
    if csrf_token:
        csrf_token = csrf_token["value"]
        print(f"[DEBUG] CSRF token found: {csrf_token}")
    else:
        raise Exception("Failed to extract CSRF token from the login page.")

    # Prepare login data
    login_data = {
        "username": username,
        "password": password,
        "Login": "Login",
        "user_token": csrf_token,
    }
    print(f"[DEBUG] Login data prepared: {login_data}")

    # Custom headers to mimic the browser's request
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
        "Content-Type": "application/x-www-form-urlencoded",
        "Referer": login_url,
        "Origin": base_url,
    }
    print(f"[DEBUG] Custom headers: {headers}")

    # Perform the login
    print("[DEBUG] Sending POST request for login...")
    login_response = session.post(login_url, data=login_data, headers=headers, verify=False)
    print(f"[DEBUG] Login POST response status code: {login_response.status_code}")
    print(f"[DEBUG] Login POST response cookies: {login_response.cookies}")

    if "PHPSESSID" not in login_response.cookies:
        print("[DEBUG] Login failed. Server response:")
        print(login_response.text)
        raise Exception("Login failed. No PHPSESSID received.")

    print("[DEBUG] Login successful!")
    return session

def make_requests(base_url, session, endpoint, count):
    """Make multiple requests to the specified endpoint."""
    print(f"[DEBUG] Starting requests to {endpoint}...")
    target_url = f"{base_url}{endpoint}"

    for i in range(count):
        try:
            print(f"[DEBUG] Sending GET request {i + 1} to {target_url}...")
            response = session.get(target_url, verify=False)
            phpsessid = session.cookies.get("PHPSESSID", "Not Set")

            print(f"Request {i + 1}:")
            print(f"  - GET {target_url}")
            print(f"  - HTTP Status Code: {response.status_code}")
            print(f"  - PHPSESSID: {phpsessid}")
        except Exception as e:
            print(f"[DEBUG] Error during request {i + 1}: {e}")
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
            print("[DEBUG] Invalid argument for request count. Using default value.")
            request_count = default_request_count
    else:
        request_count = default_request_count

    print(f"[DEBUG] Starting simulation with {request_count} requests to {endpoint}...")

    # Login and perform requests
    try:
        session = login_to_dvwa(base_url, username, password)
        make_requests(base_url, session, endpoint, request_count)
    except Exception as e:
        print(f"[DEBUG] An error occurred: {e}")

if __name__ == "__main__":
    main()
