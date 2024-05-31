// import 'package:crud/bloc/bloc/firebase_user_bloc.dart';
// import 'package:crud/bloc/bloc/firebase_user_event.dart';
// import 'package:crud/bloc/bloc/firebase_user_state.dart';
// import 'package:crud/common/color_extension.dart';
// import 'package:crud/common_widget/RoundButton_Profile.dart';
// import 'package:crud/common_widget/round_textfield.dart';
// import 'package:crud/models/firebaseUser.dart';
// import 'package:crud/screens/Dashboard/dashboard.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CompleteProfileView extends StatefulWidget {
//   final String currentUserEmail;

//    CompleteProfileView(this.currentUserEmail, {super.key});

//   @override
//   State<CompleteProfileView> createState() => _CompleteProfileViewState();
// }

// class _CompleteProfileViewState extends State<CompleteProfileView> {
//   TextEditingController txtName = TextEditingController();
//   TextEditingController txtGender = TextEditingController();

//   TextEditingController txtWeight = TextEditingController();

//   TextEditingController txtHeight = TextEditingController();
//   final currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);

//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: TColor.white,
//       body: BlocBuilder<TodoBloc, TodoState>(
//         builder: (context, state) {
//           if (state is TodoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             // final todos = state.todos;
//             return SingleChildScrollView(
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         "assets/img/complete_profile.png",
//                         width: media.width,
//                         fit: BoxFit.fitWidth,
//                       ),
//                       SizedBox(
//                         height: media.width * 0.05,
//                       ),
//                       Text(
//                         "Let’s complete your profile",
//                         style: TextStyle(
//                             color: TColor.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700),
//                       ),
//                       Text(
//                         "It will help us to know more about you!",
//                         style: TextStyle(color: TColor.gray, fontSize: 12),
//                       ),
//                       SizedBox(
//                         height: media.width * 0.05,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: TColor.lightGray,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                       alignment: Alignment.center,
//                                       width: 50,
//                                       height: 50,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15),
//                                       child: Image.asset(
//                                         "assets/img/gender.png",
//                                         width: 20,
//                                         height: 20,
//                                         fit: BoxFit.contain,
//                                         color: TColor.gray,
//                                       )),
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         items: ["Male", "Female"]
//                                             .map((name) => DropdownMenuItem(
//                                                   value: name,
//                                                   child: Text(
//                                                     name,
//                                                     style: TextStyle(
//                                                         color: TColor.gray,
//                                                         fontSize: 14),
//                                                   ),
//                                                 ))
//                                             .toList(),
//                                         onChanged: (value) {},
//                                         isExpanded: true,
//                                         hint: Text(
//                                           "Choose Gender",
//                                           style: TextStyle(
//                                               color: TColor.gray, fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 8,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: media.width * 0.04,
//                             ),
//                             RoundTextField(
//                               controller: txtName,
//                               hitText: "Full Name",
//                               icon: "assets/img/date.png",
//                             ),
//                             SizedBox(
//                               height: media.width * 0.04,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: RoundTextField(
//                                     controller: txtWeight,
//                                     keyboardType: TextInputType.number,
//                                     hitText: "Your Weight",
//                                     icon: "assets/img/weight.png",
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Container(
//                                   width: 50,
//                                   height: 50,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: TColor.secondaryG,
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Text(
//                                     "KG",
//                                     style: TextStyle(
//                                         color: TColor.white, fontSize: 12),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: media.width * 0.04,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: RoundTextField(
//                                     keyboardType: TextInputType.number,
//                                     controller: txtHeight,
//                                     hitText: "Your Height",
//                                     icon: "assets/img/hight.png",
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Container(
//                                   width: 50,
//                                   height: 50,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: TColor.secondaryG,
//                                     ),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Text(
//                                     "CM",
//                                     style: TextStyle(
//                                         color: TColor.white, fontSize: 12),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: media.width * 0.07,
//                             ),
//                             RoundButton(
//                                 title: "Next >",
//                                 onPressed: () {
//                                   final todo = FirebaseUser(
//                                     id: widget.currentUserEmail,
//                                     Name: txtName.text,
//                                     Weight: txtWeight.text,
//                                     Height: txtHeight.text,
//                                   );

//                                   BlocProvider.of<TodoBloc>(context)
//                                       .add(AddTodo(todo));
//                                   Navigator.pop(context);
//                                 }),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:crud/bloc/bloc/firebase_user_bloc.dart';
import 'package:crud/bloc/bloc/firebase_user_event.dart';
import 'package:crud/bloc/bloc/firebase_user_state.dart';
import 'package:crud/common/color_extension.dart';
import 'package:crud/common_widget/RoundButton_Profile.dart';
import 'package:crud/common_widget/round_textfield.dart';
import 'package:crud/models/firebaseUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileView extends StatefulWidget {
  final String currentUserEmail;

  const CompleteProfileView(this.currentUserEmail, {super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);

    var media = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: TColor.white,
          body: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/img/complete_profile.png",
                              width: media.width,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            Text(
                              "Let’s complete your profile",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "It will help us to know more about you!",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 12),
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: TColor.lightGray,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Image.asset(
                                              "assets/img/gender.png",
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.contain,
                                              color: TColor.gray,
                                            )),
                                        Expanded(
                                          child:
                                              DropdownButtonFormField<String>(
                                            items: ["Male", "Female"]
                                                .map((name) => DropdownMenuItem(
                                                      value: name,
                                                      child: Text(
                                                        name,
                                                        style: TextStyle(
                                                            color: TColor.gray,
                                                            fontSize: 14),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              txtGender.text = value!;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Choose Gender",
                                              hintStyle: TextStyle(
                                                  // color: TColor.gray,
                                                  fontSize: 12),

                                              // contentPadding: EdgeInsets.symmetric(
                                              //     horizontal: 10),
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select your gender';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.04,
                                  ),
                                  RoundTextField(
                                    controller: txtName,
                                    hitText: "Full Name",
                                    icon: "assets/img/date.png",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: media.width * 0.04,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RoundTextField(
                                          controller: txtWeight,
                                          keyboardType: TextInputType.number,
                                          hitText: "Your Weight",
                                          icon: "assets/img/weight.png",
                                          // decoration: InputDecoration(
                                          //   hintText: "Your Weight",
                                          //   icon: Image.asset(
                                          //       "assets/img/weight.png"),
                                          //   border: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.circular(30.0),
                                          //   ),
                                          // ),
                                          // inputFormatters: [
                                          //   LengthLimitingTextInputFormatter(3),
                                          //   FilteringTextInputFormatter
                                          //       .digitsOnly,
                                          // ],

                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your weight';
                                            }
                                            if(value.length > 3){
                                              return 'Please enter a correct weight';

                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: TColor.secondaryG,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "KG",
                                          style: TextStyle(
                                              color: TColor.white,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.width * 0.04,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RoundTextField(
                                          keyboardType: TextInputType.number,
                                          controller: txtHeight,
                                          hitText: "Your Height",
                                          icon: "assets/img/hight.png",
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your height';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: TColor.secondaryG,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "CM",
                                          style: TextStyle(
                                              color: TColor.white,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.width * 0.07,
                                  ),
                                  RoundButton(
                                      title: "Next >",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          final todo = FirebaseUser(
                                            id: widget.currentUserEmail,
                                            Name: txtName.text,
                                            Weight: txtWeight.text,
                                            Height: txtHeight.text,
                                          );

                                          BlocProvider.of<TodoBloc>(context)
                                              .add(AddTodo(todo));
                                          Navigator.pop(context);
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
