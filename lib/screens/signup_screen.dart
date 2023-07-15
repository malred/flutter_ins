import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  // 释放资源
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResposiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea是一个用于处理屏幕边缘区域的小部件。
      // 它的作用是确保应用的内容不会被设备的状态栏、导航栏或者设备刘海等区域所覆盖。
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            // 主轴（这里指的是column)居中
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              // cicular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.OesLvyzDO6AvU_hYUAT4IAHaHa?pid=ImgDet&rs=1'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // text field input for username
              TextFieldInput(
                hinText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 24),
              // text field input for email
              TextFieldInput(
                hinText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 24),
              // text field input for pass
              TextFieldInput(
                textEditingController: _passwordController,
                hinText: 'Enter your password',
                isPass: true,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              // text field input for bio
              TextFieldInput(
                hinText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(height: 24),
              // button login
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          // 加载条
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Flexible(child: Container(), flex: 2),
              // transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an accout?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Log in.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
