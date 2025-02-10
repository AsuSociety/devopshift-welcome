from loglab import setup_logger
# import loglab

# logger= loglab.setup_logger()
logger = setup_logger()

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
    server= server.strip().lower()
    if server=="0":
        break
    check_server_indict(server)