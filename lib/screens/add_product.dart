import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/retry.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_store/components/category_dropDown.dart';
import 'package:online_shopping_store/components/category_selector.dart';
import 'package:online_shopping_store/components/dialogbox.dart';
import 'package:online_shopping_store/components/login_input_fields.dart';
import 'package:online_shopping_store/components/response_handler.dart';
import 'package:online_shopping_store/data/model_data.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_store/global_content.dart';
import 'package:online_shopping_store/models/category.dart';
import 'package:online_shopping_store/models/product.dart';
import 'package:online_shopping_store/screens/test.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String dropdownValue = "category";
  List<File>? image2 = [];
  List<XFile> imagesFileList = [];
  List<int> list = [1, 2, 3, 4, 5];
  List<String> imageUrls = [];
  List<String> imagekeys = [];
  Category? _selectedItem;
  int currentStep = 0;

  Future<void> _uploadImages() async {
    final client = RetryClient(http.Client());
    for (var pickedImage in imagesFileList) {
      var image = File(pickedImage.path);
      print(pickedImage.path);
      // print(pickedImage.readAsBytes());
      // String fileType = imagesFileList[0].path.split('.').last;
      String fileType = pickedImage.path.split('.').last;

      // final response = await http.get(Uri.parse('$uri/api/products/getUrl'));
      final queryParameters = {
        "extension": fileType,
      };
      var response = await client.get(
        Uri.http(uri, '/api/products/getUrl', queryParameters),
      );
      // print(jsonDecode(response.body)['url']);
      // final jsonDecodeBody = jsonDecode(response.body);

      print("response.statusCode : ${response.statusCode}");

      final url = jsonDecode(response.body)['url'];
      final imageKey = jsonDecode(response.body)['imagekey'];
      setState(() {
        imagekeys.add(imageKey);
      });

      print("image keys :  $imagekeys");
      // final url = jsonDecodeBody['url'];

      print("url : $url");
      //here's how get the url for use  upload image

      if (url != null && url.isNotEmpty) {
        // final response1 = await http.put(
        //   Uri.parse(url),
        //   headers: {"Content-Type": "image/jpg"},
        //   body: await imagesFileList[0].readAsBytes(),
        // );
        // var response1 = await client.put(
        //   Uri.http(uri, url),
        final response1 = await http.put(
          Uri.parse(url),
          body: await pickedImage.readAsBytes(),
          // headers: {"Content-Type": "image/jpg"},
          headers: {"Content-Type": "image/${fileType}"},
        );
        print("response1.statusCode : ${response1.statusCode}");
        // print("response1 : ${jsonDecode(response.body)}");
        // var req = http.MultipartRequest('PUT', Uri.parse(url));
        // req.files.add(http.MultipartFile.fromBytes(
        //   'file',
        //   await imagesFileList[0].readAsBytes(),
        // ));
        // var res = await req.send();
        // var response1 = await http.Response.fromStream(res);
        // print('UPLOAD: ${res.statusCode}');
        // print(response1);

        // print(jsonDecode(response1.body).toString());
        // if (response1.statusCode == 200) {
        //   print("Uploaded successfully ");
        // } else {
        //   print(response1);
        // }

        if (response1.statusCode == 200) {
          //this only adds successfull upload image urls
          var imageUrl = url.split('?')[0];
          print("imageUrl ");
          print(imageUrl);
          setState(() {
            imageUrls.add(imageUrl);
          });
        }

        print("imagelistlength : ${imagesFileList.length}");
        print("hey");
      }

      //   }
      //   // if (url) {
      //   //   final response1 =
      //   //       await http.post(url, body: imagesFileList[0].readAsBytes());
      //   // }
    }
  }

  Future<void> getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedimages = await picker.pickMultiImage();
      print("pickedimages");
      print(pickedimages);
      if (
          // pickedimages == null ||
          pickedimages.isEmpty) {
        return;
      }

      if (pickedimages.isNotEmpty) {
        // imagesFileList.addAll(pickedimages);
        setState(() {
          imagesFileList = pickedimages;
        });
        for (var pickedImage in imagesFileList) {
          print("pickedImage.path : ${pickedImage.path}");
          // print(pickedImage.readAsBytes());
        }
      }
      // final imageTemp = File(pickedimages.path);
      // print(imageTemp);
      // print("image files :" + imagesFileList.toString());
      // if (pickedimages != null) {}
      setState(() {
        // image2 = imagesFileList;
        // imagesFileList =
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _addProduct() async {
    try {
      await _uploadImages();
      if (imageUrls.isNotEmpty ||
          imageUrls.length == imagesFileList.length ||
          _selectedItem != null ||
          titleController.text.isEmpty ||
          quantityController.text.isEmpty ||
          priceController.text.isEmpty) {
        dialogBox(context, "Flllout all the fields", "alt", "Go back");
      }
      if (imageUrls.isNotEmpty &&
          imageUrls.length == imagesFileList.length &&
          _selectedItem != null) {
        //here we check all whether all images have been uploaded
        print("not empty");
        print("imageUrls : $imageUrls");
        final client = RetryClient(http.Client());
        Product product = Product(
            images: imageUrls,
            title: titleController.text,
            description: descriptionController.text,
            price: double.parse(priceController.text),
            size: '',
            id: '',
            // color: Colors.cyan,
            quantity: int.parse(quantityController.text),
            category: _selectedItem!.id,
            averageRating: 0);

        var response = await client.post(
          Uri.http(uri, '/api/products/addProduct'),
          body: product.toJson(),
          headers: {'Content-Type': 'application/json'},
        );
        if (!context.mounted) return;
        httpresponseHandler(
            context: context,
            response: response,
            onSuccess: () {
              print("response.statusCode add product ${response.statusCode}");
              print("response.statusCode add product ${response}");
              dialogBox(context, "Product added Successfull.. ",
                  "Login with same credentials", "Go back");
            });
      } else {
        final client = RetryClient(http.Client());
        print("empty");
        dialogBox(context, "Images are not uploaded !", "", "Go back");
        var response = await client.post(
          Uri.http(uri, '/api/products/rollBackUploads'),
          body: jsonEncode({"imageKeys": imagekeys}),
          headers: {'Content-Type': 'application/json'},
        );
        if (!context.mounted) return;
        httpresponseHandler(
            context: context,
            response: response,
            onSuccess: () {
              print("response.statusCode add product ${response.statusCode}");
              print("response.statusCode add product ${response}");
              dialogBox(context, "Product added Successfull.. ",
                  "Login with same credentials", "Go back");
            });
      }
    } catch (e) {
      print("error: $e");
    }
  }

  setSelectedCategory(Category selectedCat) {
    setState(() {
      _selectedItem = selectedCat;
    });
    print("_selectedItem!.id ${_selectedItem!.id}");
  }

// List<XFile> images = await _picker.pickMultiImage()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New product"),
        backgroundColor: Colors.blue[400],
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      //     child: Column(
      //       children: [
      //         // TextFormField(
      //         //     controller: titleController,
      //         //     decoration: const InputDecoration(
      //         //       border: OutlineInputBorder(),
      //         //       hintText: "Add title",
      //         //     )),
      //         CustomInputField(
      //           "Title",
      //           Colors.blueGrey.withOpacity(0.1),
      //           // Theme.of(context).colorScheme.primary,
      //           titleController,
      //           false,
      //           // prefix: "\$ ",
      //           textInputType: TextInputType.text,
      //         ),
      //         const SizedBox(
      //           height: 10.0,
      //         ),
      //         // ExpansionTile(
      //         //   collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.1),
      //         //   backgroundColor: Colors.blueGrey.withOpacity(0.05),
      //         //   collapsedShape: RoundedRectangleBorder(
      //         //     borderRadius: BorderRadius.circular(10),
      //         //   ),
      //         //   shape: const RoundedRectangleBorder(
      //         //       borderRadius: BorderRadius.only(
      //         //     topLeft: Radius.circular(15),
      //         //     topRight: Radius.circular(15),
      //         //   )),
      //         //   childrenPadding: const EdgeInsets.only(left: 30),
      //         //   title: const Text("category"),
      //         //   children: const [
      //         //     ListTile(
      //         //       title: Text("tag"),
      //         //     ),
      //         //     ListTile(
      //         //       title: Text("tag"),
      //         //     ),
      //         //   ],
      //         // ),

      //         // const SizedBox(
      //         //   height: 15.0,
      //         // ),
      //         Container(
      //           // padding: EdgeInsets.all(8.0),
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             color: Colors.blueGrey.withOpacity(0.1),
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           child: ListTile(
      //             title: _selectedItem != null
      //                 ? Text(_selectedItem!.name)
      //                 : const Text("Select Category"),
      //             onTap: () {
      //               showModalBottomSheet(
      //                   context: context,
      //                   builder: (context) {
      //                     return CategorySelectDropDown(
      //                       selectCat: setSelectedCategory,
      //                     );
      //                   });
      //             },
      //           ),
      //         ),

      //         // IconButton(
      //         //   icon: Icon(Icons.abc_rounded),
      //         //   // style: ButtonStyle(backgroundColor: ),
      //         //   onPressed: () => print("selectedItem : ${_selectedItem!.id}"),
      //         // ),
      //         const SizedBox(
      //           height: 15.0,
      //         ),
      //         // Container(
      //         //   height: 200, // Define a specific height to ensure proper layout
      //         //   child: CategorySelector(),
      //         // ),
      //         // DropdownMenu(
      //         //   // width: ,
      //         //   label: const Text("Select Category"),
      //         //   leadingIcon: const Icon(Icons.category_outlined),
      //         //   // initialSelection: "Category",
      //         //   dropdownMenuEntries: categories
      //         //       .map<DropdownMenuEntry<String>>((String cate) =>
      //         //           DropdownMenuEntry<String>(value: cate, label: cate))
      //         //       .toList(),
      //         //   onSelected: (value) {
      //         //     setState(() {
      //         //       dropdownValue = value!;
      //         //     });
      //         //   },
      //         //   width: 300,
      //         //   inputDecorationTheme:
      //         //       const InputDecorationTheme(border: InputBorder.none),
      //         // ),
      //         // Row(
      //         //   mainAxisSize: MainAxisSize.max,
      //         //   children: [
      //         //     DropdownMenu(
      //         //       // width: ,
      //         //       label: const Text("Select Category"),
      //         //       leadingIcon: const Icon(Icons.category_outlined),
      //         //       // initialSelection: "Category",
      //         //       dropdownMenuEntries: categories
      //         //           .map<DropdownMenuEntry<String>>((String cate) =>
      //         //               DropdownMenuEntry<String>(value: cate, label: cate))
      //         //           .toList(),
      //         //       onSelected: (value) {
      //         //         setState(() {
      //         //           dropdownValue = value!;
      //         //         });
      //         //       },
      //         //       inputDecorationTheme:
      //         //           const InputDecorationTheme(border: InputBorder.none),
      //         //     ),
      //         //   ],
      //         // ),

      //         Container(
      //           // padding: EdgeInsets.all(8.0),
      //           width: double.infinity,
      //           height: 200,
      //           decoration: BoxDecoration(
      //             color: Colors.blueGrey.withOpacity(0.15),
      //             borderRadius: BorderRadius.circular(20),
      //             // border: Border.all(
      //             //   style: BorderStyle.solid,
      //             // ),
      //           ),
      //           child: imagesFileList.isEmpty
      //               ? IconButton(
      //                   icon: const Icon(
      //                     Icons.add_a_photo_outlined,
      //                     size: 60,
      //                   ),
      //                   onPressed: getImage,
      //                 )
      //               : GestureDetector(
      //                   onTap: getImage,
      //                   // child: ClipRRect(
      //                   //   borderRadius: BorderRadius.circular(20),
      //                   //   child: Image.file(
      //                   //     image2!,
      //                   //     fit: BoxFit.cover,
      //                   //   ),
      //                   // ),
      //                   child: ClipRect(
      //                     child: CarouselSlider(
      //                         items: imagesFileList
      //                             .map((XFile imgFile) => Image.file(
      //                                   File(imgFile.path),
      //                                   fit: BoxFit.cover,
      //                                 ))
      //                             .toList(),
      //                         options: CarouselOptions(autoPlay: true)),
      //                   )),
      //         ),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         // TextFormField(
      //         //   controller: descriptionController,
      //         //   decoration: const InputDecoration(
      //         //     border: OutlineInputBorder(),
      //         //     alignLabelWithHint: true,
      //         //     labelText: "Description",
      //         //   ),
      //         //   minLines: 4,
      //         //   maxLines: null,
      //         //   keyboardType: TextInputType.multiline,
      //         // ),
      //         CustomInputField(
      //           maxlines: 4,
      //           "Description",
      //           Colors.blueGrey.withOpacity(0.1),
      //           // Theme.of(context).colorScheme.primary,
      //           descriptionController,
      //           false,
      //           textInputType: TextInputType.text,
      //         ),
      //         // const SizedBox(
      //         //   height: 15,
      //         // ),
      //         // TextFormField(
      //         //   controller: priceController,
      //         //   decoration: const InputDecoration(
      //         //       labelText: "Price",
      //         //       border: OutlineInputBorder(),
      //         //       prefixText: "\$ "),
      //         //   keyboardType: TextInputType.number,
      //         // ),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         CustomInputField(
      //           "Price",
      //           Colors.blueGrey.withOpacity(0.1),
      //           // Theme.of(context).colorScheme.primary,
      //           priceController,
      //           false,
      //           prefix: "\$ ",
      //           textInputType: TextInputType.number,
      //         ),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         // TextFormField(
      //         //   controller: quantityController,
      //         //   decoration: const InputDecoration(
      //         //     labelText: "Quantity",
      //         //     border: OutlineInputBorder(),
      //         //   ),
      //         //   keyboardType: TextInputType.number,
      //         // ),
      //         CustomInputField(
      //           "Quantity",
      //           Colors.blueGrey.withOpacity(0.1),
      //           quantityController,
      //           false,
      //         ),
      //         const SizedBox(
      //           height: 15,
      //         ),
      //         SizedBox(
      //           width: double.infinity,
      //           child: ElevatedButton(
      //               style: ButtonStyle(
      //                   shape: const MaterialStatePropertyAll(
      //                       RoundedRectangleBorder(
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(20)))),
      //                   backgroundColor:
      //                       MaterialStatePropertyAll(Colors.blue[400])),
      //               onPressed: () {
      //                 _addProduct();
      //                 print(titleController.text);
      //                 // CollectionReference clref =
      //                 //     FirebaseFirestore.instance.collection('Product');
      //                 // clref.add({'title': titleController.text});
      //               },
      //               child: const Text("Add product")),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Stepper(
        controlsBuilder: (context, details) {
          return Row(
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: details.onStepContinue,
                child: const Text('NEXT'),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                onPressed: details.onStepCancel,
                child: const Text('EXIT'),
              ),
            ],
          );
        },
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepCancel: () => currentStep == 0
            ? null
            : setState(() {
                currentStep -= 1;
              }),
        onStepContinue: () {
          bool isLastStep = (currentStep == getSteps().length - 1);
          if (isLastStep) {
            //Do something with this information
          } else {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        steps: getSteps(),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Info"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // TextFormField(
                //     controller: titleController,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       hintText: "Add title",
                //     )),
                CustomInputField(
                  "Title",
                  Colors.blueGrey.withOpacity(0.1),
                  // Theme.of(context).colorScheme.primary,
                  titleController,
                  false,
                  // prefix: "\$ ",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // ExpansionTile(
                //   collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.1),
                //   backgroundColor: Colors.blueGrey.withOpacity(0.05),
                //   collapsedShape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15),
                //   )),
                //   childrenPadding: const EdgeInsets.only(left: 30),
                //   title: const Text("category"),
                //   children: const [
                //     ListTile(
                //       title: Text("tag"),
                //     ),
                //     ListTile(
                //       title: Text("tag"),
                //     ),
                //   ],
                // ),

                // const SizedBox(
                //   height: 15.0,
                // ),
                Container(
                  // padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: _selectedItem != null
                        ? Text(_selectedItem!.name)
                        : const Text("Select Category"),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CategorySelectDropDown(
                              selectCat: setSelectedCategory,
                            );
                          });
                    },
                  ),
                ),

                // IconButton(
                //   icon: Icon(Icons.abc_rounded),
                //   // style: ButtonStyle(backgroundColor: ),
                //   onPressed: () => print("selectedItem : ${_selectedItem!.id}"),
                // ),
                const SizedBox(
                  height: 15.0,
                ),
                // Container(
                //   height: 200, // Define a specific height to ensure proper layout
                //   child: CategorySelector(),
                // ),
                // DropdownMenu(
                //   // width: ,
                //   label: const Text("Select Category"),
                //   leadingIcon: const Icon(Icons.category_outlined),
                //   // initialSelection: "Category",
                //   dropdownMenuEntries: categories
                //       .map<DropdownMenuEntry<String>>((String cate) =>
                //           DropdownMenuEntry<String>(value: cate, label: cate))
                //       .toList(),
                //   onSelected: (value) {
                //     setState(() {
                //       dropdownValue = value!;
                //     });
                //   },
                //   width: 300,
                //   inputDecorationTheme:
                //       const InputDecorationTheme(border: InputBorder.none),
                // ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     DropdownMenu(
                //       // width: ,
                //       label: const Text("Select Category"),
                //       leadingIcon: const Icon(Icons.category_outlined),
                //       // initialSelection: "Category",
                //       dropdownMenuEntries: categories
                //           .map<DropdownMenuEntry<String>>((String cate) =>
                //               DropdownMenuEntry<String>(value: cate, label: cate))
                //           .toList(),
                //       onSelected: (value) {
                //         setState(() {
                //           dropdownValue = value!;
                //         });
                //       },
                //       inputDecorationTheme:
                //           const InputDecorationTheme(border: InputBorder.none),
                //     ),
                //   ],
                // ),

                Container(
                  // padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(
                    //   style: BorderStyle.solid,
                    // ),
                  ),
                  child: imagesFileList.isEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 60,
                          ),
                          onPressed: getImage,
                        )
                      : GestureDetector(
                          onTap: getImage,
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(20),
                          //   child: Image.file(
                          //     image2!,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          child: ClipRect(
                            child: CarouselSlider(
                                items: imagesFileList
                                    .map((XFile imgFile) => Image.file(
                                          File(imgFile.path),
                                          fit: BoxFit.cover,
                                        ))
                                    .toList(),
                                options: CarouselOptions(autoPlay: true)),
                          )),
                ),
                const SizedBox(
                  height: 15,
                ),
                // TextFormField(
                //   controller: descriptionController,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     alignLabelWithHint: true,
                //     labelText: "Description",
                //   ),
                //   minLines: 4,
                //   maxLines: null,
                //   keyboardType: TextInputType.multiline,
                // ),
                CustomInputField(
                  maxlines: 4,
                  "Description",
                  Colors.blueGrey.withOpacity(0.1),
                  // Theme.of(context).colorScheme.primary,
                  descriptionController,
                  false,
                  textInputType: TextInputType.text,
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                // TextFormField(
                //   controller: priceController,
                //   decoration: const InputDecoration(
                //       labelText: "Price",
                //       border: OutlineInputBorder(),
                //       prefixText: "\$ "),
                //   keyboardType: TextInputType.number,
                // ),
                const SizedBox(
                  height: 15,
                ),
                CustomInputField(
                  "Price",
                  Colors.blueGrey.withOpacity(0.1),
                  // Theme.of(context).colorScheme.primary,
                  priceController,
                  false,
                  prefix: "\$ ",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                // TextFormField(
                //   controller: quantityController,
                //   decoration: const InputDecoration(
                //     labelText: "Quantity",
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.number,
                // ),
                CustomInputField(
                  "Quantity",
                  Colors.blueGrey.withOpacity(0.1),
                  quantityController,
                  false,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue[400])),
                      onPressed: () {
                        _addProduct();
                        print(titleController.text);
                        // CollectionReference clref =
                        //     FirebaseFirestore.instance.collection('Product');
                        // clref.add({'title': titleController.text});
                      },
                      child: const Text("Add product")),
                ),
              ],
            ),
          )),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Address"),
        content: const Column(
          children: [
            CustomInput(
              hint: "City and State",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Postal Code",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Misc"),
        content: const Column(
          children: [
            CustomInput(
              hint: "Bio",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
    ];
  }
}
