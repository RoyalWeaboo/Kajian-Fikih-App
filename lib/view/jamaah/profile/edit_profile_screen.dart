import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/constants/location.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _editProfileFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();

  void _handlePasswordVisibilityToggle() {
    context.read<FormProvider>().changePasswordVisibility();
  }

  void _handleConfirmPasswordVisibilityToggle() {
    context.read<FormProvider>().changeConfirmPasswordVisibility();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profil",
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: blackColor,
          ),
        ),
      ),
      body: Container(
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        width: width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<FormProvider>(
                    builder: (BuildContext context, FormProvider value,
                        Widget? child) {
                      return Form(
                        key: _editProfileFormKey,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //file picker here
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 22,
                                    child: Image.asset(
                                      "assets/profile_image_placeholder.jpg",
                                      width: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/profile_decoration.png",
                                    width: 130,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _nameTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: ((value) => validateFullname(value!)),
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                hintText: "Nama",
                                labelStyle: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: ((value) => validateEmail(value!)),
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                hintText: "Email",
                                labelStyle: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        8,
                                      ),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: DropdownButton(
                                      value: value.location,
                                      items: Location.values.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.name,
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: blackColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (Location? loc) {
                                        value.location = loc!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<FormProvider>(
                              builder: (BuildContext context,
                                  FormProvider value, Widget? child) {
                                return TextFormField(
                                  controller: _passTextController,
                                  obscureText: value.isHidden,
                                  validator: ((value) =>
                                      validatePassword(value!)),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorColor: secondaryColor,
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: _handlePasswordVisibilityToggle,
                                      child: Icon(
                                        size: 20,
                                        value.isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: "",
                                    hintText: "Password",
                                    labelStyle: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: whiteColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(width: 1),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<FormProvider>(
                              builder: (BuildContext context,
                                  FormProvider value, Widget? child) {
                                return TextFormField(
                                  controller: _confirmPassTextController,
                                  obscureText: value.isConfirmHidden,
                                  validator: ((value) =>
                                      validateConfirmPassword(
                                        value!,
                                        _passTextController.text,
                                      )),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorColor: secondaryColor,
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap:
                                          _handleConfirmPasswordVisibilityToggle,
                                      child: Icon(
                                        size: 20,
                                        value.isConfirmHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: "",
                                    hintText: "Konfirmasi Password",
                                    labelStyle: GoogleFonts.outfit(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: whiteColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(width: 1),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: width - 32,
                child: CustomButton(
                  buttonText: "Update",
                  backgroundColor: buttonBlueColor,
                  borderRadius: 10,
                  onPressed: () {
                    //send request
                  },
                  buttonTextColor: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
