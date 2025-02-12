import os 
import sys
import logging
import json

class JsonFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        log = {
            "timestamp": self.formatTime(record, self.datefmt),
            "moudle": record.module, 
            "message": record.getMessage()
        }
        return json.dumps(log)
    
# logging.FileHandler("myapp.log")
# logging.basicConfig(filename="myapp.log", level=log_level)


def setup_logger():    
    log_level = os.environ.get("LOGLEVEL", "DEBUG")
    log_format = os.environ.get("LOGFORMAT", "TEXT")
    
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
    return logger