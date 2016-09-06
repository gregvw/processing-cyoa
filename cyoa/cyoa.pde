// Define our color set
color white   = color(255,255,255);
color red     = color(255,0,0);
color green   = color(0,255,0);
color blue    = color(0,0,255);
color cyan    = color(0,255,255);
color magenta = color(255,0,255);
color yellow  = color(0,255,255);

// Default values
color leftColor      = white;
color rightColor     = white;
color currentBGColor = white;

// Left and Right Box coordinates
float aL = 150;  // x-coordinate of left box
float bL = 100;  // y-coordinate of left box
float cL = 100;  // width of left box
float dL = 100;  // height of left box

float aR = 350;  // x-coordinate of right box
float bR = 100;  // y-coordinate of right box
float cR = 100;  // width of right box
float dR = 100;  // height of right box

// This class describes a "page" or situation in our Choose-Your-Own-Adventure story. We have two choices on each 
// page which lead us to a different page
public class Page {

  color   clr;

  // These are the two next pages you can get to from this page
  Page leftChild, rightChild;

  // Class constructor
  Page( color InitColor, Page Left, Page Right ) {
    clr = InitColor;
    leftChild = Left;
    rightChild = Right;
  } 
  
  void update() {
   background(clr);

   fill(leftChild.clr);
   rect(aL,bL,cL,dL);
  
   fill(rightChild.clr);
   rect(aR,bR,cR,dR);
  }  
}

// These are all of the possible situations in our adventure
Page White;
Page Blue;
Page Red;
Page Green;
Page currentPage;

/*
 
 We start at White and our left choice is Blue and our right choice is Red. If we go to Blue, 
 we have the left choice of White. If we go to Red, the left choice is Green, the right choice is White.
 Choices from Green send us back to the parent color of Blue or Red. 

                         W
                        / \
                       /   \
                      B     R
                     / \   / \
                    /   \ /   \
                   W     G     W
                        / \
                       /   \
                      B     R      

*/



// Returns True if click in left box
boolean inLeft() {
  return (mouseX>aL)&&(mouseY>bL)&&(mouseX<aL+cL)&&(mouseY<bL+dL);
}

// Returns True if click in right box
boolean inRight() {
  return (mouseX>aR)&&(mouseY>bR)&&(mouseX<aR+cR)&&(mouseY<bR+dR);
}


void mouseClicked() {
  if(inLeft()) {
    currentPage = currentPage.leftChild;     
  }
  else if(inRight()) {
    currentPage = currentPage.rightChild;
  }   
}


void setup() {

 White = new Page(white, null, null);
 Blue  = new Page(blue,  null, null);
 Red   = new Page(red,   null, null);
 Green = new Page(green, null, null);

 White.leftChild = Blue;
 White.rightChild = Red;
 
 Blue.leftChild = White;
 Blue.rightChild = Green;
 
 Red.leftChild = Green;
 Red.rightChild = White;
 
 Green.leftChild = Blue;
 Green.rightChild = Red;
 
 currentPage = White; 
  
 size(640,360);
} 

void draw() {
  currentPage.update();   
}
