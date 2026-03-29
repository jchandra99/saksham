import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import '../screens/house_form_screen.dart';
import '../widgets/section_header.dart';
import '../widgets/text_input_field.dart';
import '../constants/app_colors.dart';
import '../models/monitoring_form_model.dart';

class MonitoringFormScreen extends StatefulWidget {
  const MonitoringFormScreen({super.key});

  @override
  State<MonitoringFormScreen> createState() => _MonitoringFormScreenState();
}

class _MonitoringFormScreenState extends State<MonitoringFormScreen> {
  bool _loading = true;
  Timer? _autosaveTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeForm());
  }

  Future<void> _initializeForm() async {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final provider = context.read<FormProvider>();
    if (args != null && args['sessionId'] != null) {
      await provider.selectSession(args['sessionId'] as String);
    } else {
      await provider.createNewSession();
    }
    _autosaveTimer = Timer.periodic(const Duration(seconds: 30), (_) => provider.saveCurrentSession());
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final provider = context.read<FormProvider>();
    if (provider.selectedSession == null) return;
    provider.selectedSession!.formStatus = 'complete';
    await provider.saveCurrentSession();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Form saved successfully')));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormProvider>();
    final session = provider.selectedSession;
    final houses = provider.houses;

    if (_loading || session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('दस्तक मॉनीटरिंग'),
          actions: [
            IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
            IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: () async {
              await _saveForm();
              if (!mounted) return;
              Navigator.pushNamed(context, '/pdf', arguments: {'sessionId': session.id});
            }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  SectionHeader(title: 'फॉर्म हेडर', color: AppColors.primary),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Monitor Name - मॉनीटर का नाम', value: session.monitorName, onChanged: (value) { session.monitorName = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Designation - पद', value: session.designation, onChanged: (value) { session.designation = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Posting Place - नियुक्ति का स्थान', value: session.postingPlace, onChanged: (value) { session.postingPlace = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Mobile No - मोबाइल नं0', value: session.mobileNo, keyboardType: TextInputType.phone, onChanged: (value) { session.mobileNo = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'District - जनपद', value: session.district, onChanged: (value) { session.district = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  _buildDropdown('Institution - संस्था', session.institution, ['स्वास्थ्य विभाग', 'यूनीसेफ', 'पाथ', 'डब्ल्यूएचओ', 'अन्य विभाग'], (value) { session.institution = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  _buildDateField('Monitoring Date - मॉनीटरिंग का दिनांक', session.monitoringDate, (value) { session.monitoringDate = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  _buildTimeField('Monitoring Time - मॉनीटरिंग का समय', session.monitoringTime, (value) { session.monitoringTime = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  _buildYesNoRadio('Is High Risk Area', session.isHighRiskArea, (value) { session.isHighRiskArea = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Block Name - ब्लॉक का नाम', value: session.blockName, onChanged: (value) { session.blockName = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  _buildAreaType(session.areaType, (value) { session.areaType = value; setState(() {}); }),
                  const SizedBox(height: 12),
                  TextInputField(label: 'Village/Ward Name - नगरीय क्षेत्र / गाँव का नाम', value: session.villageWardName, onChanged: (value) { session.villageWardName = value; setState(() {}); }),
                  const SizedBox(height: 24),
                  TabBar(
                    isScrollable: true,
                    labelColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'घर-1'),
                      Tab(text: 'घर-2'),
                      Tab(text: 'घर-3'),
                      Tab(text: 'घर-4'),
                      Tab(text: 'घर-5'),
                    ],
                  ),
                  SizedBox(
                    height: 700,
                    child: TabBarView(
                      children: List.generate(5, (index) {
                        return HouseFormScreen(
                          house: houses[index],
                          onChanged: (house) {
                            provider.updateHouse(house);
                            setState(() {});
                          },
                          onCopyFromHouse1: index > 0 ? () {
                            provider.copyFromHouse1(index);
                            setState(() {});
                          } : null,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String currentValue, List<String> options, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400)),
          child: DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildYesNoRadio(String label, String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['हाँ', 'नहीं'].map((option) {
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

  Widget _buildAreaType(String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Area Type - शहरी / ग्रामीण', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['शहरी', 'ग्रामीण'].map((option) {
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

  Widget _buildDateField(String label, String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final initialDate = value.isNotEmpty ? DateTime.tryParse(value) ?? DateTime.now() : DateTime.now();
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: AppColors.primary)), child: child!),
            );
            if (selectedDate != null) {
              onChanged(DateFormat('yyyy-MM-dd').format(selectedDate));
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'YYYY-MM-DD'),
            child: Text(value.isEmpty ? 'Select date' : value),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final parts = value.split(':');
            final initialTime = (parts.length == 2)
                ? TimeOfDay(hour: int.tryParse(parts[0]) ?? 0, minute: int.tryParse(parts[1]) ?? 0)
                : TimeOfDay.now();
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: initialTime,
              builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: AppColors.primary)), child: child!),
            );
            if (selectedTime != null) {
              onChanged('${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}');
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'HH:MM'),
            child: Text(value.isEmpty ? 'Select time' : value),
          ),
        ),
      ],
    );
  }
}
