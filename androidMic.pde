import android.media.MediaRecorder;
import android.media.MediaPlayer;
import android.os.Environment;
import android.content.Context;
import java.io.IOException;
import ketai.ui.*;

MediaRecorder mRecorder = null;
MediaPlayer   mPlayer = null;

boolean recording = false;
boolean playing = false;

String fileName = null;

boolean locked = false;
color currentcolor;
int sw, sh;
KetaiGesture gesture;

void setup() {
  size(displayWidth, displayHeight);

  orientation(PORTRAIT);
  background(0);
  smooth();
  
  gesture = new KetaiGesture(this);
  
  // get somewhere on our card 
  fileName = Environment.getExternalStorageDirectory().getAbsolutePath();
  fileName += "/audiorecordtest.3gp";
}

void draw(){
  
  fill(255, 0, 0);
  rect(50, 100, 200, 200);
  fill(255, 255, 255);
  text("play", 100, 200);
  
  fill(0, 0, 255);
  rect(350, 100, 200, 200);
  fill(255, 255, 255);
  text("record", 400, 200);
  
}


void onPause() {
  super.onPause();
  if (mRecorder != null) {
    mRecorder.release();
    mRecorder = null;
  }

  if (mPlayer != null) {
    mPlayer.release();
    mPlayer = null;
  }
}

void startPlaying() {
  background(0);
  mPlayer = new MediaPlayer();
  try {
    mPlayer.setDataSource(fileName);
    mPlayer.prepare();
    mPlayer.start();
  } 
  catch (IOException e) {
    println("prepare() failed");
  }
}

void stopPlaying() {
  background(0);
  mPlayer.release();
  mPlayer = null;
}

void startRecording() {
  mRecorder = new MediaRecorder();
  mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
  mRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
  mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
  mRecorder.setOutputFile(fileName);

  try {
    mRecorder.prepare();
  } 
  catch (IOException e) {
    println("prepare() failed");
  }

  mRecorder.start();
}

void stopRecording() {
  background(0);
  mRecorder.stop();
  mRecorder.release();
  mRecorder = null;
}

void mousePressed()
{
  if( mouseX > 100 && mouseX < 300)
  {
     if(!playing) {
    startPlaying();
  } else {
    stopPlaying();
  }
  playing = !playing;
  }
  
  if(mouseX > 400 && mouseX < 600) {
   if( !recording ) {
    startRecording();
  } else {
    stopRecording();
  }
  recording = !recording;
  }
} 