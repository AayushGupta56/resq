import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:resq/auth/home_page.dart';
import 'package:resq/auth/register/step1.dart';
import 'package:resq/auth/register/step2.dart';
import 'package:resq/auth/register/step3.dart';
import 'package:resq/services/auth_services.dart';
import 'package:resq/shared_prefrences/helper_function.dart';
import 'package:resq/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resq/provider_code.dart';

void main() {
  runApp(RegisterPage());
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int activeStep = 0; // Initial step set to 0.
  int upperBound = 2; // upperBound should be 2 for 3 steps (0, 1, 2).
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  register() async {
    final provider = Provider.of<MyProviderData>(context, listen: false);

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
        provider.AgencynameCont.text,
        provider.EmailaddressCont.text,
        provider.PasswordCont.text,
        context,
      )
          .then((value) async {
        if (value == true) {
          //save shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(provider.EmailaddressCont.text);
          await HelperFunctions.saveUserNameSF(provider.NameCont.text);
         print('build');
          nextScreenReplace(context,  HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('IconStepper Example'),
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconStepper(
                  icons: [
                    Icon(Icons.supervised_user_circle),
                    Icon(Icons.flag),
                    Icon(Icons.location_on),
                  ],
                  activeStep: activeStep,
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                header(),
                Expanded(
                  child: getContent(activeStep),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (activeStep > 0) previousButton(),
                    if (activeStep < upperBound) nextButton(),
                    if (activeStep == 2)
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            register();
                          }
                        },
                        child: Text('register'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Modify this function to return content for each step.
  Widget getContent(int step) {
    switch (step) {
      case 0:
        return SingleChildScrollView(
          child: Step1Page(
            formKey: formKey,
          ),
        );
      case 1:
        return SingleChildScrollView(
          child: Step2Page(
            formKey: formKey,
          ),
        ); // Display step1.dart content
      case 2:
        return SingleChildScrollView(
          child: Step3Page(
            formKey: formKey,
          ),
        );
      // Add similar cases for other steps (Step2Page, Step3Page) if needed.

      default:
        return SizedBox.shrink(); // Return an empty widget by default
    }
  }

  Widget nextButton() {
    final provider = Provider.of<MyProviderData>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        // Validate the form before proceeding to the next step
        if (formKey.currentState!.validate()) {
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          } else {
            // Check if the step is 3 or the index is 2
            if (activeStep == 2) {
              // save third step data to the provider
              // Execute the function when step is 3 or index is 2
              postDataToServer();
            }
          }
        }
      },
      child: Text('Next'),
    );
  }

// ...

// Add this function to perform the data posting to the server.
  void postDataToServer() {
    // Your code to send data to the server goes here.
    print('Data posted to server');
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Agency Information';

      case 1:
        return 'Available Resources';

      case 2:
        return 'Working Location';

      default:
        return 'Introduction';
    }
  }
}
