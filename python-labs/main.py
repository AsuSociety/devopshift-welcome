from models import ServerStatusResponse, Server , read_server_list, add_new_server
from fastapi import FastAPI
app = FastAPI()

# To run this code - fastapi dev main.py

@app.get("/")
def hello_world():
    "This is the main route"
    return "Hello to see servers status, go to /servers"

# @app.get("/error")
# def error():
#     "This is the error route"
#     raise ValueError("This is a value error")


@app.get("/servers")
def get_servers():
    "This is the servers route"
    return read_server_list()


@app.get("/server")
def get_server(server_name:str)->ServerStatusResponse:
    "This is the servers route"
    servers: list[Server] = read_server_list()
    try:
        for server in servers:
            print(server.name)
            if server.name==server_name:
                return ServerStatusResponse(server_name=server_name, server_status="Server exists")
            elif server_name=="":
                raise ValueError("Invalid server name")
    except ValueError as e:
        return ServerStatusResponse(server_name=server_name, server_status=f"ERROR: {e}")
    return ServerStatusResponse(server_name=server_name, server_status="Server is NOT RECORGIZED")


@app.post("/new")
def create_server(name:str, status: bool, cpu:int , ram:int)->ServerStatusResponse:
    "This is the create user route"
    servers: list[Server] = read_server_list()
    for server in servers:
        if server.name==name:
            return ServerStatusResponse(server_name=name, server_status="Server already exists")
    
    new_server= Server(name=name, online=status, cpus=cpu, ram=ram)
    add_new_server(new_server)
    return ServerStatusResponse(server_name=name, server_status="Server added successfully")