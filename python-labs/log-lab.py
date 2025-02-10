import os 
import sys
import logging
import json

class JsonFormatter(logging.Formatter):
    def format(self, record):
        log = {
            "timestamp": self.formatTime(record, self.datefmt),
            "moudle": record.module, 
            "message": record.getMessage()
        }
        return json.dumps(log)
    
    
log_level = os.environ.get("LOGLEVEL", "DEBUG")
log_format = os.environ.get("LOGFORMAT", "TEXT")

# logging.FileHandler("myapp.log")
# logging.basicConfig(filename="myapp.log", level=log_level)

logger = logging.getLogger("myapp")
logger.setLevel(log_level)

file_handler = logging.FileHandler("myapp.log")
std_handler = logging.StreamHandler(sys.stdout)

if log_format == "JSON":
    std_handler.setFormatter(JsonFormatter())
    file_handler.setFormatter(JsonFormatter())
else:
    std_handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s - %(message)s"))
    file_handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s - %(message)s"))
logger.addHandler(std_handler)
logger.addHandler(file_handler)




serverdict= {"server1": True, "server2": False, "server3": True, "server4": False, "server5": True}
def check_server_indict(x):
    try:
        if x=="":
            raise KeyError("Invalid server name")
        elif x not in serverdict:
            raise KeyError("Server is NOT RECORGIZED")
        elif serverdict[x]==True:
            logger.info("Server is RUNING")
        elif serverdict[x]==False:
            logger.info("Server is NOT RUNING")
    except KeyError as e:
        logger.error(f"There was ERROR: {e} ")


while True:
    server= input("Enter server name or '0' to exit: ")
    if server=="0":
        break
    check_server_indict(server)