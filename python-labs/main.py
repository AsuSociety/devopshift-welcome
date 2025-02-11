from dataclasses import dataclass
from fastapi import FastAPI
import httpx
from tools import check_server_indict
app = FastAPI()
serverdict= {"docker": True, "apache2": False, "nginx": True}


@dataclass
class ServerStatusResponse:
    server: str
    status: str | bool

@app.get("/")
def hello_world():
    "This is the main route"
    return "Hello to see servers status, go to /servers"

@app.get("/error")
def error():
    "This is the error route"
    raise ValueError("This is a value error")


@app.get("/servers")
def get_servers():
    "This is the servers route"
    return serverdict

@app.get("/server")
def get_server(server_name)->ServerStatusResponse:
    "This is the servers route"
    try:
        if server_name=="":
            raise KeyError("Invalid server name")
        elif server_name not in serverdict:
            raise KeyError("Server is NOT RECORGIZED")
        elif serverdict[server_name]==True:
            # logger.info("Server is RUNING")
            return ServerStatusResponse(server=server_name, status="RUNNING")
        elif serverdict[server_name]==False:
            # logger.info("Server is NOT RUNING")
            return ServerStatusResponse(server=server_name, status="NOT RUNNING")
    except KeyError as e:
        # logger.error(f"There was ERROR: {e} ")
        return ServerStatusResponse(server=server_name, status=f"ERROR: {e}")
    
    # check_server_indict(server_name)

@app.post("/new")
def create_server(name:str, status: bool)->ServerStatusResponse:
    "This is the create user route"
    if name in serverdict:
        return ServerStatusResponse(server=name, status="Server already exists")
    serverdict[name]= status
    return ServerStatusResponse(server=name, status=status)

