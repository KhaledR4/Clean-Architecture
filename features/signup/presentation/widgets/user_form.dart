import 'package:fitness/core/validation/inputValidation.dart';
import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/features/signup/presentation/controllers/signup_controller.dart';
import 'package:fitness/widgets/common/loading/cirular_loading.dart';
import 'package:fitness/widgets/datePicker.dart';
import 'package:fitness/widgets/styles/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final SignupController signupController = sl<SignupController>();
  final SignupPageController pageController = sl<SignupPageController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: signupController.userFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',
                      style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                            controller: signupController.firstNameController,
                            decoration: const InputDecoration(labelText: 'First'),
                            validator: (value) {
                              return checkNull(signupController.firstNameController);
                            },
                          ),
                          ),
              
                          const SizedBox(width: 10,),
                
                          Expanded(
                            child: TextFormField(
                            controller: signupController.lastNameController,
                            decoration: const InputDecoration(labelText: 'Last'),
                            validator: (value) {
                              return checkNull(signupController.lastNameController);
                            },
                          ),
                          ),

                          const SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender',
                      style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10,),
                      Obx(() => DropdownButtonFormField(
                        value: signupController.gender.value,
                        items: signupController.genderChoices.map((choice) => 
                          DropdownMenuItem(
                            value: choice,
                            child: Text(choice),
                            )
                          ).toList(),
                        onChanged: (value){
                          signupController.gender.value = value!;
                        }),
                    ),
                  ]
                  ,),
              ),

            ],
          ),

          const SizedBox(height: 20,),
          
          Text('Birthday',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 10,),
          DatePicker(day: signupController.day, month: signupController.month, year: signupController.year),

          const SizedBox(height: 20,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: pageController.goToInitialForm,
                  style: secondaryButtonStyle,
                  child: const Text('Back')
                  )
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: 
                  Obx(() => ElevatedButton(
                      onPressed: signupController.submitForm,
                      child: pageController.loading.value ? loadingWidget(): 
                const Text('Submit')
                    ),
                  )
                ),
            ],
          )


        ],
      )
    );
  }
}