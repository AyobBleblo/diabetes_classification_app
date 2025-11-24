class DiabetesInput {
  final double highBP;
  final double highChol;
  final double cholCheck;
  final double bmi;
  final double smoker;
  final double stroke;
  final double heartDiseaseorAttack;
  final double physActivity;
  final double fruits;
  final double veggies;
  final double hvyAlcoholConsump;
  final double anyHealthcare;
  final double noDocbcCost;
  final double genHlth;
  final double mentHlth;
  final double physHlth;
  final double diffWalk;
  final double sex;
  final double age;
  final double education;
  final double income;

  DiabetesInput({
    required this.highBP,
    required this.highChol,
    required this.cholCheck,
    required this.bmi,
    required this.smoker,
    required this.stroke,
    required this.heartDiseaseorAttack,
    required this.physActivity,
    required this.fruits,
    required this.veggies,
    required this.hvyAlcoholConsump,
    required this.anyHealthcare,
    required this.noDocbcCost,
    required this.genHlth,
    required this.mentHlth,
    required this.physHlth,
    required this.diffWalk,
    required this.sex,
    required this.age,
    required this.education,
    required this.income,
  });

  Map<String, dynamic> toJson() {
    return {
      "HighBP": highBP,
      "HighChol": highChol,
      "CholCheck": cholCheck,
      "BMI": bmi,
      "Smoker": smoker,
      "Stroke": stroke,
      "HeartDiseaseorAttack": heartDiseaseorAttack,
      "PhysActivity": physActivity,
      "Fruits": fruits,
      "Veggies": veggies,
      "HvyAlcoholConsump": hvyAlcoholConsump,
      "AnyHealthcare": anyHealthcare,
      "NoDocbcCost": noDocbcCost,
      "GenHlth": genHlth,
      "MentHlth": mentHlth,
      "PhysHlth": physHlth,
      "DiffWalk": diffWalk,
      "Sex": sex,
      "Age": age,
      "Education": education,
      "Income": income,
    };
  }
}
