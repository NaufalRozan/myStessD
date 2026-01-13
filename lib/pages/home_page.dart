import 'dart:io';
import 'package:mystessd/constans.dart';
import 'package:mystessd/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class SuggestionDetails extends StatelessWidget {
  final String suggestion;
  final String details;

  const SuggestionDetails({
    Key? key,
    required this.suggestion,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          suggestion,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          details,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class StressDetectionPage extends StatefulWidget {
  const StressDetectionPage({Key? key}) : super(key: key);

  @override
  _StressDetectionPageState createState() => _StressDetectionPageState();
}

class _StressDetectionPageState extends State<StressDetectionPage> {
  String output = '';
  double confidence = 0.0;
  bool isModelBusy = false;
  File? _pickedImage;
  String selectedModel = 'DenseNet201';
  List<String> modelOptions = ['DenseNet201', 'MobileNetV2', 'ResNet50'];

  Map<String, List<Map<String, String>>> suggestions = {
    'Stress': [
      {
        'suggestion': 'Breathing Well',
        'details':
            'Take a moment to breathe deeply; focus on your breath for a few minutes to help calm the mind.'
      },
      {
        'suggestion': 'Short Meditation',
        'details':
            'Take some time to try a short meditation or mindfulness practice; it can reduce stress and enhance mental clarity.'
      },
      {
        'suggestion': 'Engage in physical activity',
        'details':
            'Physical activity is key to reducing stress; a short walk or a yoga session can help relax the body and mind.'
      },
      {
        'suggestion': 'Socializing with Others',
        'details':
            'Talking to friends or family can provide the emotional support you need to feel better.'
      },
    ],
    'Not Stressed': [
      {
        'suggestion': 'Continue to maintain your resting time',
        'details':
            'Maintaining a balance between work and rest is important to prevent stress; remember to take time for yourself.'
      },
      {
        'suggestion': 'Doing a Hobby',
        'details':
            'Engaging in hobbies or activities that you enjoy can serve as a means of distraction from the daily pressures.'
      },
      {
        'suggestion': 'Relaxation',
        'details':
            'Even if you may not feel stressed at the moment, regular relaxation practices such as yoga can help maintain peace of mind.'
      },
      {
        'suggestion': 'Learning to Manage Stress',
        'details':
            'Education about stress and how to manage it can help you stay calm in challenging situations in the future.'
      },
    ]
  };

  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    if (selectedModel == 'DenseNet201') {
      await Tflite.loadModel(
          model: "assets/modelDNmod.tflite", labels: "assets/labelsDNmod.txt");
    }
    if (selectedModel == 'MobileNetV2') {
      await Tflite.loadModel(
          model: "assets/modelMN.tflite", labels: "assets/labelsMNmod.txt");
    }
    if (selectedModel == 'ResNet50') {
      await Tflite.loadModel(
          model: "assets/modelRNmod.tflite", labels: "assets/labelsRNmod.txt");
    }
  }

  runModel(File imageFile) async {
    if (!isModelBusy) {
      try {
        setState(() {
          isModelBusy = true;
        });

        final inputImage = InputImage.fromFilePath(imageFile.path);
        final faceDetector = GoogleMlKit.vision.faceDetector();
        final faces = await faceDetector.processImage(inputImage);

        if (faces.isNotEmpty) {
          var predictions = await Tflite.runModelOnImage(
            path: imageFile.path,
            imageMean: 127.5,
            imageStd: 127.5,
            numResults: 1,
            threshold: 0.1,
          );

          if (predictions != null && predictions.isNotEmpty) {
            setState(() {
              output = predictions[0]['label'];
              confidence = predictions[0]['confidence'];
            });
          } else {
            setState(() {
              output = "No prediction results";
            });
          }
        } else {
          setState(() {
            output = "Face not detected";
          });
        }
      } catch (e) {
        print("Error running model: $e");
      } finally {
        setState(() {
          isModelBusy = false;
        });
      }
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        output = '';
      });

      runModel(_pickedImage!);
    } else {
      print('No image selected.');
    }
  }

  void _resetState() {
    setState(() {
      _pickedImage = null;
      output = '';
      confidence = 0.0;
    });
  }

  void _showMethodSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a method'),
          content: SingleChildScrollView(
            child: ListBody(
              children: modelOptions
                  .map(
                    (String model) => ListTile(
                      title: Text(model),
                      trailing: model == selectedModel
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedModel = model;
                        });
                        Navigator.of(context).pop();
                        loadModel();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text('Check Stress'),
        actions: [
          IconButton(
            onPressed: _showMethodSelectionDialog,
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            icon: Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: _resetState,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: ListView(
              shrinkWrap: false,
              physics: ClampingScrollPhysics(),
              children: [
                Text(
                  "Check Stress",
                  style: textStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5.0,
                            color: primaryButtonColor,
                          ),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _pickedImage != null
                            ? isModelBusy
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _pickedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                            : Center(
                                child: Image.asset(
                                  "assets/icons8-face-recognition-100.png",
                                ),
                              ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _getImage(ImageSource.gallery),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Upload a Photo',
                              style: whiteTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _getImage(ImageSource.camera),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Take a Photo',
                              style: whiteTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if (_pickedImage != null)
                  Column(
                    children: [
                      Text(
                        'Prediction of your face: $output',
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (output != "Face not detected")
                        Text(
                          'With accuracy: ${(confidence * 100).toStringAsFixed(2)}%',
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 10),
                      if (output != "Face not detected" &&
                          suggestions.containsKey(output))
                        Column(
                          children: [
                            Text(
                              'Suggestion:',
                              style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ExpansionPanelList.radio(
                              expandedHeaderPadding: EdgeInsets.zero,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _expandedIndex = isExpanded ? -1 : index;
                                });
                              },
                              children: suggestions[output]!
                                  .asMap()
                                  .entries
                                  .map<ExpansionPanelRadio>(
                                      (MapEntry<int, Map<String, String>>
                                          entry) {
                                final suggestion = entry.value;
                                final index = entry.key;
                                return ExpansionPanelRadio(
                                  value: index,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text(
                                        suggestion['suggestion']!,
                                        style: textStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                  body: ListTile(
                                    title: Text(
                                      suggestion['details']!,
                                      style: secondaryTextStyle.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  canTapOnHeader: true,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                    ],
                  ),
                SizedBox(height: 30),
                Divider(thickness: 1, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  '© ${DateTime.now().year} Universitas Muhammadiyah Yogyakarta',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
