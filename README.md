# Anesthesiology expert system

Aplikacija je namenjena anesteziolozima i medicinskim tehničarima kao pomoć u identifikaciji i prevenciji kardiovaskularnih komplikacija u toku perioperativnog perioda.

## Tehnologije
1. Drools (instalirajte neophodne ekstenzije za željeni IDE)
2. [Flutter](https://docs.flutter.dev/get-started/install)
3. [Python](https://www.python.org/downloads/)


## Pokretanje

- Klonirajte repozitorijum
  ```
  git clone https://github.com/gazdicdanica/anesthesiology_expert_system
  ```

### Backend (sbnz-integracija-projekta)
- Sastoji se iz 3 celine:
  1. kjar (drools poslovna logika)
  2. service (web app)
  3. model

1. Pozicionirajte se u svaki od 3 poddirektorijuma:
    ```
    cd sbnz-integracija-pojekta/kjar
    cd sbnz-integracija-pojekta/model
    cd sbnz-integracija-pojekta/service
    ```
2. Pokrenite komandu u svakom od poddirektorijuma:
   ```
   mvn clean install
   ```
3. Pokrenite service aplikaciju

### Frontend 
1. Pozicionirajte se u direktorijum sa Flutter aplikacijom:
   ```
   cd front
   ```
2. Dobavite IP adresu svog računara  
   - Windows
     ```
     ipconfig
     ```
   - Linux/MacOS
     ```
     ifconfig
     ```
3. Pozicionirajte se u lib/server_path.dart u željenom IDE i zamenite trenutnu IP adresu vašom.
4. Instalirajte neophodne pakete
   ```
   flutter pub get
   ```
5. Priključite USB-om android uređaj na kom su prethodno uključene ***Opcije za programere*** i ***USB debugging*** ([Android dokumentacija](https://developer.android.com/studio/debug/dev-options)) i dozvolite prenos datoteka preko USB.
6. Da biste instalirali aplikaciju na svoj uređaj pokrenite komandu:
   ```
   flutter run
   ```

### Simulacija (python)
- Za simulaciju intra, ondosno postoperativnih podataka neophodno je u bazi imati pacijenta i proceduru koja se nalazi u jednom od ta dva perioda.
1. Pozicionirajte se u python direktorijum
   ```
   cd python
   ```
2. Instalirajte neophodne biblioteke
   ```
   pip install -r requirements.txt
   ```
3. Pokretanje skripta
   ```
   python intraoperative_data.py {ID_pacijenta} {ID_procedure} {ip_adresa}
   python postoperative_data.py {ID_pacijenta} {ID_procedure} {ip_adresa}
   ```
