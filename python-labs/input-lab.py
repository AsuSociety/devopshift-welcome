
serverlist= ["server1", "server2", "server3", "server4", "server5"]
serverdict= {"server1": True, "server2": False, "server3": True, "server4": False, "server5": True}

def check_server_inlist(server):
    try:
        if server in serverlist:
            print("Server is RUNING")
        elif server=="":
            raise ValueError("Invalid server name")
        else:
            raise ValueError("Server is NOT RECORGIZED")
    except ValueError as e:
        print("There was ERROR: ", e)


def check_server_indict(x):
    try:
        if x=="":
            raise KeyError("Invalid server name")
        elif x not in serverdict:
            raise KeyError("Server is NOT RECORGIZED")
        elif serverdict[x]==True:
            print("Server is RUNING")
        elif serverdict[x]==False:
            print("Server is STOPPED")
    except KeyError as e:
        print("There was ERROR: ", e)


# while True:
#     server= input("Enter server name or '0' to exit: ")
#     if server=="0":
#         break
#     check_server_inlist(server)

while True:
    server= input("Enter server name or '0' to exit: ")
    if server=="0":
        break
    check_server_indict(server)