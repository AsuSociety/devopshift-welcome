from time import sleep
import httpx

# Part 1
def get_user_data():
    url = "https://jsonplaceholder.typicode.com/users/1"
    try:
        response = httpx.get(url)
        code= response.status_code
        if code >= 200 and code < 300:
            user_data = response.json()
            print("User Data:")
            print(f"Name: {user_data['name']}")
            print(f"Email: {user_data['email']}")
            print(f"Address: {user_data['address']['street']}, {user_data['address']['city']}")        
        elif code == 404:
            print("User not found.")
        elif code >= 500:
            print("Server error, please try again later.")

    except httpx.RequestError as e:
        print(f"An error occurred {e}")
    
# Part 2    
def get_metrics():
    url2 = "https://api.example.com/system/metrics"
    headers = {"Authorization": "Bearer BLABLABLA"}
    params = {"metrics": "cpu,memory"}
    chancs = 3
    delay = 2

    while chancs > 0:
        try:
            print(f"Fetching system metrics... (Attempt {chancs})")
            response = httpx.get(url2, headers=headers,params=params, timeout=5)
            try:
                response.raise_for_status()
                metrics = response.json()
                print(f"CPU: {metrics['cpu']}")
            except httpx.HTTPStatusError as e:
                print(f"HTTP error occurred: {e}")
                if response.status_code == 401:
                    print("Invalid API Key.")
                elif response.status_code == 500:
                    print("Server is currently down.")
                break
        except httpx.RequestError:
            print(f"Attempt {chancs} failed: Server is currently down")
            sleep(delay)
            print(f"Retrying in {delay} seconds...")
        finally:
            chancs -= 1

