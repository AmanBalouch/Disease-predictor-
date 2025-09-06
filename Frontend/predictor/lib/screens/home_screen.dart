import 'package:flutter/material.dart';
import 'package:predictor/screens/output_screen.dart';
import 'package:predictor/screens/splash_screen.dart';
import '../constants/colors.dart';
import '../utils/ui_helper.dart';
import 'dart:convert'; // For jsonEncode
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> sendData(BuildContext context,List<String> selectedSymptoms) async {
    final url = Uri.parse('https://DurMuhammadKhan.pythonanywhere.com/predict');

    final Map<String, dynamic> data = {
      for (var symptom in selectedSymptoms) symptom: 1,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double bernoulliConfidence = data['bernoulli_nb']['confidence'];
        String bernoulliPrediction = data['bernoulli_nb']['prediction'];
        // Access values for 'multinomial_nb'
        double multinomialConfidence = data['multinomial_nb']['confidence'];
        String multinomialPrediction = data['multinomial_nb']['prediction'];
        String disease =
        bernoulliConfidence > multinomialConfidence
            ? bernoulliPrediction
            : multinomialPrediction;
        double con =
        bernoulliConfidence > multinomialConfidence
            ? bernoulliConfidence
            : multinomialConfidence;
        String confidence = con.toString();
        // Successfully got a response
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                SplashScreen(
                  targetScreen: "output_screen",
                  disease: disease,
                  confidence: confidence,
                ),
          ),
        );
      } else {
        // ✅ Show Snackbar on non-200 response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get prediction: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // ✅ Show AlertDialog on exception
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Network Error'),
              content: Text('Could not send data. Error: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
            ),
      );
    }
  }

  List<String?> selectedSymptoms = [null];

  final List<String> symptoms = [
    'abdominal distention',
    'abnormal appearing skin',
    'abnormal appearing tongue',
    'abnormal breathing sounds',
    'abnormal involuntary movements',
    'abnormal movement of eyelid',
    'abnormal size or shape of ear',
    'absence of menstruation',
    'abusing alcohol',
    'ache all over',
    'acne or pimples',
    'allergic reaction',
    'ankle pain',
    'ankle stiffness or tightness',
    'ankle swelling',
    'ankle weakness',
    'antisocial behavior',
    'anxiety and nervousness',
    'apnea',
    'arm cramps or spasms',
    'arm lump or mass',
    'arm pain',
    'arm stiffness or tightness',
    'arm swelling',
    'arm weakness',
    'back cramps or spasms',
    'back mass or lump',
    'back pain',
    'back stiffness or tightness',
    'back swelling',
    'back weakness',
    'bedwetting',
    'bladder mass',
    'bleeding from ear',
    'bleeding from eye',
    'bleeding gums',
    'bleeding in mouth',
    'bleeding or discharge from nipple',
    'blindness',
    'blood clots during menstrual periods',
    'blood in stool',
    'blood in urine',
    'bones are painful',
    'bowlegged or knock-kneed',
    'breathing fast',
    'bumps on penis',
    'burning abdominal pain',
    'burning chest pain',
    'change in skin mole size or color',
    'changes in stool appearance',
    'chest tightness',
    'chills',
    'cloudy eye',
    'congestion in chest',
    'constipation',
    'coryza',
    'cough',
    'coughing up sputum',
    'cramps and spasms',
    'cross-eyed',
    'decreased appetite',
    'decreased heart rate',
    'delusions or hallucinations',
    'depression',
    'depressive or psychotic symptoms',
    'diaper rash',
    'diarrhea',
    'difficulty breathing',
    'difficulty eating',
    'difficulty in swallowing',
    'difficulty speaking',
    'diminished hearing',
    'diminished vision',
    'discharge in stools',
    'disturbance of memory',
    'disturbance of smell or taste',
    'dizziness',
    'double vision',
    'drainage in throat',
    'drug abuse',
    'dry lips',
    'dry or flaky scalp',
    'ear pain',
    'early or late onset of menopause',
    'elbow cramps or spasms',
    'elbow lump or mass',
    'elbow pain',
    'elbow stiffness or tightness',
    'elbow swelling',
    'elbow weakness',
    'emotional symptoms',
    'excessive anger',
    'excessive appetite',
    'excessive growth',
    'excessive urination at night',
    'eye burns or stings',
    'eye deviation',
    'eye moves abnormally',
    'eye redness',
    'eye strain',
    'eyelid lesion or rash',
    'eyelid retracted',
    'eyelid swelling',
    'facial pain',
    'fainting',
    'fatigue',
    'fears and phobias',
    'feeling cold',
    'feeling hot',
    'feeling hot and cold',
    'feeling ill',
    'feet turned in',
    'fever',
    'flatulence',
    'flu-like syndrome',
    'fluid in ear',
    'fluid retention',
    'flushing',
    'focal weakness',
    'foot or toe cramps or spasms',
    'foot or toe lump or mass',
    'foot or toe pain',
    'foot or toe stiffness or tightness',
    'foot or toe swelling',
    'foot or toe weakness',
    'foreign body sensation in eye',
    'frequent menstruation',
    'frequent urination',
    'frontal headache',
    'groin mass',
    'groin pain',
    'gum pain',
    'hand or finger cramps or spasms',
    'hand or finger lump or mass',
    'hand or finger pain',
    'hand or finger stiffness or tightness',
    'hand or finger swelling',
    'hand or finger weakness',
    'headache',
    'heartburn',
    'heavy menstrual flow',
    'hemoptysis',
    'hesitancy',
    'hip lump or mass',
    'hip pain',
    'hip stiffness or tightness',
    'hip swelling',
    'hip weakness',
    'hoarse voice',
    'hostile behavior',
    'hot flashes',
    'hurts to breath',
    'hysterical behavior',
    'impotence',
    'incontinence of stool',
    'increased heart rate',
    'infant feeding problem',
    'infant spitting up',
    'infertility',
    'infrequent menstruation',
    'insomnia',
    'intermenstrual bleeding',
    'involuntary urination',
    'irregular appearing nails',
    'irregular appearing scalp',
    'irregular belly button',
    'irregular heartbeat',
    'irritable infant',
    'itchiness of eye',
    'itching of scrotum',
    'itching of skin',
    'itching of the anus',
    'itchy ear(s)',
    'itchy eyelid',
    'itchy scalp',
    'jaundice',
    'jaw pain',
    'jaw swelling',
    'joint pain',
    'joint stiffness or tightness',
    'joint swelling',
    'kidney mass',
    'knee cramps or spasms',
    'knee lump or mass',
    'knee pain',
    'knee stiffness or tightness',
    'knee swelling',
    'knee weakness',
    'lack of growth',
    'lacrimation',
    'leg cramps or spasms',
    'leg lump or mass',
    'leg pain',
    'leg stiffness or tightness',
    'leg swelling',
    'leg weakness',
    'lip sore',
    'lip swelling',
    'long menstrual periods',
    'loss of sensation',
    'loss of sex drive',
    'low back cramps or spasms',
    'low back pain',
    'low back stiffness or tightness',
    'low back swelling',
    'low back weakness',
    'low self-esteem',
    'low urine output',
    'lower abdominal pain',
    'lower body pain',
    'lump in throat',
    'lump or mass of breast',
    'lump over jaw',
    'lymphedema',
    'mass in scrotum',
    'mass on ear',
    'mass on eyelid',
    'mass on vulva',
    'mass or swelling around the anus',
    'melena',
    'mouth dryness',
    'mouth pain',
    'mouth ulcer',
    'muscle cramps, contractures, or spasms',
    'muscle pain',
    'muscle stiffness or tightness',
    'muscle swelling',
    'muscle weakness',
    'nailbiting',
    'nasal congestion',
    'nausea',
    'neck cramps or spasms',
    'neck mass',
    'neck pain',
    'neck stiffness or tightness',
    'neck swelling',
    'neck weakness',
    'nightmares',
    'nose deformity',
    'nosebleed',
    'obsessions and compulsions',
    'pain during intercourse',
    'pain during pregnancy',
    'pain in eye',
    'pain in gums',
    'pain in testicles',
    'pain of the anus',
    'pain or soreness of breast',
    'painful menstruation',
    'painful sinuses',
    'painful urination',
    'pallor',
    'palpitations',
    'paresthesia',
    'pelvic pain',
    'pelvic pressure',
    'penile discharge',
    'penis pain',
    'penis redness',
    'peripheral edema',
    'plugged feeling in ear',
    'polyuria',
    'poor circulation',
    'postpartum problems of the breast',
    'posture problems',
    'premature ejaculation',
    'premenstrual tension or irritability',
    'problems during pregnancy',
    'problems with movement',
    'problems with orgasm',
    'problems with shape or size of breast',
    'pulling at ears',
    'pupils unequal',
    'pus draining from ear',
    'pus in sputum',
    'pus in urine',
    'recent pregnancy',
    'recent weight loss',
    'rectal bleeding',
    'redness in ear',
    'redness in or around nose',
    'regurgitation',
    'regurgitation.1',
    'restlessness',
    'retention of urine',
    'rib pain',
    'ringing in ear',
    'scanty menstrual flow',
    'seizures',
    'sharp abdominal pain',
    'sharp chest pain',
    'shortness of breath',
    'shoulder cramps or spasms',
    'shoulder lump or mass',
    'shoulder pain',
    'shoulder stiffness or tightness',
    'shoulder swelling',
    'shoulder weakness',
    'side pain',
    'sinus congestion',
    'skin dryness, peeling, scaliness, or roughness',
    'skin growth',
    'skin irritation',
    'skin lesion',
    'skin moles',
    'skin oiliness',
    'skin on arm or hand looks infected',
    'skin on head or neck looks infected',
    'skin on leg or foot looks infected',
    'skin pain',
    'skin rash',
    'skin swelling',
    'sleepiness',
    'sleepwalking',
    'slurring words',
    'smoking problems',
    'sneezing',
    'sore in nose',
    'sore throat',
    'spots or clouds in vision',
    'spotting or bleeding during pregnancy',
    'stiffness all over',
    'stomach bloating',
    'stuttering or stammering',
    'suprapubic pain',
    'sweating',
    'swelling of scrotum',
    'swollen abdomen',
    'swollen eye',
    'swollen lymph nodes',
    'swollen or red tonsils',
    'swollen tongue',
    'symptoms of bladder',
    'symptoms of eye',
    'symptoms of infants',
    'symptoms of prostate',
    'symptoms of the face',
    'symptoms of the kidneys',
    'symptoms of the scrotum and testes',
    'temper problems',
    'thirst',
    'throat feels tight',
    'throat irritation',
    'throat redness',
    'throat swelling',
    'tongue bleeding',
    'tongue lesions',
    'tongue pain',
    'too little hair',
    'toothache',
    'underweight',
    'unpredictable menstruation',
    'unusual color or odor to urine',
    'unwanted hair',
    'upper abdominal pain',
    'uterine contractions',
    'vaginal bleeding after menopause',
    'vaginal discharge',
    'vaginal dryness',
    'vaginal itching',
    'vaginal pain',
    'vaginal redness',
    'vomiting',
    'vomiting blood',
    'vulvar irritation',
    'vulvar sore',
    'warts',
    'weakness',
    'weight gain',
    'wheezing',
    'white discharge from eye',
    'wrinkles on skin',
    'wrist lump or mass',
    'wrist pain',
    'wrist stiffness or tightness',
    'wrist swelling',
    'wrist weakness',
  ];
  void addDropdown() {
    setState(() {
      selectedSymptoms.add(null);
    });
  }

  void removeDropdown(int index) {
    setState(() {
      selectedSymptoms.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Field"),
          content: Text("Do you want to delete this field?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                removeDropdown(index);
                Navigator.of(context).pop(); // Close dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:TextWidget(text: "Select Symptoms", size: 26, boldText: true, textColor: Colors.black)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedSymptoms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onLongPress: ()=>_showDeleteDialog(index),
                          child: DropdownButtonFormField<String>(
                            value: selectedSymptoms[index],
                            items:
                                symptoms
                                    .map(
                                      (symptom) => DropdownMenuItem(
                                        value: symptom,
                                        child: Text(symptom),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSymptoms[index] = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "Select a symptom",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: addDropdown,
              icon: const Icon(Icons.add,color: Colors.black,),
              label: TextWidget(text: "Add another symptom", size: 20, boldText: false, textColor: Colors.black),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final validSymptoms =
                    selectedSymptoms.whereType<String>().toList();
                // print("Selected symptoms: $validSymptoms");
                // You can now use the selected symptoms for diagnosis or navigation
                sendData(context,validSymptoms);
              },
              child: TextWidget(text: "Submit", size: 20, boldText: false, textColor: Colors.black),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
