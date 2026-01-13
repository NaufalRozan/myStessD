import 'package:mystessd/constans.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Contoh data untuk "Tentang Aplikasi"
  final List<Map<String, String>> about = [
    {
      'suggestion': 'Nama Aplikasi',
      'details': 'MyStessD - Stress Detection Application',
    },
    {
      'suggestion': 'Versi Aplikasi',
      'details': '1.0.0',
    },
    {
      'suggestion': 'Dikembangkan Oleh',
      'details':
          'Slamet Riyadi, Cahya Damarjati, dan Tim Pengembang',
    },
    {
      'suggestion': 'Institusi',
      'details':
          'Program Studi Teknologi Informasi bekerja sama dengan Artificial Intelligence and Robotics Research Group\nUniversitas Muhammadiyah Yogyakarta',
    },
    {
      'suggestion': 'Tentang Aplikasi',
      'details':
          "Aplikasi ini memanfaatkan Convolutional Neural Network (CNN) yang telah dimodifikasi untuk mendeteksi stres melalui ekspresi wajah, dengan harapan dapat meningkatkan kesadaran individu terhadap tingkat stres mereka sendiri.",
    },
    {
      'suggestion': 'Dataset',
      'details':
          'Stress Face Dataset',
    },
    {
      'suggestion': 'Kontak',
      'details': 'Email: naufall.rozan@gmail.com',
    },
    {
      'suggestion': 'Referensi Saran',
      'details':
          'Saran-saran yang diberikan diambil dari jurnal-jurnal terpercaya.',
    },
  ];
  final List<Map<String, String>> referensi = [
    {
      'suggestion': 'Breathing Well',
      'details':
          'Ma, X., Yue, Z. Q., Gong, Z. Q., Zhang, H., Duan, N. Y., Shi, Y. T., Wei, G. X., & Li, Y. F. (2017). The effect of diaphragmatic breathing on attention, negative affect and stress in healthy adults. Frontiers in Psychology, 8(JUN). https://doi.org/10.3389/fpsyg.2017.00874',
    },
    {
      'suggestion': 'Short Meditation',
      'details':
          'Zuo, X., Tang, Y., Chen, Y., & Zhou, Z. (2023). The efficacy of mindfulness-based interventions on mental health among university students: a systematic review and meta-analysis. In Frontiers in Public Health (Vol. 11). Frontiers Media SA. https://doi.org/10.3389/fpubh.2023.1259250',
    },
    {
      'suggestion': 'Engage in physical activity',
      'details':
          'Wang, X., Cai, Z. dong, Jiang, W. ting, Fang, Y. yan, Sun, W. xin, & Wang, X. (2022). Systematic review and meta-analysis of the effects of exercise on depression in adolescents. In Child and Adolescent Psychiatry and Mental Health (Vol. 16, Issue 1). BioMed Central Ltd. https://doi.org/10.1186/s13034-022-00453-2',
    },
    {
      'suggestion': 'Socializing with Others',
      'details':
          'Holt-Lunstad, J. (2022). Social Connection as a Public Health Issue: The Evidence and a Systemic Framework for Prioritizing the “Social” in Social Determinants of Health. Annu. Rev. Public Health, 43, 193-213. https://doi.org/10.1146/annurev-publhealth',
    },
    {
      'suggestion': 'Continue to maintain your resting time',
      'details':
          'Scott, A. J., Webb, T. L., Martyn-St James, M., Rowse, G., & Weich, S. (2021). Improving sleep quality leads to better mental health: A meta-analysis of randomised controlled trials. In Sleep Medicine Reviews (Vol. 60). W.B. Saunders Ltd. https://doi.org/10.1016/j.smrv.2021.101556',
    },
    {
      'suggestion': 'Doing a Hobby',
      'details':
          'Li, Z., Dai, J., Wu, N., Jia, Y., Gao, J., & Fu, H. (2019). Effect of long working hours on depression and mental well-being among employees in Shanghai: The role of having leisure hobbies. International Journal of Environmental Research and Public Health, 16(24). https://doi.org/10.3390/ijerph16244980',
    },
    {
      'suggestion': 'Relaxation',
      'details':
          'Zuo, X., Tang, Y., Chen, Y., & Zhou, Z. (2023). The efficacy of mindfulness-based interventions on mental health among university students: a systematic review and meta-analysis. In Frontiers in Public Health (Vol. 11). Frontiers Media SA. https://doi.org/10.3389/fpubh.2023.1259250',
    },
    {
      'suggestion': 'Learning to Manage Stress',
      'details':
          'Algorani, E. B., & Gupta, V. (2023). Coping Mechanisms. In StatPearls. StatPearls Publishing.',
    },
  ];

  int? _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text("About the Application"),
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
                  "About the Application",
                  style: textStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: _buildPanel(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Reference Suggestions",
                  style: textStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: _buildPanelReferensi(),
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
                SizedBox(height: 5),
                Text(
                  'Program Studi Teknologi Informasi',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Artificial Intelligence and Robotics Research Group',
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

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedIndex = isExpanded
              ? null
              : index; // Perbaiki logika untuk mengelola panel yang ter-expand
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

  Widget _buildPanelReferensi() {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedIndex = isExpanded
              ? null
              : index; // Perbaiki logika untuk mengelola panel yang ter-expand
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
