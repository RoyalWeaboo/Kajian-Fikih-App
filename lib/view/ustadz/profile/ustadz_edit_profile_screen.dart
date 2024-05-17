// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/constants/location.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/view/ustadz/profile/ustadz_profile_screen.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_state.dart';
import 'package:provider/provider.dart';

class UstadzEditProfileScreen extends StatefulWidget {
  final UserDetail userDetail;
  const UstadzEditProfileScreen({
    super.key,
    required this.userDetail,
  });

  @override
  State<UstadzEditProfileScreen> createState() =>
      _UstadzEditProfileScreenState();
}

class _UstadzEditProfileScreenState extends State<UstadzEditProfileScreen> {
  final _editProfileFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  // final _passTextController = TextEditingController();
  // final _confirmPassTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  var location = Location.Semarang;
  ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    super.initState();
    _nameTextController.text = widget.userDetail.username;
    _emailTextController.text = widget.userDetail.email;
    _phoneTextController.text = widget.userDetail.phone;
    _descriptionTextController.text = widget.userDetail.description ?? "";

    switch (widget.userDetail.location) {
      case "Semarang":
        location = Location.Semarang;
        break;
      case "Purwokerto":
        location = Location.Purwokerto;
        break;
      case "Solo":
        location = Location.Solo;
        break;
      case "Demak":
        location = Location.Demak;
        break;
      case "Jepara":
        location = Location.Jepara;
        break;
      case "Pekalongan":
        location = Location.Pekalongan;
        break;

      default:
        location = Location.Semarang;
        break;
    }
    context.read<FormProvider>().location = location;
  }

  // void _handlePasswordVisibilityToggle() {
  //   context.read<FormProvider>().changePasswordVisibility();
  // }

  // void _handleConfirmPasswordVisibilityToggle() {
  //   context.read<FormProvider>().changeConfirmPasswordVisibility();
  // }

  Widget imagePreview(
    double width,
    double height,
  ) {
    if (widget.userDetail.profilePictureUrl != "") {
      return Positioned(
        top: 22,
        child: SizedBox(
          height: height,
          width: width,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.userDetail.profilePictureUrl,
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else {
      if (file == null) {
        return Positioned(
          top: 22,
          child: SizedBox(
            height: height,
            width: width,
            child: CircleAvatar(
              child: Image.asset(
                "assets/profile_image_placeholder.jpg",
              ),
            ),
          ),
        );
      } else {
        return Positioned(
          top: 22,
          child: SizedBox(
            height: height,
            width: width,
            child: CircleAvatar(
              backgroundImage: FileImage(
                File(file!.path),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      }
    }
  }

  Future<dynamic> uploadDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilih sumber '),
            actions: [
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    file = upload;
                  });
                  Navigator.pop(context);
                },
                child: const Icon(Icons.camera_alt),
              ),
              TextButton(
                onPressed: () async {
                  XFile? upload =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    file = upload;
                  });

                  Navigator.pop(context);
                },
                child: const Icon(Icons.photo_library),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
      body: BlocListener<ProfileUstadzCubit, ProfileUstadzState>(
        listener: (BuildContext context, ProfileUstadzState state) {
          if (state is ProfileUstadzLoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Dialog(
                  insetPadding: EdgeInsets.all(12),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          if (state is ProfileUstadzErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is ProfileUstadzUpdateSuccessState) {
            Navigator.push(
              context,
              SlideLeftAnimation(
                page: const UstadzProfileScreen(
                  isUstadz: true,
                ),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          width: width,
          height: height,
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
                                  uploadDialog(context);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    imagePreview(100, 100),
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
                                keyboardType: TextInputType.text,
                                validator: ((value) => validateInput(value!)),
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
                                enabled: false,
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
                              TextFormField(
                                controller: _phoneTextController,
                                validator: ((value) =>
                                    validatePhoneNumber(value!)),
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                cursorColor: secondaryColor,
                                decoration: InputDecoration(
                                  isDense: true,
                                  counterText: "",
                                  hintText: "Nomor Telepon",
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
                              // Consumer<FormProvider>(
                              //   builder: (BuildContext context,
                              //       FormProvider value, Widget? child) {
                              //     return TextFormField(
                              //       controller: _passTextController,
                              //       obscureText: value.isHidden,
                              //       validator: ((value) =>
                              //           validatePassword(value!)),
                              //       keyboardType: TextInputType.text,
                              //       textInputAction: TextInputAction.next,
                              //       style: GoogleFonts.outfit(
                              //         fontSize: 14,
                              //         color: primaryColor,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       cursorColor: secondaryColor,
                              //       decoration: InputDecoration(
                              //         suffixIcon: InkWell(
                              //           onTap: _handlePasswordVisibilityToggle,
                              //           child: Icon(
                              //             size: 20,
                              //             value.isHidden
                              //                 ? Icons.visibility
                              //                 : Icons.visibility_off,
                              //           ),
                              //         ),
                              //         isDense: true,
                              //         counterText: "",
                              //         hintText: "Password",
                              //         labelStyle: GoogleFonts.outfit(
                              //             fontSize: 14,
                              //             color: primaryColor,
                              //             fontWeight: FontWeight.w400),
                              //         filled: true,
                              //         floatingLabelBehavior:
                              //             FloatingLabelBehavior.never,
                              //         fillColor: whiteColor,
                              //         border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(8),
                              //           borderSide: const BorderSide(width: 1),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Consumer<FormProvider>(
                              //   builder: (BuildContext context,
                              //       FormProvider value, Widget? child) {
                              //     return TextFormField(
                              //       controller: _confirmPassTextController,
                              //       obscureText: value.isConfirmHidden,
                              //       validator: ((value) =>
                              //           validateConfirmPassword(
                              //             value!,
                              //             _passTextController.text,
                              //           )),
                              //       keyboardType: TextInputType.text,
                              //       textInputAction: TextInputAction.next,
                              //       style: GoogleFonts.outfit(
                              //         fontSize: 14,
                              //         color: primaryColor,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       cursorColor: secondaryColor,
                              //       decoration: InputDecoration(
                              //         suffixIcon: InkWell(
                              //           onTap:
                              //               _handleConfirmPasswordVisibilityToggle,
                              //           child: Icon(
                              //             size: 20,
                              //             value.isConfirmHidden
                              //                 ? Icons.visibility
                              //                 : Icons.visibility_off,
                              //           ),
                              //         ),
                              //         isDense: true,
                              //         counterText: "",
                              //         hintText: "Konfirmasi Password",
                              //         labelStyle: GoogleFonts.outfit(
                              //             fontSize: 14,
                              //             color: primaryColor,
                              //             fontWeight: FontWeight.w400),
                              //         filled: true,
                              //         floatingLabelBehavior:
                              //             FloatingLabelBehavior.never,
                              //         fillColor: whiteColor,
                              //         border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(8),
                              //           borderSide: const BorderSide(width: 1),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              TextFormField(
                                controller: _descriptionTextController,
                                validator: ((value) => validateInput(
                                      value!,
                                    )),
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                cursorColor: secondaryColor,
                                decoration: InputDecoration(
                                  isDense: true,
                                  counterText: "",
                                  hintText: "Deskripsi",
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
                                maxLength: 255,
                                maxLines: 5,
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
                  child: Consumer<FormProvider>(
                    builder: (BuildContext context, FormProvider value,
                        Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBlueColor,
                            surfaceTintColor: buttonBlueColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            {
                              if (_editProfileFormKey.currentState!
                                  .validate()) {
                                if (file != null) {
                                  context
                                      .read<ProfileUstadzCubit>()
                                      .updateProfileDetail(
                                        _nameTextController.text,
                                        _emailTextController.text,
                                        _phoneTextController.text,
                                        value.location
                                            .toString()
                                            .split('.')
                                            .last,
                                        _descriptionTextController.text,
                                        widget.userDetail.profilePictureUrl,
                                        file,
                                      );
                                } else {
                                  context
                                      .read<ProfileUstadzCubit>()
                                      .updateProfileDetail(
                                        _nameTextController.text,
                                        _emailTextController.text,
                                        _phoneTextController.text,
                                        value.location
                                            .toString()
                                            .split('.')
                                            .last,
                                        _descriptionTextController.text,
                                        widget.userDetail.profilePictureUrl,
                                        null,
                                      );
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              "Update",
                              style: GoogleFonts.outfit(
                                color: whiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                      // return CustomButton(
                      //   buttonText: "Update",
                      //   backgroundColor: buttonBlueColor,
                      //   borderRadius: 10,
                      //   onPressed: () async {
                      //     if (_editProfileFormKey.currentState!.validate()) {
                      //       if (file != null) {
                      //         await context
                      //             .read<ProfileUstadzCubit>()
                      //             .updateProfileDetail(
                      //               _nameTextController.text,
                      //               _emailTextController.text,
                      //               _phoneTextController.text,
                      //               value.location.toString().split('.').last,
                      //               _descriptionTextController.text,
                      //               widget.userDetail.profilePictureUrl,
                      //               file,
                      //             );
                      //       } else {
                      //         await context
                      //             .read<ProfileUstadzCubit>()
                      //             .updateProfileDetail(
                      //               _nameTextController.text,
                      //               _emailTextController.text,
                      //               _phoneTextController.text,
                      //               value.location.toString().split('.').last,
                      //               _descriptionTextController.text,
                      //               widget.userDetail.profilePictureUrl,
                      //               null,
                      //             );
                      //       }
                      //     }
                      //   },
                      //   buttonTextColor: whiteColor,
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
