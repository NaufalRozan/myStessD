import 'package:mystessd/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int? _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Initialize about data with localized strings
    final List<Map<String, String>> about = [
      {
        'suggestion': l10n.appName,
        'details': l10n.appNameValue,
      },
      {
        'suggestion': l10n.appVersion,
        'details': l10n.appVersionValue,
      },
      {
        'suggestion': l10n.developedBy,
        'details': l10n.developedByValue,
      },
      {
        'suggestion': l10n.institution,
        'details': l10n.institutionValue,
      },
      {
        'suggestion': l10n.aboutApplication,
        'details': l10n.aboutApplicationValue,
      },
      {
        'suggestion': l10n.dataset,
        'details': l10n.datasetValue,
      },
      {
        'suggestion': l10n.contact,
        'details': l10n.contactValue,
      },
      {
        'suggestion': l10n.referenceSource,
        'details': l10n.referenceSourceValue,
      },
    ];

    final List<Map<String, String>> referensi = [
      {
        'suggestion': l10n.breathingWell,
        'details': l10n.breathingWellRef,
      },
      {
        'suggestion': l10n.shortMeditation,
        'details': l10n.shortMeditationRef,
      },
      {
        'suggestion': l10n.physicalActivity,
        'details': l10n.physicalActivityRef,
      },
      {
        'suggestion': l10n.socializing,
        'details': l10n.socializingRef,
      },
      {
        'suggestion': l10n.maintainRest,
        'details': l10n.maintainRestRef,
      },
      {
        'suggestion': l10n.doingHobby,
        'details': l10n.doingHobbyRef,
      },
      {
        'suggestion': l10n.relaxation,
        'details': l10n.relaxationRef,
      },
      {
        'suggestion': l10n.learningStressManagement,
        'details': l10n.learningStressManagementRef,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(l10n.aboutApp),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Image.asset(
                  "assets/Development-amico.png",
                ),
                Text(
                  l10n.aboutApp,
                  style: textStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: _buildPanel(about),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  l10n.referenceSuggestions,
                  style: textStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: _buildPanelReferensi(referensi),
                ),
                SizedBox(height: 30),
                Divider(thickness: 1, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  l10n.copyright(DateTime.now().year.toString()),
                  style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  l10n.informationTechnologyProgram,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  l10n.aiRoboticsGroup,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 11,
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

  Widget _buildPanel(List<Map<String, String>> about) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedIndex = isExpanded ? null : index;
        });
      },
      children: about.asMap().entries.map<ExpansionPanelRadio>((entry) {
        final index = entry.key;
        final suggestion = entry.value;
        return ExpansionPanelRadio(
          value: index,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                suggestion['suggestion']!,
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Text(
              suggestion['details']!,
              style: secondaryTextStyle.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  Widget _buildPanelReferensi(List<Map<String, String>> referensi) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedIndex = isExpanded ? null : index;
        });
      },
      children: referensi.asMap().entries.map<ExpansionPanelRadio>((entry) {
        final index = entry.key;
        final suggestion = entry.value;
        return ExpansionPanelRadio(
          value: index,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                suggestion['suggestion']!,
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Text(
              suggestion['details']!,
              style: secondaryTextStyle.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }
}
