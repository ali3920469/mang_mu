import 'package:flutter/material.dart';
import 'package:mang_mu/screens/chat_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class EregesyerScreen extends StatefulWidget {
  static const String screenroot = 'Eregesyer_screen';

  const EregesyerScreen({super.key});

  @override
  State<EregesyerScreen> createState() => _EregesyerScreenState();
}

class _EregesyerScreenState extends State<EregesyerScreen> {
  File? _frontIdentityImage;
  File? _backIdentityImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  int _currentStep = 0;
  bool _isArabic = true;
  bool _isLoading = false;

  Future<void> _pickImage(bool isFront) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 90,
    );

    if (image != null) {
      setState(() {
        if (isFront) {
          _frontIdentityImage = File(image.path);
        } else {
          _backIdentityImage = File(image.path);
        }
      });
    }
  }

  void _removeImage(bool isFront) {
    setState(() {
      if (isFront) {
        _frontIdentityImage = null;
      } else {
        _backIdentityImage = null;
      }
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            _isArabic ? "تأكيد معلومات الموظف" : "Confirm Employee Info",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isArabic
                      ? "الرجاء مراجعة المعلومات قبل الإنشاء:"
                      : "Please review information before submission:",
                ),
                const SizedBox(height: 16),
                Text(
                  "${_isArabic ? "الاسم الرباعي" : "Full Name"}: ${_fullNameController.text}",
                ),
                const SizedBox(height: 8),
                Text(
                  "${_isArabic ? "رقم الهوية" : "ID Number"}: ${_idNumberController.text}",
                ),
                const SizedBox(height: 8),
                Text(
                  "${_isArabic ? "الحساب" : "Account"}: ${_accountController.text}",
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "${_isArabic ? "الرمز" : "Code"}: ${_codeController.text}",
                  ),
                ),
                const SizedBox(height: 16),
                if (_frontIdentityImage != null)
                  Text(
                    _isArabic
                        ? "تم تحميل صورة الهوية من الأمام"
                        : "Front ID image uploaded",
                  ),
                if (_backIdentityImage != null)
                  Text(
                    _isArabic
                        ? "تم تحميل صورة الهوية من الخلف"
                        : "Back ID image uploaded",
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(_isArabic ? "إلغاء" : "Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() => _isLoading = true);
                Navigator.pop(context);
                await Future.delayed(
                  const Duration(seconds: 1),
                ); // Simulate processing
                if (!mounted) return;
                Navigator.pushNamed(context, ChatScreen.screenroot);
              },
              child: Text(
                _isArabic ? "تأكيد وإنشاء الحساب" : "Confirm & Create Account",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(File? image, bool isFront) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            image: image != null
                ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                : null,
          ),
          child: image == null
              ? Icon(Icons.photo_camera, size: 50, color: Colors.grey[400])
              : null,
        ),
        if (image != null)
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeImage(isFront),
            ),
          ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(1, _currentStep >= 0),
        _buildStepLine(),
        _buildStepCircle(2, _currentStep >= 1),
        _buildStepLine(),
        _buildStepCircle(3, _currentStep >= 2),
        _buildStepLine(),
        _buildStepCircle(4, _currentStep >= 3),
      ],
    );
  }

  Widget _buildStepCircle(int step, bool isActive) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color.fromARGB(255, 166, 216, 48) : Colors.grey,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStepLine() {
    return Container(width: 50, height: 2, color: Colors.grey[300]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isArabic ? "إنشاء حساب موظف" : "Employee Registration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => setState(() => _isArabic = !_isArabic),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 120, child: Image.asset('images/lbb.jpg')),
                    const SizedBox(height: 30),
                    _buildStepIndicator(),
                    const SizedBox(height: 30),
                    if (_currentStep == 0) ...[
                      Text(
                        _isArabic
                            ? "المعلومات الشخصية"
                            : "Personal Information",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _fullNameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: _isArabic ? 'الاسم الرباعي' : 'Full Name',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 166, 216, 48),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 202, 56),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: _fullNameController.text.isNotEmpty
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _idNumberController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: _isArabic ? 'رقم الهوية' : 'ID Number',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 166, 216, 48),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 202, 56),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: _idNumberController.text.isNotEmpty
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_fullNameController.text.isEmpty ||
                              _idNumberController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _isArabic
                                      ? 'الرجاء إدخال الاسم الرباعي ورقم الهوية'
                                      : 'Please enter full name and ID number',
                                ),
                              ),
                            );
                          } else {
                            setState(() => _currentStep = 1);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            166,
                            216,
                            48,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(_isArabic ? 'التالي' : 'Next'),
                      ),
                    ] else if (_currentStep == 1) ...[
                      TextField(
                        controller: _accountController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: _isArabic
                              ? 'ادخل الحساب الخاص بك'
                              : 'Enter your account',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 166, 216, 48),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 202, 56),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: _accountController.text.isNotEmpty
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _codeController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: _isArabic
                                ? 'ادخل الرمز الخاص بك'
                                : 'Enter your code',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 166, 216, 48),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 202, 56),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            suffixIcon: _codeController.text.isNotEmpty
                                ? const Icon(Icons.check, color: Colors.green)
                                : null,
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => setState(() => _currentStep = 0),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(_isArabic ? 'السابق' : 'Back'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_accountController.text.isEmpty ||
                                    _codeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _isArabic
                                            ? 'الرجاء إدخال جميع البيانات المطلوبة'
                                            : 'Please fill all required fields',
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() => _currentStep = 2);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  166,
                                  216,
                                  48,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(_isArabic ? 'التالي' : 'Next'),
                            ),
                          ),
                        ],
                      ),
                    ] else if (_currentStep == 2) ...[
                      Text(
                        _isArabic ? 'صورة الهوية من الأمام' : 'Front ID Photo',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildImagePreview(_frontIdentityImage, true),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => _pickImage(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            166,
                            216,
                            48,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _isArabic
                              ? 'اختر صورة الهوية من الأمام'
                              : 'Select Front ID Photo',
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        _isArabic ? 'صورة الهوية من الخلف' : 'Back ID Photo',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildImagePreview(_backIdentityImage, false),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => _pickImage(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            166,
                            216,
                            48,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _isArabic
                              ? 'اختر صورة الهوية من الخلف'
                              : 'Select Back ID Photo',
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => setState(() => _currentStep = 1),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(_isArabic ? 'السابق' : 'Back'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_frontIdentityImage == null ||
                                    _backIdentityImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _isArabic
                                            ? 'الرجاء تحميل صور الهوية'
                                            : 'Please upload ID photos',
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() => _currentStep = 3);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  166,
                                  216,
                                  48,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(_isArabic ? 'التالي' : 'Next'),
                            ),
                          ),
                        ],
                      ),
                    ] else if (_currentStep == 3) ...[
                      Text(
                        _isArabic ? 'مراجعة المعلومات' : 'Review Information',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildInfoRow(
                        _isArabic ? 'الاسم الرباعي' : 'Full Name',
                        _fullNameController.text,
                      ),
                      const Divider(height: 30),
                      _buildInfoRow(
                        _isArabic ? 'رقم الهوية' : 'ID Number',
                        _idNumberController.text,
                      ),
                      const Divider(height: 30),
                      _buildInfoRow(
                        _isArabic ? 'الحساب' : 'Account',
                        _accountController.text,
                      ),
                      const Divider(height: 30),
                      _buildInfoRow(
                        _isArabic ? 'الرمز' : 'Code',
                        _codeController.text,
                      ),
                      const Divider(height: 30),
                      _buildInfoRow(
                        _isArabic ? 'صورة الهوية من الأمام' : 'Front ID Photo',
                        _frontIdentityImage != null
                            ? _isArabic
                                  ? 'تم التحميل'
                                  : 'Uploaded'
                            : _isArabic
                            ? 'غير محملة'
                            : 'Not uploaded',
                      ),
                      const SizedBox(height: 15),
                      _buildInfoRow(
                        _isArabic ? 'صورة الهوية من الخلف' : 'Back ID Photo',
                        _backIdentityImage != null
                            ? _isArabic
                                  ? 'تم التحميل'
                                  : 'Uploaded'
                            : _isArabic
                            ? 'غير محملة'
                            : 'Not uploaded',
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => setState(() => _currentStep = 2),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(_isArabic ? 'السابق' : 'Back'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _showConfirmationDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  166,
                                  216,
                                  48,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                _isArabic ? 'إنشاء الحساب' : 'Create Account',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
