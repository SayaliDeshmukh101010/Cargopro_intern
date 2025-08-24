import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cargopro_intern_app/services/firebase_auth_service.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  var isOtpSent = false.obs;
  var verificationId = ''.obs;
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() {
          if (isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return isOtpSent.value ? _buildOtpForm() : _buildPhoneForm();
        }),
      ),
    );
  }

  Widget _buildPhoneForm() {
    return Column(
      children: [
        TextFormField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            hintText: '+1234567890',
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await _sendOtp();
          },
          child: Text('Send OTP'),
        ),
      ],
    );
  }

  Widget _buildOtpForm() {
    return Column(
      children: [
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            labelText: 'OTP',
            hintText: 'Enter 6-digit code',
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await _verifyOtp();
          },
          child: Text('Verify OTP'),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            isOtpSent.value = false;
          },
          child: Text('Change Phone Number'),
        ),
      ],
    );
  }

  Future<void> _sendOtp() async {
    // Validate phone number
    final phoneNumber = phoneNumberController.text.trim();
    
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a phone number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    if (!phoneNumber.startsWith('+')) {
      Get.snackbar(
        'Error',
        'Phone number must start with +',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    // Remove non-digit characters for validation
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 10) {
      Get.snackbar(
        'Error',
        'Please enter a valid phone number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Send OTP using Firebase
      await _authService.sendOtp(phoneNumber);
      
      // If OTP is sent successfully
      isOtpSent.value = true;
      Get.snackbar(
        'Success',
        'OTP sent to $phoneNumber',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _verifyOtp() async {
    final otp = otpController.text.trim();
    
    if (otp.isEmpty || otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Verify OTP using Firebase
      // Note: You'll need to store the verificationId when sending OTP
      // For simplicity, I'm using a placeholder here
      await _authService.verifyOtp('verification_id_placeholder', otp);
      
      // If OTP is verified successfully
      Get.offAllNamed('/home');
      Get.snackbar(
        'Success',
        'Login successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'OTP verification failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    otpController.dispose();
    super.dispose();
  }
}