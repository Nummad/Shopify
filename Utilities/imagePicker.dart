import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<List<File>>pickImages()async{
  List<File> images = [];
  try{
    var file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if(file!=null && file.files.isNotEmpty){
      for(int i=0; i<file.files.length; i++){
        images.add(File(file.files[i].path!));
      }
    }
  }catch(e){
  }
  return images;
}