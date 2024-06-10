import requests, json, time, sys, random

patient_id = sys.argv[1]
procedure_id = sys.argv[2]
ip = sys.argv[3]

endpoint = "http://" + ip + ":8080/api/procedure/" + patient_id + "/postOpData"
counter = 0

def send_request(sap, pulseOximetry, breath, heartBeat):
    base = {
    "patientId": patient_id,
    "procedureId": procedure_id,
    "sap": sap,
    "pulseOximetry": pulseOximetry,
    "breathEvent": breath,
    "heartBeatEvent": heartBeat
    }
    headers = {'Content-Type': 'application/json'}
    response = requests.put(endpoint, headers=headers, data=json.dumps(base))
    if response.status_code != 200:
        print(f"Failed to send data: {response.status_code}, {response.text}")


while True:
    sap = random.randint(50, 145)
    pulseOximetry = random.randint(90, 100)
    breath = random.choices([True, False], weights=[3, 1], k=1)[0]
    heartBeat = True

    send_request(sap, pulseOximetry, breath, heartBeat)
    time.sleep(1.4)
    send_request(sap, pulseOximetry, breath, heartBeat)
    counter += 1
