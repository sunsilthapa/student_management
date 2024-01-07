import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_management_hive_api/core/common/provider/is_network_provider.dart';
import 'package:student_management_hive_api/core/common/snackbar/my_snackbar.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_hive_api/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/presentation/view_model/course_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _gap = const SizedBox(height: 8);

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Kiran');
  final _lnameController = TextEditingController(text: 'Rana');
  final _phoneController = TextEditingController(text: '9812345678');
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  bool isObscure = true;

  BatchEntity? selectedBatch;
  final List<CourseEntity> _lstCourseSelected = [];

  // Check for the camera permission
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);
        //ref.read(authViewModelProvider.notifier).uploadImage(_img!);
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final batchState = ref.watch(batchViewModelProvider);
    final courseState = ref.watch(courseViewModelProvider);
    final isConnected = ref.watch(connectivityStatusProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (isConnected == ConnectivityStatus.isDisconnected) {
      //   showSnackBar(
      //       message: 'No Internet Connection',
      //       context: context,
      //       color: Colors.red);
      // } else if (isConnected == ConnectivityStatus.isConnected) {
      //   showSnackBar(message: 'You are online', context: context);
      // }

      // if (ref.watch(authViewModelProvider).showMessage!) {
      //   showSnackBar(
      //       message: 'Student Registerd Successfully', context: context);
      //   ref.read(authViewModelProvider.notifier).resetMessage(false);
      // }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        // backgroundImage:
                        //     AssetImage('assets/images/profile.png'),
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                    ),
                  _gap,
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone No',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phoneNo';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  batchState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          hint: const Text('Select batch'),
                          items: batchState.batches
                              .map(
                                (batch) => DropdownMenuItem<BatchEntity>(
                                  value: batch,
                                  child: Text(batch.batchName),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedBatch = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Batch',
                          ),
                        ),
                  _gap,
                  courseState.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MultiSelectDialogField(
                          title: const Text('Select course(s)'),
                          items: courseState.courses
                              .map(
                                (course) => MultiSelectItem(
                                  course,
                                  course.courseName,
                                ),
                              )
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text('Select course(s)'),
                          buttonIcon: const Icon(Icons.search),
                          onConfirm: (values) {
                            _lstCourseSelected.clear();
                            _lstCourseSelected.addAll(values);
                          },
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select courses';
                            }
                            return null;
                          }),
                        ),
                  _gap,
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // if (_key.currentState!.validate()) {
                        //   final entity = AuthEntity(
                        //     fname: _fnameController.text,
                        //     lname: _lnameController.text,
                        //     phone: _phoneController.text,
                        //     batch: selectedBatch!,
                        //     courses: _lstCourseSelected,
                        //     username: _usernameController.text,s
                        //     password: _passwordController.text,
                        //   );
                        //   // Register user
                        //   ref
                        //       .read(authViewModelProvider.notifier)
                        //       .registerStudent(entity);
                        // }
                      },
                      child: const Text('Register'),
                    ),
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