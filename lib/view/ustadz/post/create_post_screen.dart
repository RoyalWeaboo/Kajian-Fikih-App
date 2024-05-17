// ignore_for_file: use_build_context_synchronously

import 'dart:io';

// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/category.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/constants/location.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/ustadz/dashboard/ustadz_dashboard_screen.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:kajian_fikih/viewmodel/post/post_state.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _postFormKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  final _startTimeTextController = TextEditingController();
  final _endTimeTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _youtubeLinkTextController = TextEditingController();
  final _locationAddressTextController = TextEditingController();
  final _locationUrlTextController = TextEditingController();
  final currentDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    super.initState();
    _dateTextController.text =
        DateFormat('dd MMMM yyyy', 'id').format(currentDate);
    _startTimeTextController.text = formatTime(TimeOfDay.now());
    _endTimeTextController.text = formatTime(TimeOfDay.now());
  }

  Future<void> _pickStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      _startTimeTextController.text = formatTime(pickedTime);
    }
  }

  Future<void> _pickEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      _endTimeTextController.text = formatTime(pickedTime);
    }
  }

  String formatTime(TimeOfDay time) {
    final formattedTime =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  Widget imagePreview(
    double width,
    double height,
  ) {
    if (file == null) {
      return Container(
        color: greyBackgroundColor,
        width: width,
        height: height * 0.3,
        child: Center(
          child: Image.asset(
            "assets/media_icon.png",
            width: 32,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    } else {
      return Image.file(
        File(file!.path),
        width: width,
        height: height * 0.3,
      );
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Post",
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: BlocListener<PostCubit, PostState>(
          listener: (BuildContext context, PostState state) {
            if (state is PostLoadingState) {
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
            if (state is PostErrorState) {
              Navigator.pop(context);
              AnimatedSnackBar.material(
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
              Navigator.pop(context);
            }
            if (state is CreatePostSuccessState) {
              Navigator.pop(context);
              AnimatedSnackBar.material(
                "Post berhasil di upload !",
                type: AnimatedSnackBarType.info,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);

              Navigator.pushReplacement(
                context,
                SlideLeftAnimation(
                  page: const UstadzDashboardScreen(),
                ),
              );
            }
            if (state is CreateOfflineEventSuccessState) {
              AnimatedSnackBar.material(
                "Jadwal Kajian berhasil ditambahkan !",
                type: AnimatedSnackBarType.info,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);

              Navigator.pushReplacement(
                context,
                SlideLeftAnimation(
                  page: const UstadzDashboardScreen(),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _postFormKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      uploadDialog(context);
                    },
                    child: imagePreview(width, height),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer<FormProvider>(
                    builder: (BuildContext context, FormProvider value,
                        Widget? child) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "online",
                                    groupValue: value.postType,
                                    onChanged: (String? val) {
                                      value.postType = val!;
                                    },
                                  ),
                                  Text(
                                    "Online",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "offline",
                                    groupValue: value.postType,
                                    onChanged: (String? val) {
                                      value.postType = val!;
                                    },
                                  ),
                                  Text(
                                    "Offline",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _titleTextController,
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
                              hintText: "Judul",
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
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                "Kategori : ",
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor,
                                ),
                              ),
                              SizedBox(
                                width: value.postType != "online" ? 44 : 8,
                              ),
                              Container(
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
                                      value: value.category,
                                      items: PostCategory.values.map((e) {
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
                                      onChanged: (PostCategory? category) {
                                        value.category = category!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          value.postType != "online"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lokasi Kajian : ",
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),
                                                child: DropdownButton(
                                                  value: value.location,
                                                  items:
                                                      Location.values.map((e) {
                                                    return DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e.name,
                                                        style:
                                                            GoogleFonts.outfit(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: blackColor,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Tanggal Kajian : ",
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            onTap: () async {
                                              final selectDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: currentDate,
                                                firstDate: DateTime(
                                                  currentDate.month,
                                                ),
                                                lastDate: DateTime(
                                                  currentDate.year + 2,
                                                ),
                                              );

                                              _dateTextController.text =
                                                  DateFormat(
                                                          "dd MMMM yyyy", "id")
                                                      .format(
                                                selectDate ?? currentDate,
                                              );
                                            },
                                            readOnly: true,
                                            controller: _dateTextController,
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            cursorColor: secondaryColor,
                                            decoration: InputDecoration(
                                              suffixIcon: const Icon(
                                                Icons.calendar_month,
                                              ),
                                              isDense: true,
                                              counterText: "",
                                              filled: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              fillColor: whiteColor,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Waktu Kajian : ",
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Flexible(
                                          child: TextFormField(
                                            controller:
                                                _startTimeTextController,
                                            onTap: () async {
                                              await _pickStartTime();
                                            },
                                            readOnly: true,
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                            cursorColor: secondaryColor,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              counterText: "",
                                              filled: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              fillColor: whiteColor,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "-",
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Flexible(
                                          child: TextFormField(
                                            controller: _endTimeTextController,
                                            onTap: () async {
                                              await _pickEndTime();
                                            },
                                            readOnly: true,
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                            cursorColor: secondaryColor,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              counterText: "",
                                              filled: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              fillColor: whiteColor,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    TextFormField(
                                      controller:
                                          _locationAddressTextController,
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
                                        hintText:
                                            "Alamat Lokasi Kajian Offline",
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
                                      maxLines: 1,
                                      maxLength: 255,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    TextFormField(
                                      controller: _locationUrlTextController,
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
                                        hintText:
                                            "URL Lokasi Google Maps (contoh : https://maps.app.goo.gl/)",
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
                                      maxLines: 1,
                                      maxLength: 255,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  height: 8,
                                ),
                          TextFormField(
                            controller: _descriptionTextController,
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
                              hintText: "Isi Postingan",
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
                            maxLines: 5,
                            maxLength: 255,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          value.postType == 'online'
                              ? TextFormField(
                                  controller: _youtubeLinkTextController,
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
                                    hintText: "Link Video Youtube (Opsional)",
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
                                  maxLines: 1,
                                  maxLength: 255,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomButton(
                            buttonText: "Posting",
                            backgroundColor: buttonBlueColor,
                            borderRadius: 10,
                            onPressed: () {
                              if (value.postType == "online") {
                                context.read<PostCubit>().createOnlinePost(
                                      _titleTextController.text,
                                      _descriptionTextController.text,
                                      value.category.toString().split('.').last,
                                      _youtubeLinkTextController.text,
                                      file,
                                    );
                              } else {
                                context.read<PostCubit>().createOfflinePost(
                                      _titleTextController.text,
                                      _descriptionTextController.text,
                                      file,
                                      _dateTextController.text,
                                      value.category.toString().split('.').last,
                                      _startTimeTextController.text,
                                      _endTimeTextController.text,
                                      value.location.toString().split('.').last,
                                      _locationAddressTextController.text,
                                      _locationUrlTextController.text,
                                    );
                              }
                            },
                            buttonTextColor: whiteColor,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
