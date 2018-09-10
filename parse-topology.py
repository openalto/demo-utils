import json
import sys

if __name__ == '__main__':
    filepath = sys.argv[1]
    with open(filepath) as f:
        obj = json.load(f)
        
    port_set = set()
    topology = obj['network-topology']['topology']
    for topo in topology:
        links = topo["link"]
        for link in links:
            port_set.add(link["destination"]["dest-tp"])
            port_set.add(link["source"]["source-tp"])
    port_set = [i for i in port_set if "host" not in i]
            
    print(" ".join(port_set))

