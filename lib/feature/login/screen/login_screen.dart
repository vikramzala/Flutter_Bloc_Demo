import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/core/injection_container.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_event.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_state.dart';
import 'package:flutter_bloc_demo/feature/project/screen/project_list_page.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:provider/src/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  bool isEmail(String input) => GetUtils.isEmail(input);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => sl<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext ctx, state) async {
          if (state is Error) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is LoginSuccessfulState) {
            if (state.loginModel.status == true) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Login successfully done.'),
                backgroundColor: Colors.blue,
              ));
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ProjectListPage(state.loginModel.detail.staffid)));
              // Get.to(ProjectListPage(state.loginModel.detail.staffid));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Login failed.'),
                backgroundColor: Colors.blue,
              ));
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          // initialValue: 'vijay.limbani@metizsoft.com',
                          decoration: InputDecoration(
                            labelText: 'Enter Username',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter proper email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: passwordController,
                          // initialValue: 'Metizs0ft',
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter proper password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                            if (state is Loading) {
                              return SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return Builder(builder: (BuildContext ctx) {
                                return ElevatedButton(
                                    onPressed: () {
                                      if (_globalKey.currentState!.validate()) {
                                        if (isEmail(emailController.text) &&
                                            passwordController
                                                .text.isNotEmpty) {
                                          context.read<LoginBloc>().add(
                                              LoginCallEvent(
                                                  emailController.text,
                                                  passwordController.text));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Please Enter valid data'),
                                          backgroundColor: Colors.blue,
                                        ));
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: ButtonStyleButton.allOrNull(
                                          EdgeInsets.all(12)),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(fontSize: 22),
                                    ));
                              });
                            }
                          }),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
