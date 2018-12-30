import requests
import json

def test_orchestrator_path_query(hostname, port):
    d={
      "flows": [
        {
          "src": "10.0.1.101",
          "dst": "10.0.2.201",
          "ingress": "openflow:2:1"
        },
        {
          "src": "10.0.1.102",
          "dst": "10.0.3.202",
          "ingress": "openflow:2:2"
        }
      ]
    }
    r = requests.post("http://%s:%d/path-query" % (hostname, port), json=d)
    print(r.text)

def test_orchestrator_resource_query(hostname, port):
    raw_data = {
    "query-desc": [
        {
        "flow": {
            "flow-id": 1,
            "src-ip": "10.0.1.101",
            "dst-ip": "10.0.2.201",
            "dst-port": 2345
        },
        "ingress-point": ""
        },
        {
        "flow": {
            "flow-id": 2,
            "src-ip": "10.0.1.102",
            "dst-ip": "10.0.3.202",
            "dst-port": 4567
        },
        "ingress-point": ""
        }
    ]
    }
    r = requests.post("http://%s:%d/resource_query" % (hostname, port), json=raw_data)
    print(r.text)

def test_submit_task(hostname, port):
    raw_data = [{
        "id": 1,
        "jobs": [{
            "potential_srcs": [ { "ip": "10.0.1.101", "port": 1234 } ],
            "potential_dsts": [ { "ip": "10.0.2.201", "port": 2345 } ]
        },{
            "potential_srcs": [ { "ip": "10.0.1.102", "port": 3456 } ],
            "potential_dsts": [ { "ip": "10.0.3.202", "port": 5678 } ]
        }]}]
    r = requests.post("http://%s:%d/tasks" % (hostname, port), json=raw_data)
    print(r.text)
    return r.text

def test_calculate_bandwidth(hostname, port, pv_raw_str):
    pv = json.loads(pv_raw_str)
    anes = []
    ane_matrix = []
    for domain_name in pv.keys():
        anes.extend(pv[domain_name]["anes"])
        ane_matrix.extend(pv[domain_name]["ane-matrix"])
    r = requests.post("http://%s:%d/calculate_bandwidth" % (hostname, port), json={"anes": anes, "ane-matrix": ane_matrix})
    print(r.text)
    return r.text

def test_run_task(hostname, port, bandwidth_assign_raw_str):
    bw_assign = json.loads(bandwidth_assign_raw_str)
    r = requests.post("http://%s:%d/run_task" % (hostname, port), json=bw_assign)
    print(r.text)

if __name__ == '__main__':
    # test_orchestrator_path_query("unicorn1", 6666)
    # test_orchestrator_resource_query("unicorn1", 6666)
    pv_raw_str = test_submit_task("unicorn1", 6666)
    bw_assign_raw_str = test_calculate_bandwidth("unicorn1", 6666, pv_raw_str)
    test_run_task("unicorn1", 6666, bw_assign_raw_str)