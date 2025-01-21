import time
import requests
import ssl
import socket
import warnings
from urllib.parse import urlparse
from urllib3.exceptions import InsecureRequestWarning

# Désactiver les avertissements InsecureRequestWarning
warnings.simplefilter("ignore", InsecureRequestWarning)

def get_ssl_session_id(url):
    # Parse the URL to extract the hostname and port
    parsed_url = urlparse(url)
    hostname = parsed_url.hostname
    port = parsed_url.port or 443  # Default to HTTPS port

    # Create an SSL context and disable certificate verification
    context = ssl.create_default_context()
    context.check_hostname = False
    context.verify_mode = ssl.CERT_NONE

    # Connect to the server using SSL
    with socket.create_connection((hostname, port)) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            # Get SSL session info
            session_id = ssock.session.id.hex()
            return session_id

def simulate_https_requests(url, interval, count):
    for i in range(count):
        try:
            # Perform HTTPS connection and fetch SSL session ID
            session_id = get_ssl_session_id(url)
            
            # Make an actual HTTP request to ensure server interaction
            response = requests.get(url, verify=False)  # Disable SSL verification for testing
            
            print(f"Request {i + 1}:")
            print(f"  - SSL Session ID: {session_id}")
            print(f"  - HTTP Status Code: {response.status_code}\n")
        except Exception as e:
            print(f"Error during request {i + 1}: {e}")
        
        # Wait for the interval
        time.sleep(interval)

# Configuration
url = "https://dvwa.corp.fabriclab.ca/login.php"
interval = 2  # Seconds between requests
request_count = 50  # Total number of requests

simulate_https_requests(url, interval, request_count)
