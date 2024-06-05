import requests, json, time, sys, random

patient_id = sys.argv[1]
procedure_id = sys.argv[2]


endpoint_sap = "localhost:8080/api/procedure/" + patient_id + "/sapEvent"
endpoint_hb = "localhost:8080/api/procedure/" + patient_id + "/heartbeat"
endpoint_symptom = "localhost:8080/api/procedure/" + patient_id + "/symptomEvent"
base = {
    "patientId": patient_id,
    "procedureId": procedure_id
    }

def send_data(patient_id, procedure_id, sap, exstrasystole):
    data = {
        "patientId": patient_id,
        "procedureId": procedure_id,
        "sap": sap,
        "exstrasystole": exstrasystole
    }
    
    try:
        send_request(data, endpoint_sap)
        send_request(data, endpoint_hb)
        send_request(data, endpoint_symptom)
    except Exception as e:
        print(f"An error occurred: {e}")


def send_request(data, url):
    headers = {'Content-Type': 'application/json'}
    response = requests.put(url, headers=headers, data=json.dumps(data))
    if response != 200:
        print(f"Failed to send data: {response.status_code}, {response.text}")


while True:
    sap = random.randint(50, 145)
    exstrasystole = random.choices([False, True], weights=[3, 1], k=1)[0]

    send_request(base, endpoint_hb)
    time.sleep(1)
    send_request(base, endpoint_hb)
    time.sleep(1.5)
    send_data(patient_id, procedure_id, sap, exstrasystole)
