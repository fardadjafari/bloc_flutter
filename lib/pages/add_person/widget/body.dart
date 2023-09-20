import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/add_person/logic/bloc/add_user_bloc.dart';
import 'package:flutter_application_2/pages/home/logic/bloc/home_bloc.dart';
import 'package:flutter_application_2/text_form_fileds/text_form_field_name.dart';
import 'package:flutter_application_2/tools/media_query.dart';
import 'package:flutter_application_2/tools/popup/awesome_alert.dart';
import 'package:flutter_application_2/tools/popup/snack_bar_widget.dart';
import 'package:flutter_application_2/tools/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();

  final _formValidation = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _sexController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AddUserBloc, AddUSerState>(
        listener: (context, state) {
          if (state.addUserEvent is CompletedAddEvent) {
            Navigator.pop(context);
            getSnackBarWidget(context, "انجام شد", Colors.green);
          }
        },
        child: SingleChildScrollView(
          child: Form(
              key: _formValidation,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(context, 0.04)),
                child: Column(
                  children: [
                    SizedBox(height: getWidth(context, 0.05)),
                    TextFormFieldNameWidget(
                        maxLength: 100,
                        labelText: "نام",
                        icon: const Icon(Icons.text_decrease),
                        textInputAction: TextInputAction.next,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        controller: _nameController),
                    TextFormFieldNameWidget(
                        maxLength: 100,
                        labelText: " نام خانوادگی",
                        icon: const Icon(Icons.text_decrease_rounded),
                        textInputAction: TextInputAction.next,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        controller: _lastnameController),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(getAllWidth(context),
                                Responsive.isMobile(context) ? 45 : 75)),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!_formValidation.currentState!.validate()) {
                            alertDialogError(
                                context,
                                "اطلاعات خود را تکمیل کنید",
                                "اطلاعات خود را تکمیل کنید");
                          } else {
                            context.read<AddUserBloc>().add(AddRecordEvent(
                                firstname: _nameController.text,
                                lastname: _lastnameController.text,
                                sex: _sexController.text));

                            context.read<HomeBloc>().add(FetchDataHomeEvent());
                          }
                        },
                        child: const Text("ثبت وظیفه"))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
