// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tst/BLOC/AllProductBloc/blocLayer/all_product_bloc.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_bloc.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_state.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/bloc.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocEvents.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocModel.dart';
import 'package:flutter_tst/FileData/upload_file_model.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/dropdown.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/add_atributes_dialog.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/add_video_image.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/currency_select_widget.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/file_video_player.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/manage_attributes.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_product_widgets/remove_attributes.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/country_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../Widgets/sellerpage_widgets/add_product_widgets/add_attributes_values.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web/image_picker_web.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  void setUser() async {
    // var userid = "0";
    // int usid = int.parse(userid!);
    BlocProvider.of<ProductBloc>(context).add(ChangeUser("user1"));
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  bool attrvalues = false;
  bool isquan = false;
  bool isAddAttributess = false;
  bool isRemoveAttributess = false;
  bool isAddVideoImage = false;
  Map<String, Widget> attributes = {};
  List<Widget> dropdown_attributes = [];
  Map<String, Map<dynamic, dynamic>> allattr = {};
  Map<String, int> availAttrVal = {};
  bool isAvail = false;
  void AddAttributes() {
    setState(() {
      isAddAttributess = !isAddAttributess;
    });
  }

  Attributes attrs = Attributes();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
          child: Material(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    AppColors.base_background_begin,
                    AppColors.base_background_end
                  ])),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  AppMenu(
                    menu: true,
                    home: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Add Product",
                    style: TextStyle(
                        color: AppColors.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Input_box(
                      onchange: (value) {
                        BlocProvider.of<ProductBloc>(context)
                            .add(ChangeTitle(value));
                      },
                      textfieldvalue: "Title"),
                  SizedBox(
                    height: 50,
                  ),
                  Input_box(
                      textfieldvalue: "Description",
                      onchange: (value) {
                        BlocProvider.of<ProductBloc>(context)
                            .add(ChangeDesc(value));
                      }),
                  SizedBox(
                    height: 50,
                  ),
                  Input_box(
                    textfieldvalue: "Price",
                    keyType: TextInputType.number,
                    onchange: (value) {
                      try {
                        if (value != "") {
                          BlocProvider.of<ProductBloc>(context)
                              .add(ChangePrice(int.parse(value) + 0.0));
                        } else {
                          BlocProvider.of<ProductBloc>(context)
                              .add(ChangePrice(0));
                        }
                      } catch (e) {
                        return;
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Input_box(
                      textfieldvalue: "Quantity",
                      keyType: TextInputType.number,
                      onchange: (value) {
                        if (value != "") {
                          BlocProvider.of<ProductBloc>(context)
                              .add(ChangeQuantity(int.parse(value)));
                        } else {
                          BlocProvider.of<ProductBloc>(context)
                              .add(ChangeQuantity(0));
                        }
                      }),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: SearchDropDown(
                      "Select Currency",
                      searchfieldname: "Search Country",
                      values: FlagImages.flagsImages,
                      onchanged: (val) {
                        // BlocProvider.of<ProductBloc>(context)
                        //     .add(ChangeCurrency(val));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  isquan
                      ? Text(
                          "Please enter quantity first",
                          style:
                              TextStyle(color: AppColors.color, fontSize: 20),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button(
                          buttonValue: "Add Attributes",
                          onclick: () {
                            setState(() {
                              AddAttributes();
                            });
                          }),
                      Button(
                          buttonValue: "Remove Attributes",
                          onclick: () {
                            setState(() {
                              isRemoveAttributess = true;
                            });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                      buttonValue: "Attribute Values",
                      onclick: () {
                        setState(() {
                          attrvalues = true;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      runSpacing: 8,
                      children: [...dropdown_attributes],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Images : ",
                    style: TextStyle(color: AppColors.color, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.fore_background_begin,
                                AppColors.fore_background_end,
                              ])),
                      child: BlocBuilder<ProductBloc, blocModel>(
                        builder: (context, state) {
                          List<Widget> show_images = [];
                          // for (var item in state.getImages()) {
                          //   show_images.add(getImageWidget(item, context));
                          // }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [...show_images],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Button(
                            buttonValue: "Add Image",
                            onclick: () async {
                              final ImagePicker _picker = ImagePicker();
                              XFile? image = (await _picker.pickImage(
                                  source: ImageSource.gallery));                              
                              if (image?.path == null) return;
                              File img_file = File(image!.path);
                              UploadFileModel uploadImageFile =
                                  UploadFileModel();
                              await uploadImageFile.initialize(img_file);
                              BlocProvider.of<ProductBloc>(context)
                                  .add(AddUploadImage(uploadImageFile));
                            })),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Videos : ",
                    style: TextStyle(color: AppColors.color, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.fore_background_begin,
                                AppColors.fore_background_end,
                              ])),
                      child: BlocBuilder<ProductBloc, blocModel>(
                        builder: (context, state) {
                          List<Widget> videos_to_show = [];
                          List<Map> videos = state.getVideos();

                          for (var video in videos) {
                            videos_to_show.add(getVideoWidget(
                                video['video'], video['image'], context));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...videos_to_show,
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Button(
                            buttonValue: "Add Video",
                            onclick: () {
                              setState(() {
                                isAddVideoImage = true;
                              });
                            })),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                        if (state.status == CategoryStatus.initial) {
                          BlocProvider.of<CategoryBloc>(context)
                              .add(GetCategoryEvent());
                          return Text("data");
                        } else if (state.status == CategoryStatus.loading) {
                          return Text("Loading Category");
                        } else if (state.status == CategoryStatus.failure) {
                          return Text("Failed to load category");
                        } else {
                          final categorynames =
                              state.categoriesdata.categories.map((e) {
                            return e.categoryName;
                          }).toList();
                          final categoriesid =
                              state.categoriesdata.categories.map((e) {
                            return e.categoryId;
                          }).toList();
                          return SearchDropDown(
                            "Select Category",
                            searchfieldname: "Search Category",
                            onchanged: (val) {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(ChangeCategory(val + ""));
                            },
                            onaltchange: (val) {},
                            values: categorynames,
                            altclickvalues: categoriesid,
                          );
                        }
                      })),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "If category you want is not available add it : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.color,
                          fontSize: 15),
                    ),
                  ),
                  Button(buttonValue: "Add Category", onclick: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "If you are all done then add product : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.color,
                          fontSize: 15),
                    ),
                  ),
                  Button(
                      buttonValue: "Add the Product",
                      onclick: () async {
                        if (isAvail == false && allattr.isNotEmpty) {
                          print("No attrvalues set");
                          return;
                        }
                        blocModel product =
                            blocModel.clone(context.read<ProductBloc>().state);
                        BlocProvider.of<AllProductBloc>(context)
                            .add(AddProducts(product));
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/UploadingProduct',
                            (Route<dynamic> route) => false);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 20,
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ]),
              ),
            ),
            isAddAttributess == true
                ? AddAttributesDialog(
                    onAdd: (data) {
                      isAvail = false;
                      allattr[data['name']] = data;
                      Map<String, dynamic> attrs = {};
                      for (var entry in allattr.entries) {
                        attrs[entry.value['name']] = entry.value['values'];
                      }
                      BlocProvider.of<ProductBloc>(context)
                          .add(ChangeAttr(attrs));
                      // context.read<ProductBloc>().add(ChangeAttr(attrs));
                      attributes[data['name']] = DropDown(
                          itemcount: data['values'].length,
                          name: data['name'],
                          onchanged: (val) {},
                          values: data['values']);
                      setState(() {
                        // print();a
                        dropdown_attributes
                            .add(attributes[data['name']] as Widget);
                        isAddAttributess = false;
                      });
                    },
                    onCancel: () {
                      setState(() {
                        isAddAttributess = false;
                      });
                    },
                  )
                : Container(),
            isRemoveAttributess == true
                ? RemoveAttributeDialog(
                    onRemove: (data) {
                      isAvail = false;
                      Map<String, Map<dynamic, dynamic>> tempattr = {};
                      for (var entry in allattr.entries) {
                        if (data.containsKey(entry.key)) {
                          tempattr[entry.key] = entry.value;
                        }
                      }
                      allattr = tempattr;
                      dropdown_attributes.clear();
                      for (var item in data.entries) {
                        dropdown_attributes.add(item.value);
                      }
                      setState(() {
                        isRemoveAttributess = false;
                      });
                    },
                    onCancel: () {
                      setState(() {
                        isRemoveAttributess = false;
                      });
                    },
                    attributes_data: attributes,
                  )
                : Container(),
            attrvalues
                ? AttributeValues(
                    attributes: allattr,
                    availAttrVal: availAttrVal,
                    onCancel: () {
                      setState(() {
                        attrvalues = false;
                      });
                    },
                    onAdd: (val, attrValQuan) {
                      setState(() {
                        availAttrVal = val;
                        isAvail = true;
                        attrvalues = false;
                        for (var items in val.entries) {
                          if (items.value == -1) {
                            isAvail = false;
                            availAttrVal = {};
                          }
                        }
                        if (isAvail) {
                          BlocProvider.of<ProductBloc>(context)
                              .add(ChangeAttrVal(val));
                        }
                      });
                    },
                    isAvail: isAvail,
                  )
                : Container(),
            isAddVideoImage == true
                ? AddVideoImage(onAdd: (value) async {
                    UploadFileModel img_file = UploadFileModel();
                    UploadFileModel vid_file = UploadFileModel();
                    await img_file.initialize(value['image']);
                    await vid_file.initialize(value['video']);
                    BlocProvider.of<ProductBloc>(context)
                        .add(AddUploadVideo(img_file, vid_file));
                    isAddVideoImage = false;
                    setState(() {});
                  })
                : Container()
          ],
        ),
      )),
    );
  }

  Widget getImageWidget(UploadFileModel image, BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 180,
              height: 205,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          PhotoView(imageProvider: FileImage(image.file))));
                },
                child: Image(
                    fit: BoxFit.fill,
                    image: kIsWeb
                        ? NetworkImage(image.FilePath)
                        : FileImage(image.file) as ImageProvider),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<ProductBloc>(context)
                  .add(RemoveUploadImage(image));
            },
            child: Icon(
              Icons.cancel,
              color: AppColors.color,
              size: 40,
            ),
          ),
        )
      ],
    );
  }

  Widget getVideoWidget(
      UploadFileModel video, UploadFileModel image, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  height: 205,
                  child: Image(fit: BoxFit.fill, image: FileImage(image.file)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 180,
            height: 205,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FileVideoPlayer(videoFile: video.file)));
                },
                child: Icon(
                  Icons.play_arrow,
                  color: AppColors.color,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ProductBloc>(context)
                    .add(RemoveUploadVideo(image, video));
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.cancel,
                  color: AppColors.color,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
