import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telNumberController = TextEditingController();
  TextEditingController _serviceCategoryController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.toString(); // format the date as per requirement
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null)
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.toString(); // format the time as  requirement
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telNumberController,
                decoration: InputDecoration(labelText: 'Tel Number'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter telephone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _serviceCategoryController,
                decoration: InputDecoration(labelText: 'Service Category'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter service category';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      decoration: InputDecoration(labelText: 'Date'),
                      onTap: () {
                        _selectDate(context);
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: _timeController,
                      decoration: InputDecoration(labelText: 'Time'),
                      onTap: () {
                        _selectTime(context);
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save data to Firestore
                    saveDataToFirestore();
                  }
                },
                child: Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Clear form fields
                  _formKey.currentState?.reset();
                  _selectedDate = DateTime.now();
                  _selectedTime = TimeOfDay.now();
                },
                child: Text('Clear'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveDataToFirestore() {
    // Get data from controllers
    String name = _nameController.text;
    String telNumber = _telNumberController.text;
    String serviceCategory = _serviceCategoryController.text;
    String date = _dateController.text;
    String time = _timeController.text;
    String location = _locationController.text;

    // Add Firestore logic here to save the data
    // For example:
    FirebaseFirestore.instance.collection('bookings').add({
      'name': name,
      'telNumber': telNumber,
      'serviceCategory': serviceCategory,
      'date': date,
      'time': time,
      'location': location,
    }).then((value) {
      // Data saved successfully
      // Show a notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thank you! Your booking has been submitted.'),
        ),
      );

      // Clear form fields
      _nameController.clear();
      _telNumberController.clear();
      _serviceCategoryController.clear();
      _dateController.clear();
      _timeController.clear();
      _locationController.clear();
    }).catchError((error) {
      // Handle errors here
      print('Failed to save data: $error');
    });
  }
}
