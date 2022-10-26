void Cursor() {
  if (tool==0) {
    //image(tImageIcon[0],mouseX,mouseY,50,50);
    cursor(tImageIcon[0], 0, 0);
  } else if (tool==1) {
    //image(iconP,0,0);
    //pImage[selectCol].resize(int(px(lensD)-3),int(px(lensD))-3);
    cursor(tImageIcon[1], 0, tImageIcon[2].height-1);
  } else if(tool==2){
    //image(tImageIcon[2],mouseX,mouseY,50,50);
    cursor(tImageIcon[2], 0, tImageIcon[2].height-1);
  }else{
    cursor(tImageIcon[3], 0, tImageIcon[3].height/2);
  }
}
