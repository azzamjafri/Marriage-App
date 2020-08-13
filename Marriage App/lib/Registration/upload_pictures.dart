
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marriage/Navigation/navBar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadPictures extends StatefulWidget {
  final Map<String, dynamic> map;

  UploadPictures({this.map});
  @override
  _UploadPicturesState createState() => _UploadPicturesState();
}

class _UploadPicturesState extends State<UploadPictures> {
  @override
    final scaffoldKey = GlobalKey<ScaffoldState>();
    List<Asset> images = List<Asset>();
    final _auth = FirebaseAuth.instance;
    String _error = 'No Error Dectected';
    final _firestore = Firestore.instance;
    FirebaseUser loggedinuser;
    bool loading = false;
    String location, uid1;
    List<String> uris = [];
    String pdfURL;
    
    void getCurrentUser() async {
      try {
        setState(() {
          loading = true;
        });
        var user = await _auth.currentUser();
        if (user != null) {
          loggedinuser = user;
          uid1 = loggedinuser.uid;
        }
        setState(() {
          loading = false;
        });
      } catch (e) {
        print(e);
      }
    }

    Future<List<String>> uploadImage({@required List<Asset> assets}) async {
      List<String> uploadUrls = [];
      await Future.wait(
          assets.map((Asset asset) async {
            ByteData byteData = await asset.getByteData();
            List<int> imageData = byteData.buffer.asUint8List();
            StorageReference reference = FirebaseStorage.instance.ref().child(
                "pics/$uid1/" + DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString());
            StorageUploadTask uploadTask = reference.putData(imageData);
            StorageTaskSnapshot storageTaskSnapshot;
            StorageTaskSnapshot snapshot = await uploadTask.onComplete;
            if (snapshot.error == null) {
              storageTaskSnapshot = snapshot;
              final String downloadUrl =
              await storageTaskSnapshot.ref.getDownloadURL();
              uploadUrls.add(downloadUrl);

              print('Upload success');
            } else {
              print('Error from image repo ${snapshot.error.toString()}');
              throw ('This file is not an image');
            }
          }),
          eagerError: true,
          cleanUp: (_) {
            print('eager cleaned up');
          });

      return uploadUrls;
    }

    Widget buildGridView() {
      return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.clear,color: Colors.red,),
                  ),
                )
              ],
            ),
          );
        }),
      );
    }

    Future<void> loadAssets() async {
      List<Asset> resultList = List<Asset>();
      String error = 'No Error Dectected';

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 5,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            statusBarColor: "#191919",
            actionBarColor: "#212121",
            actionBarTitle: "Upload Image",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#212121",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        images = resultList;
        _error = error;
      });
    }

    @override
    void initState() {
      super.initState();
      getCurrentUser();
      images.clear();
    }

    @override
    Widget build(BuildContext context) {
      return ModalProgressHUD(
        inAsyncCall: loading,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Select Pictures',style: TextStyle(color: Colors.black),),
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height/1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  images.length == 0
                      ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  loadAssets();
                                },
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        size: 100,
                                      ),
                                      Text(
                                        'SELECT PICTURES',
                                        style: TextStyle(
                                          fontSize: 30,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                    ),
                  )
                      : (images.length<5)?Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                          child: Container(
                              height: 300, child: buildGridView()),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 12.0, top: 5),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    loadAssets();
                                  }),
                              Text("Add More")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ):Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                          child: Container(
                              height: 300, child: buildGridView()),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 12.0, top: 5),
                          child: Column(
                            children: <Widget>[
                              Text("DONE!")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30, top: 20),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Use real picture, not Catalog.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Please wait, Uploading!"),));
                      setState(() {
                        loading = true;
                      });
                      var info=widget.map;
                      uris = await uploadImage(assets: images);
                      info['uid']=uid1;
                      await _firestore.collection("users").document(uid1).updateData(info);
                      await _firestore.collection("users").document(uid1).updateData({
                        "picURLS":uris
                      });

                      setState(() {
                        loading = false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
                    },
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.green),
                        child: Center(
                          child: Text(
                            'Finish',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(width: 2, color: Colors.green),
                        ),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

}
