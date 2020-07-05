import 'package:cookie/screens/screens.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  StorageUploadTask uploadTask;

  void startUpload() async {
    var imagePath = storage.ref().child(filePath);
    var uploadTask = imagePath.putFile(image);
    var taskCompleted = await uploadTask.onComplete;
    imageUrl = await taskCompleted.ref.getDownloadURL();
  }

  void initState() {
    super.initState();
    startUpload();
  }

  @override
  Widget build(BuildContext context) {
    if (uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (uploadTask.isComplete) Text('ready'),
                if (uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: uploadTask.resume,
                  ),

                if (uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return SizedBox(
        height: 20,
      );
    }
  }
}
