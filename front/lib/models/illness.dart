class Illness {
  int id;
  DateTime date;
  IllnessName name;

  Illness({required this.id, required this.date, required this.name});

  factory Illness.fromJson(Map<String, dynamic> json) {
    return Illness(
      id: json['id'],
      date: DateTime.parse(json['date']),
      name: getIllnessName(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'name': name.toString().split('.').last,
    };
  }

  String get illnessName {
    switch (name) {
      case IllnessName.BRONCHOSPASM:
        return 'Bronhospazam';
      case IllnessName.PNEUMONIA:
        return 'Pneumonija';
      case IllnessName.TENSION_PNEUMOTHORAX:
        return 'Tenzioni pneumotoraks';
      case IllnessName.PULMONARY_TROMBOEMBOLISM:
        return 'Plućna tromboembolija';
      case IllnessName.RESPIRATORY_INSUFICIENCY:
        return 'Respiratorna insuficijencija';
      case IllnessName.HEART_FAILURE:
        return 'Srčana insuficijencija';
      case IllnessName.MYOCARDIAL_INFARCTION:
        return 'Infarkt miokarda';
      default:
        throw Exception('Nepoznata bolest');
    }
  
  }

  String get dateString {
  String dayString = date.day.toString().padLeft(2, '0');
  String monthString = date.month.toString().padLeft(2, '0');

  String hourString = date.hour.toString().padLeft(2, '0');
  String minuteString = date.minute.toString().padLeft(2, '0');

  return '$dayString.$monthString.${date.year}  $hourString:$minuteString';
}
}

enum IllnessName {
  BRONCHOSPASM,
  PNEUMONIA,
  TENSION_PNEUMOTHORAX,
  PULMONARY_TROMBOEMBOLISM,
  RESPIRATORY_INSUFICIENCY,
  HEART_FAILURE,
  MYOCARDIAL_INFARCTION
}

IllnessName getIllnessName(String name) {
  switch (name) {
    case 'BRONCHOSPASM':
      return IllnessName.BRONCHOSPASM;
    case 'PNEUMONIA':
      return IllnessName.PNEUMONIA;
    case 'TENSION_PNEUMOTHORAX':
      return IllnessName.TENSION_PNEUMOTHORAX;
    case 'PULMONARY_TROMBOEMBOLISM':
      return IllnessName.PULMONARY_TROMBOEMBOLISM;
    case 'RESPIRATORY_INSUFICIENCY':
      return IllnessName.RESPIRATORY_INSUFICIENCY;
    case 'HEART_FAILURE':
      return IllnessName.HEART_FAILURE;
    case 'MYOCARDIAL_INFARCTION':
      return IllnessName.MYOCARDIAL_INFARCTION;
    default:
      throw Exception('Unknown illness name');
  }
}
