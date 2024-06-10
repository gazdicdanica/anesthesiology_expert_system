
class Alarm {
  final int id;
  final int patientId;
  final int doctorId;
  final Symptom symptom;

  Alarm({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.symptom,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      symptom: getSymptom(json['symptom']),
    );
  }


}

Symptom getSymptom(String symptom) {
  switch (symptom) {
    case 'Arythmia':
      return Symptom.Arythmia;
    case 'Bradycardia':
      return Symptom.Bradycardia;
    case 'Bradypnea':
      return Symptom.Bradypnea;
    case 'Cyanosis':
      return Symptom.Cyanosis;
    case 'Dyspnea':
      return Symptom.Dyspnea;
    case 'Exstrasystole':
      return Symptom.Exstrasystole;
    case 'Hypertension':
      return Symptom.Hypertension;
    case 'Hypotension':
      return Symptom.Hypotension;
    case 'Hypoxemia':
      return Symptom.Hypoxemia;
    case 'Tachycardia':
      return Symptom.Tachycardia;
    case 'Tachypnea':
      return Symptom.Tachypnea;
    case 'Wheezing':
      return Symptom.Wheezing;
    case 'Fever':
      return Symptom.Fever;
    case 'AbsentBreathSounds':
      return Symptom.AbsentBreathSounds;
    case 'PulmonaryEdema':
      return Symptom.PulmonaryEdema;
    case 'ChestPain':
      return Symptom.ChestPain;
    default:
      return Symptom.Arythmia;
  }
}

String getSymptomString(Symptom symptom){
  switch (symptom) {
    case Symptom.Arythmia:
      return 'Arrhytmia';
    case Symptom.Bradycardia:
      return 'Bradycardia';
    case Symptom.Bradypnea:
      return 'Bradypnoea';
    case Symptom.Cyanosis:
      return 'Cyanosis';
    case Symptom.Exstrasystole:
      return 'Extrasystolae';
    case Symptom.Hypertension:
      return 'Hypertensio';
    case Symptom.Hypotension:
      return 'Hypotensio';
    case Symptom.Hypoxemia:
      return 'Hypoxemia';
    case Symptom.Tachycardia:
      return 'Tachycardia';
    case Symptom.Tachypnea:
      return 'Tachypnoea';

    case Symptom.Dyspnea:
      return 'Dyspnoea';
    case Symptom.Wheezing:
      return 'Zviždanje u grudima';
    case Symptom.Fever:
      return 'Temperatura';
    case Symptom.AbsentBreathSounds:
      return 'Nečujno disanje';
    case Symptom.PulmonaryEdema:
      return 'Plućni edem';
    case Symptom.ChestPain:
      return 'Bol u grudima';
    default:
      return 'Arythmia';
  }

}

enum Symptom {
  Arythmia,
  Bradycardia,
  Bradypnea,
  Cyanosis,
  Dyspnea,
  Exstrasystole,
  Hypertension,
  Hypotension,
  Hypoxemia,
  Tachycardia,
  Tachypnea,
  Wheezing,
  Fever,
  AbsentBreathSounds,
  PulmonaryEdema,
  ChestPain
}
