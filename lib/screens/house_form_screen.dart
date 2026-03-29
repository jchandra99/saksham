import 'package:flutter/material.dart';
import '../models/house_data_model.dart';
import '../widgets/yes_no_field.dart';
import '../widgets/yes_no_na_field.dart';
import '../widgets/multi_select_field.dart';
import '../widgets/text_input_field.dart';
import '../widgets/section_header.dart';
import '../constants/app_colors.dart';

class HouseFormScreen extends StatelessWidget {
  final HouseMonitoringData house;
  final ValueChanged<HouseMonitoringData> onChanged;
  final VoidCallback? onCopyFromHouse1;

  const HouseFormScreen({super.key, required this.house, required this.onChanged, this.onCopyFromHouse1});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (onCopyFromHouse1 != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                onPressed: onCopyFromHouse1,
                icon: const Icon(Icons.copy),
                label: const Text('Copy from House 1'),
              ),
            ),
          const SizedBox(height: 8),
          SectionHeader(title: 'SECTION 1 — जागरूकता', color: AppColors.sectionBlue),
          const SizedBox(height: 8),
          _buildYesNo('Q1.1 क्या आपको दस्तक और संचारी अभियान के बारे में पता है?', house.q1_1_aware_dastak, (value) {
            house.q1_1_aware_dastak = value;
            if (value != 'हाँ') house.q1_2_source_codes = '';
            onChanged(house);
          }),
          const SizedBox(height: 12),
          if (house.q1_1_aware_dastak == 'हाँ')
            MultiSelectField(
              label: 'Q1.2 यदि हाँ, तो जानकारी के स्रोत',
              options: [
                'A - आशा/ए0एन0एम0',
                'B - आँगनबाड़ी',
                'C - मीडिया (अखबार/टीवी/रेडियो)',
                'D - अन्य प्रचार-प्रसार सामग्री (पोस्टर/बैनर/स्टीकर)',
                'E - अन्य',
              ],
              selectedValues: _splitCodes(house.q1_2_source_codes),
              onChanged: (values) {
                house.q1_2_source_codes = values.join(', ');
                onChanged(house);
              },
            ),
          if (house.q1_1_aware_dastak == 'हाँ') const SizedBox(height: 12),
          _buildYesNoNA('Q1.3 परिवार को संचारी रोग से बचाव के, कोई भी संदेश मिले', house.q1_3_received_message, (value) {
            house.q1_3_received_message = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 2 — आशा / आंगनवाड़ी की गतिविधियाँ', color: AppColors.sectionGreen),
          const SizedBox(height: 8),
          _buildYesNoNA('Q2.1 क्या किसी आशा ने दस्तक अभियान के दौरान परिवार का भ्रमण किया है?', house.q2_1_asha_visited, (value) {
            house.q2_1_asha_visited = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.2 क्या आशा ने आपको संचारी रोगों / दिमागी बुखार एवं इनके कारणों के विषय में जानकारी उपलब्ध करायी?', house.q2_2_asha_info_given, (value) {
            house.q2_2_asha_info_given = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.3 क्या आशा ने संचारी रोगों / दिमागी बुखार से बचाव के लिए परिवार को शिक्षित किया है?', house.q2_3_asha_educated_prevention, (value) {
            house.q2_3_asha_educated_prevention = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.4.1 क्या आशा ने तेज बुखार / दिमागी बुखार के मामलों के निकटतम सरकारी स्वास्थ्य सुविधा पर प्रारंभिक उपचार के महत्व के विषय में परिवार को शिक्षित किया?', house.q2_4_1_asha_educated_treatment, (value) {
            house.q2_4_1_asha_educated_treatment = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.4.2 क्या आशा ने 108 एम्बुलेंस के उपयोग पर परिवार को तेज बुखार / दिमागी बुखार के मामलों में निकटतम स्वास्थ्य सुविधा के लिए शिक्षित किया?', house.q2_4_2_asha_108_ambulance, (value) {
            house.q2_4_2_asha_108_ambulance = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.4.3 आशा के भ्रमण के दिन क्या घर में किसी व्यक्ति को बुखार था?', house.q2_4_3_fever_on_visit_day, (value) {
            house.q2_4_3_fever_on_visit_day = value;
            if (value != 'हाँ') house.q2_4_4_asha_advised_hospital = 'नहीं';
            onChanged(house);
          }),
          if (house.q2_4_3_fever_on_visit_day == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNo('Q2.4.4 यदि हाँ, तो क्या आशा ने परिवार को बुखार के मरीज को नजदीकी अस्पताल में ले जाने के लिए सलाह दी थी?', house.q2_4_4_asha_advised_hospital, (value) {
              house.q2_4_4_asha_advised_hospital = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 12),
          _buildYesNo('Q2.5 क्या आशा द्वारा हीट वेव (लू) से बचाव हेतु परिवार को संदेश/जानकारी दी गई है?', house.q2_5_heatwave_message, (value) {
            house.q2_5_heatwave_message = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.5.1 क्या आशा ने मच्छरों और अन्य वैक्टरों के प्रजनन स्रोतों के बारे में परिवार को शिक्षित किया था?', house.q2_5_1_mosquito_breeding_info, (value) {
            house.q2_5_1_mosquito_breeding_info = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.5.2 क्या आशा ने घर के अंदर जाकर मच्छर प्रजनन के स्रोतों की जांच करी एवं मच्छर प्रजनन स्रोतों के निराकरण की किसी विधि के विषय में घर वालों को सूचित किया था?', house.q2_5_2_mosquito_source_check, (value) {
            house.q2_5_2_mosquito_source_check = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.5.3 क्या आशा द्वारा मच्छर प्रजनन स्रोतों की सूचना एंटोमोलॉजिकल प्रपत्र पर अंकित की गई?', house.q2_5_3_entomological_form, (value) {
            house.q2_5_3_entomological_form = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q2.6.1 क्या परिवार में 14 दिन से अधिक बुखार वाले रोगी चिन्हित हुए (कालाजार प्रभावित जनपदों हेतु)', house.q2_6_1_fever_14days, (value) {
            house.q2_6_1_fever_14days = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q2.6.2 क्या आशा द्वारा कालाजार रोग से बचाव हेतु परिवार को संदेश/जानकारी दी गई है? (कालाजार प्रभावित जनपदों हेतु)', house.q2_6_2_kala_azar_info, (value) {
            house.q2_6_2_kala_azar_info = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.7.1 क्या आशा ने क्षय रोग के लक्षणों के विषय में परिवार को शिक्षित किया था?', house.q2_7_1_tb_symptoms_educated, (value) {
            house.q2_7_1_tb_symptoms_educated = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.7.2 क्या आशा के भ्रमण के दौरान क्षय रोग का कोई संभावित रोगी चिन्हित हुआ था?', house.q2_7_2_tb_patient_identified, (value) {
            house.q2_7_2_tb_patient_identified = value;
            if (value != 'हाँ') house.q2_7_3_tb_referred_health_center = 'नहीं';
            onChanged(house);
          }),
          if (house.q2_7_2_tb_patient_identified == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNo('Q2.7.3 यदि हाँ, तो आशा को उस व्यक्ति को निकटतम स्वास्थ्य केंद्र पर जाँच कराने हेतु प्रेरित किया था?', house.q2_7_3_tb_referred_health_center, (value) {
              house.q2_7_3_tb_referred_health_center = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 12),
          _buildYesNo('Q2.7.4 क्या भ्रमण किये गए परिवार में किसी व्यक्ति का क्षय रोग का उपचार चल रहा है?', house.q2_7_4_tb_treatment_ongoing, (value) {
            house.q2_7_4_tb_treatment_ongoing = value;
            if (value != 'हाँ') {
              house.q2_7_5_tb_contacts_tested = 'नहीं';
              house.q2_7_6_tb_positive_contacts_treated = 'नहीं';
              house.q2_7_7_tb_negative_contacts_treated = 'नहीं';
            }
            onChanged(house);
          }),
          if (house.q2_7_4_tb_treatment_ongoing == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNo('Q2.7.5 यदि हाँ, तो क्या निकट संपर्कों की क्षय रोग हेतु जाँच करायी गई है?', house.q2_7_5_tb_contacts_tested, (value) {
              house.q2_7_5_tb_contacts_tested = value;
              if (value != 'हाँ') {
                house.q2_7_6_tb_positive_contacts_treated = 'नहीं';
                house.q2_7_7_tb_negative_contacts_treated = 'नहीं';
              }
              onChanged(house);
            }),
            if (house.q2_7_5_tb_contacts_tested == 'हाँ') ...[
              const SizedBox(height: 12),
              _buildYesNo('Q2.7.6 यदि हाँ, तो क्या क्षय रोग धनात्मक निकट संपर्कों को क्षय रोग हेतु उपचार दिया जा रहा है?', house.q2_7_6_tb_positive_contacts_treated, (value) {
                house.q2_7_6_tb_positive_contacts_treated = value;
                onChanged(house);
              }),
              const SizedBox(height: 12),
              _buildYesNo('Q2.7.7 यदि हाँ, तो क्या क्षय रोग ऋणात्मक निकट संपर्कों को क्षय रोग से बचाव हेतु उपचार दिया जा रहा है?', house.q2_7_7_tb_negative_contacts_treated, (value) {
                house.q2_7_7_tb_negative_contacts_treated = value;
                onChanged(house);
              }),
            ],
          ],
          const SizedBox(height: 12),
          _buildYesNoNA('Q2.8 क्या आशा द्वारा फाइलेरिया रोग (हाथी पाव) से बचाव हेतु परिवार को संदेश/जानकारी दी गई है? (फाइलेरिया प्रभावित जनपदों हेतु)', house.q2_8_filaria_info, (value) {
            house.q2_8_filaria_info = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.8.1 क्या आशा द्वारा कुष्ठ रोग के लक्षणों के ल बारे में जानकारी दी गई है?', house.q2_8_1_leprosy_symptoms_info, (value) {
            house.q2_8_1_leprosy_symptoms_info = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.8.2 क्या आशा के भ्रमण के दौरान कुष्ठ रोग का कोई संभावित रोगी चिन्हित हुआ था?', house.q2_8_2_leprosy_patient_identified, (value) {
            house.q2_8_2_leprosy_patient_identified = value;
            if (value != 'हाँ') house.q2_8_3_leprosy_referred = 'नहीं';
            onChanged(house);
          }),
          if (house.q2_8_2_leprosy_patient_identified == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNo('Q2.8.3 यदि हाँ, तो आशा को उस व्यक्ति को निकटतम स्वास्थ्य केंद्र पर जाँच कराने हेतु प्रेरित किया था?', house.q2_8_3_leprosy_referred, (value) {
              house.q2_8_3_leprosy_referred = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 12),
          _buildYesNo('Q2.9 क्या आशा ने आपको बताया कि कृन्तकों (चूहे/छछून्दर) से स्क्रब टाइफस नाम का रोग हो जाता है?', house.q2_9_scrub_typhus_info, (value) {
            house.q2_9_scrub_typhus_info = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildNumber('Q2.10.1 घर में रहने वाले व्यक्तियों की कुल संख्या', house.q2_10_1_total_family_members, (value) {
            house.q2_10_1_total_family_members = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildNumber('Q2.10.2 घर में पाए गए ILI केसेज़ की संख्या', house.q2_10_2_ili_cases_found, (value) {
            house.q2_10_2_ili_cases_found = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildNumber('Q2.10.3 भ्रमण के दौरान सूचीबद्ध नहीं किए गए ILI केसेज़ की संख्या', house.q2_10_3_ili_not_listed, (value) {
            house.q2_10_3_ili_not_listed = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q2.11 क्या क्षेत्र भ्रमण के दौरान मकानों पर आशा द्वारा लगाए गए स्टीकर चिपके पाए गए', house.q2_11_sticker_pasted, (value) {
            house.q2_11_sticker_pasted = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q2.12 क्या आशा ने हाथ धोने की प्रक्रिया घर के सदस्यों को समझायी', house.q2_12_handwash_demonstrated, (value) {
            house.q2_12_handwash_demonstrated = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q2.13 क्या आशा द्वारा परिवार के सदस्यों की आभा आई0डी0 बनाकर उपलब्ध करायी गयी', house.q2_13_abha_id_created, (value) {
            house.q2_13_abha_id_created = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildText('ASHA Name: आशा का नाम', house.ashaName, (value) {
            house.ashaName = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildText('ASHA Mobile: आशा का मोबाइल नंबर', house.ashaMobile, (value) {
            house.ashaMobile = value;
            onChanged(house);
          }, keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 3 — नगर विकास / ग्राम्य विकास / पंचायती राज', color: AppColors.sectionOrange),
          const SizedBox(height: 8),
          _buildYesNoNA('Q3.1 क्या गाँव / वार्ड / मुहल्ले में झाड़ियों की कटाई का कार्य किया गया है?', house.q3_1_bush_cutting, (value) {
            house.q3_1_bush_cutting = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q3.2 क्या गाँव / वार्ड / मुहल्ले में नालियों की सफाई का कार्य किया गया है?', house.q3_2_drain_cleaning, (value) {
            house.q3_2_drain_cleaning = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q3.3 क्या गाँव / वार्ड / मुहल्ले में जल भराव को हटाने का कार्य किया गया है?', house.q3_3_waterlogging_removed, (value) {
            house.q3_3_waterlogging_removed = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q3.4 क्या गाँव / वार्ड / मुहल्ले में अन्य किसी तरह का सफाई कार्य किया गया है?', house.q3_4_other_cleaning, (value) {
            house.q3_4_other_cleaning = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q3.5 क्या गाँव / वार्ड / मुहल्ले में कोई फॉगिंग की गई है?', house.q3_5_fogging_done, (value) {
            house.q3_5_fogging_done = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q3.6 क्या गाँव / वार्ड / मुहल्ले में किसी तरह की एन्टीलार्वा गतिविधि हुई है?', house.q3_6_anti_larval_activity, (value) {
            house.q3_6_anti_larval_activity = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 4 — शिक्षा विभाग', color: AppColors.sectionPurple),
          const SizedBox(height: 8),
          _buildYesNoNA('Q4.1 क्या स्कूल जाने वाले बच्चों को स्कूल के शिक्षक द्वारा मच्छर जनित / संचारी रोग से बचाव के विषय में जानकारी देते हुए रोगों के बारे में शिक्षित किया गया है?', house.q4_1_school_children_educated, (value) {
            house.q4_1_school_children_educated = value;
            if (value != 'नहीं') house.q4_2_school_name_address = '';
            onChanged(house);
          }),
          if (house.q4_1_school_children_educated == 'नहीं') ...[
            const SizedBox(height: 12),
            _buildText('Q4.2 यदि नहीं, तो स्कूल का नाम और पता लिखें', house.q4_2_school_name_address, (value) {
              house.q4_2_school_name_address = value;
              onChanged(house);
            }, maxLines: 3),
          ],
          const SizedBox(height: 12),
          _buildYesNo('Q4.3 क्या स्कूल जाने वाले बच्चों को स्कूल के शिक्षक द्वारा हीट वेव (लू) से बचाव हेतु शिक्षित किया गया है?', house.q4_3_heatwave_educated_school, (value) {
            house.q4_3_heatwave_educated_school = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 5 — स्वच्छ भारत मिशन', color: AppColors.sectionTeal),
          const SizedBox(height: 8),
          _buildYesNo('Q5.1 क्या इस घर में शौचालय है?', house.q5_1_toilet_available, (value) {
            house.q5_1_toilet_available = value;
            if (value != 'हाँ') house.q5_2_toilet_used_by_all = 'नहीं';
            onChanged(house);
          }),
          if (house.q5_1_toilet_available == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNoNA('Q5.2 यदि हाँ, तो क्या परिवार के सभी सदस्य इस शौचालय का उपयोग करते हैं?', house.q5_2_toilet_used_by_all, (value) {
              house.q5_2_toilet_used_by_all = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 6 — स्वच्छ जल', color: AppColors.sectionCyan),
          const SizedBox(height: 8),
          _buildRadio('Q6.1 परिवार के पेयजल का क्या स्रोत है?', house.q6_1_water_source, [
            'A - इंडिया मार्क II हैंड पंप (30 मीटर से अधिक गहराई)',
            'B - सप्लाई वाला पानी',
            'C - फिल्टर पानी',
            'D - टैंकर',
            'E - उथले हैंड पंप',
            'F - अन्य',
          ], (value) {
            house.q6_1_water_source = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q6.2 क्या परिवार को पीने के पानी के शुद्धिकरण का कम से कम एक तरीका पता है?', house.q6_2_water_purification_known, (value) {
            house.q6_2_water_purification_known = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 7 — आई0सी0डी0एस', color: AppColors.sectionPink),
          const SizedBox(height: 8),
          _buildYesNoNA('Q7.1 क्या अभियान के दौरान आंगनवाड़ी कार्यकत्री द्वारा घर का भ्रमण किया गया?', house.q7_1_anganwadi_visited, (value) {
            house.q7_1_anganwadi_visited = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q7.2 क्या कुपोषण से बचाव के लिए आंगनवाड़ी ने परिवार को सलाह दी थी?', house.q7_2_anganwadi_nutrition_advice, (value) {
            house.q7_2_anganwadi_nutrition_advice = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 8 — कृषि', color: AppColors.sectionBrown),
          const SizedBox(height: 8),
          _buildYesNoNA('Q8.1 क्या ग्रामीण क्षेत्र में समुदाय को कृन्तकों (चूहे/छछून्दर)/झाड़ियों से फैलने वाली बीमारियों से बचाव हेतु जानकारी साझा करने के लिए गोष्टी / बैठकें की गई?', house.q8_1_disease_prevention_meeting, (value) {
            house.q8_1_disease_prevention_meeting = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 9 — पशुपालन', color: AppColors.sectionAmber),
          const SizedBox(height: 8),
          _buildYesNo('Q9.1 क्या आप पशुपालन (सूकर पालक/पोल्री फार्म/हैचरी/डेयरी फार्म) करते हैं?', house.q9_1_animal_husbandry, (value) {
            house.q9_1_animal_husbandry = value;
            if (value != 'हाँ') {
              house.q9_2_veterinary_contact_info = 'नहीं';
              house.q9_3_animals_away_from_residential = 'नहीं';
            }
            onChanged(house);
          }),
          if (house.q9_1_animal_husbandry == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNoNA('Q9.2 यदि हाँ, तो क्या पशुपालन विभाग द्वारा आपको पशुजनित रोग होने की स्थिति में जांच कराए जाने हेतु उनसे संपर्क करने को बताया गया?', house.q9_2_veterinary_contact_info, (value) {
              house.q9_2_veterinary_contact_info = value;
              onChanged(house);
            }),
            const SizedBox(height: 12),
            _buildYesNoNA('Q9.3 क्या पशुपालन विभाग द्वारा आपके पशुओं को रिहायशी इलाकों से दूर रखने की सलाह दी गयी?', house.q9_3_animals_away_from_residential, (value) {
              house.q9_3_animals_away_from_residential = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 10 — पशुपालन गाँव की गतिविधियाँ', color: AppColors.sectionDeepOrange),
          const SizedBox(height: 8),
          _buildYesNo('Q10.1 क्या गाँव / वार्ड / मुहल्ले में कोई सूकर पालक/पोल्री फार्म/हैचरी/डेयरी फार्म है?', house.q10_1_farm_exists, (value) {
            house.q10_1_farm_exists = value;
            if (value != 'हाँ') house.q10_2_farm_sensitized = 'नहीं';
            onChanged(house);
          }),
          if (house.q10_1_farm_exists == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildYesNoNA('Q10.2 यदि हाँ, तो क्या उनका संवेदीकरण किया गया?', house.q10_2_farm_sensitized, (value) {
              house.q10_2_farm_sensitized = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 11 — मॉनीटरों का अवलोकन', color: AppColors.sectionIndigo),
          const SizedBox(height: 8),
          _buildYesNo('Q11.1 क्या संबंधित विभागों द्वारा मच्छर नियंत्रण हेतु आवश्यक रसायनों की पर्याप्त मात्रा में उपलब्धता सुनिश्चित कर ली गई?', house.q11_1_chemicals_available, (value) {
            house.q11_1_chemicals_available = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q11.2 क्या निरीक्षण के दौरान मॉनीटर द्वारा क्षेत्र में साफ सफाई की व्यवस्था सुचारु रूप से होना पाया गया?', house.q11_2_cleanliness_proper, (value) {
            house.q11_2_cleanliness_proper = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q11.3 क्या निरीक्षण के दौरान मॉनीटर द्वारा क्षेत्र में फाकिंग अथवा लार्वीसाइडल स्प्रे की गतिविधि होती हुयी पाई गयी?', house.q11_3_fogging_larval_spray, (value) {
            house.q11_3_fogging_larval_spray = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNoNA('Q11.4 क्या निरीक्षण के दौरान मॉनीटर द्वारा गांव / वार्ड / मोहल्ले में गर्मी (हीटवेव/लू) को देखते हुए शुद्ध पेयजल की अतिरिक्त व्यवस्था होना पाया गया?', house.q11_4_drinking_water_heatwave, (value) {
            house.q11_4_drinking_water_heatwave = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildRadio('Q11.5 क्या निरीक्षण के दौरान मॉनीटर द्वारा स्कूलों में बच्चों ने फुल आस्तीन की कमीज व फुलपैंट पहना पाया गया?', house.q11_5_school_full_sleeve, [
            'सभी छात्र पूरी आस्तीन की यूनिफॉर्म पहने पाए गए',
            'कोई भी छात्र पूरी आस्तीन की यूनिफार्म पहन नहीं पाया गया',
            'कुछ छात्र पूरी आस्तीन की यूनिफॉर्म व कुछ छात्र हाफ आस्तीन की यूनिफॉर्म पहने पाए गए',
          ], (value) {
            house.q11_5_school_full_sleeve = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 12 — डिजिटल गतिविधियाँ', color: AppColors.sectionBlueGrey),
          const SizedBox(height: 8),
          _buildRadio('Q12.1 आशा द्वारा बुखार क्षय रोग, कुष्ठ रोग, फाइलेरिया (हाथी पाव) तथा कुपोषण से संभावित रोगियों के पिछले दिन की सूची ई-कवच पोर्टल पर अंकित (एंट्री) की?', house.q12_1_e_kavach_entry, [
            'आशा नहीं मिली',
            'हाँ',
            'नहीं',
            'लागू नहीं',
          ], (value) {
            house.q12_1_e_kavach_entry = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildRadio('Q12.2 क्या क्षेत्रीय आशा, ANM अथवा CHO द्वारा विगत दिवस के लक्षण युक्त व्यक्तियों की लाइन लिस्ट E KAVACH पोर्टल पर अपलोड कर दी गयी है?', house.q12_2_line_list_uploaded, [
            'हाँ',
            'आशा द्वारा लिस्ट उपलब्ध नहीं करायी गई',
            'पोर्टल अपलोड करना नहीं आता है',
            'नेट कनेक्टिविटी नहीं है',
            'मोबाईल अथवा टैबलेट पर एप डाउनलोड नहीं है',
          ], (value) {
            house.q12_2_line_list_uploaded = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildYesNo('Q12.3 क्या क्षेत्रीय CHO तथा ANM को बीमारियों की नियमित रूप से UDSP पर एंट्री किये जाने के विषय में जानकारी है?', house.q12_3_udsp_entry_known, (value) {
            house.q12_3_udsp_entry_known = value;
            onChanged(house);
          }),
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 13 — जिला मलेरिया', color: AppColors.sectionRed),
          const SizedBox(height: 8),
          _buildRadio('Q13.1 क्या जिला मलेरिया अधिकारी कार्यालय पर जनपद के चिन्हित हाई वेक्टर घनत्व वाले गांव / वार्ड / क्षेत्रों की संकलित सूचना / सूची उपलब्ध है?', house.q13_1_high_vector_list_available, [
            'हाँ',
            'नहीं',
            'जिला मलेरिया कार्यालय की विजिट नहीं की गई',
          ], (value) {
            house.q13_1_high_vector_list_available = value;
            if (value != 'हाँ') house.q13_2_list_shared_departments = 'नहीं';
            onChanged(house);
          }),
          if (house.q13_1_high_vector_list_available == 'हाँ') ...[
            const SizedBox(height: 12),
            _buildRadio('Q13.2 यदि हाँ, तो क्या जिला मलेरिया अधिकारी कार्यालय द्वारा चिन्हित हाई वेक्टर घनत्व वाले गांव/वार्ड/क्षेत्रों की संकलित सूचना/सूची - नगर विकास विभाग, ग्राम विकास विभाग, पंचायती राज विभाग को आवश्यक निरोधात्मक कार्यवाहियों हेतु प्रेषित/उपलब्ध करायी गई है?', house.q13_2_list_shared_departments, [
              'हाँ',
              'नहीं',
              'जिला मलेरिया कार्यालय की विजिट नहीं की गई',
            ], (value) {
              house.q13_2_list_shared_departments = value;
              onChanged(house);
            }),
          ],
          const SizedBox(height: 16),
          SectionHeader(title: 'SECTION 14 — आउटब्रेक प्रबंधन', color: AppColors.sectionDarkRed),
          const SizedBox(height: 8),
          _buildYesNo('Q14.1 IDSP यूनिट को मोबिलिटी हेतु पृथक वाहन उपलब्ध कराया गया है?', house.q14_1_idsp_vehicle_available, (value) {
            house.q14_1_idsp_vehicle_available = value;
            onChanged(house);
          }),
          const SizedBox(height: 12),
          _buildText('Gram Vikas Adhikari Name: ग्राम विकास अधिकारी का नाम और पदनाम', house.gramVikasAdhikariName, (value) {
            house.gramVikasAdhikariName = value;
            onChanged(house);
          }),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildYesNo(String label, String value, ValueChanged<String> onChanged) {
    return YesNoField(label: label, value: value, onChanged: onChanged);
  }

  Widget _buildYesNoNA(String label, String value, ValueChanged<String> onChanged) {
    return YesNoNAField(label: label, value: value, onChanged: onChanged);
  }

  Widget _buildText(String label, String value, ValueChanged<String> onChanged, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextInputField(label: label, value: value, onChanged: onChanged, keyboardType: keyboardType, maxLines: maxLines);
  }

  Widget _buildNumber(String label, int value, ValueChanged<int> onChanged) {
    return TextInputField(
      label: label,
      value: value == 0 ? '' : value.toString(),
      keyboardType: TextInputType.number,
      onChanged: (text) {
        final parsed = int.tryParse(text) ?? 0;
        onChanged(parsed);
      },
    );
  }

  Widget _buildRadio(String label, String value, List<String> options, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final selected = option == value;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              onSelected: (_) => onChanged(option),
            );
          }).toList(),
        ),
      ],
    );
  }

  List<String> _splitCodes(String value) {
    return value.isEmpty ? [] : value.split(', ').where((element) => element.isNotEmpty).toList();
  }
}
