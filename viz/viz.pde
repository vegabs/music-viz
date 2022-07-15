
import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];
float[] sum = new float[bands];

color[] colors = {#61F908, #FFFF00, #FFAA00, #FF007A};
//color[] colors = {#22577A, #38A3A5, #57CC99, #80ED99, #C7F9CC};

void setup() {
  size(1536, 800);
  smooth(8);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  // print(Sound.list());

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
 // background(0);
  fft.analyze(spectrum);

  for (int i = 0; i < int(bands/4); i++)
  {
    // Smooth the FFT spectrum data by smoothing factor
    sum[i] += (abs((spectrum[i]) / 2) - sum[i]) * 0.25;
  }

  int j = 0;
  for (int i = 0; i < int(bands/4); i++) {
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    int index = int(random(colors.length));
    stroke(colors[index]);
    noFill();
    strokeWeight(2);
    // line( i, height, i, height - spectrum[i]*height*20);
    //rect(j, 0, 12, (spectrum[i]+spectrum[i+1])*height*1000);
    j = j + 100;
    circle((width/2) + 300*cos(j) + (index * 2), (height/2) + 300*sin(j) + (index * 2), sum[i]*height*8*i);
  }
  noStroke();
  fill(0,0,0,75);
  rect(0,0,width,height);
}
