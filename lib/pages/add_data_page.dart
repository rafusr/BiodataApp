import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:tog_technical_test/entity/data.dart';
import 'package:tog_technical_test/provider/db_provider.dart';
import 'package:tog_technical_test/util.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  late Timer _timer;
  int _start = 60;
  late bool _isButtonDisabled;
  DateTime selectedDate = DateTime(2022, 1, 1);
  late String imageFile;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _birthdayDateController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nama",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: "Tinggi", suffixText: "cm"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: "Berat", suffixText: "kg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _birthdayDateController,
                            decoration: InputDecoration(
                                labelText: "Tanggal Lahir",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                )),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: _photoController,
                              decoration: InputDecoration(
                                  labelText: "Foto",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.image),
                                    onPressed: () {
                                      _getImage();
                                    },
                                  )),
                              onTap: () {
                                _getImage();
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: _isButtonDisabled == true
                    ? null
                    : () async {
                        final data = Data(
                            nama: _nameController.text,
                            alamat: _addressController.text,
                            tanggalLahir: _birthdayDateController.text,
                            tinggi: _heightController.text,
                            berat: _weightController.text,
                            foto: imageFile);
                        Provider.of<DbProvider>(context, listen: false)
                            .addData(data);
                        Navigator.pop(context);
                      },
                child: _isButtonDisabled == true
                    ? const Text("Disabled")
                    : const Text("Submit"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _start.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022),
        helpText: "Select Birdthday Date",
        initialDatePickerMode: DatePickerMode.year);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _birthdayDateController.text =
            "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _getImage() async {
    XFile? pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));

    if (pickedFile != null) {
      setState(() async {
        imageFile = Utility.base64String(await pickedFile.readAsBytes());
        _photoController.text = basename(pickedFile.path);
      });
    }
  }

  void startTimer() {
    setState(() {
      _isButtonDisabled = false;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _isButtonDisabled = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _birthdayDateController.dispose();
    _photoController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
