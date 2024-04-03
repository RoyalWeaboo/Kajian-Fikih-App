import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/constants/location.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
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
  final _descriptionTextController = TextEditingController();
  final currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateTextController.text =
        DateFormat('dd MMMM yyyy', 'id').format(currentDate);
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
        child: SingleChildScrollView(
          child: Form(
            key: _postFormKey,
            child: Column(
              children: [
                InkWell(
                  child: Container(
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
                  ),
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
                        value.postType != "online"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _titleTextController,
                                    keyboardType: TextInputType.text,
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      color: primaryColor,
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
                                              value: value.location,
                                              items: Location.values.map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e.name,
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Flexible(
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
                                                DateFormat("dd MMMM yyyy", "id")
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
                            color: primaryColor,
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        CustomButton(
                          buttonText: "Posting",
                          backgroundColor: buttonBlueColor,
                          borderRadius: 10,
                          onPressed: () {
                            //upload
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
    );
  }
}
