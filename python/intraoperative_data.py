import requests, json, time, sys, random

patient_id = sys.argv[1]
procedure_id = sys.argv[2]
ip = sys.argv[3]

endpoint_sap = "http://" + ip + ":8080/api/procedure/" + patient_id + "/sapEvent"
endpoint_hb = "http://" + ip + ":8080/api/procedure/" + patient_id + "/heartBeat"
endpoint_symptom = "http://" + ip + ":8080/api/procedure/" + patient_id + "/symptomEvent"
base = {
    "patientId": patient_id,
    "procedureId": procedure_id
    }
counter = 0

def send_data(patient_id, procedure_id, sap, exstrasystole):
    global counter
    data = {
        "patientId": patient_id,
        "procedureId": procedure_id,
        "sap": sap,
        "exstrasystole": exstrasystole
    }
    
    try:
        send_request(data, endpoint_hb)
        if counter == 24 or counter == 0:
            send_request(data, endpoint_sap)
            counter = 0
        if counter == 16 or counter == 0:
            send_request(data, endpoint_symptom)

        # send_request(data, endpoint_hb)
    except Exception as e:
        print(f"An error occurred: {e}")


def send_request(data, url):
    headers = {'Content-Type': 'application/json'}
    response = requests.put(url, headers=headers, data=json.dumps(data))
    if response.status_code != 200:
        print(f"Failed to send data: {response.status_code}, {response.text}")


while True:
    sap = random.randint(50, 145)
    # exstrasystole = random.choices([False, True], weights=[3, 1], k=1)[0]
    exstrasystole = True

    send_request(base, endpoint_hb)
    time.sleep(1.4)
    send_request(base, endpoint_hb)
    time.sleep(1.4)
    send_data(patient_id, procedure_id, sap, exstrasystole)
    counter += 1
