void UI() {
  //draw
  noFill();
  stroke(200);
  strokeWeight(1);
  for (int i=0; i<Dh/(px(10)*zoom); i++) {//横線
    line(Dx, Dy+px(10)*zoom*i, Dx+Dw, Dy+px(10)*zoom*i);
  }
  for (int i=0; i<Dw/(px(10)*zoom); i++) {//縦線
    noFill();
    stroke(200);
    strokeWeight(1);
    line(Dx+px(10)*zoom*i, Dy, Dx+px(10)*zoom*i, Dy+Dh);
    fill(0);
    textAlign(CENTER);
    textSize(12);
    text(i*10, Dx+px(10)*zoom*i, Dy+Dh+12);
  }
  noFill();
  stroke(0);
  rect(Dx, Dy, Dw, Dh);//枠

  //tool
  for (int i=0; i<tImage.length; i++) {
    //rect(Tx+Tw*i, Ty, Tw, Th);
    if (i<tImage.length) {
      image(tImage[i], Tx+Tw*i, Ty, Tw, Th);
    }
  }
  noStroke();
  fill(0, 50);
  ellipse(Tx+Tw*tool+Tw/2, Ty+Th/2, Tw, Th);

  //file

    stroke(0);
    noFill();
    //rect(Fx, Fy, Fw, Fh);
    image(dImage,Fx, Fy, Fw, Fh);
    image(back,5,Fy+5,Fw,Fh);
    //String sf;
    // if (i==0) {
    //   sf="save";
    // } else {
    //   sf="output";
    // }
    // fill(0);
    // textAlign(CENTER);
    // textSize(18);
    // text(sf, Fx+Fw*i+Fw/2, Fh/1.3);

  //pattern
  noStroke();
  fill(0, 50);
  //rect(Px+Pw*selectP, Py, Pw, Ph);
  rect(Px+Pw*selectCol, Py+Ph, Pw, Ph);
  //rect(Px+Pw*(selectCol%7), Py+Ph*int(selectCol/7), Pw, Ph);
  for (int j=0; j<1; j++) {
    for (int i=0; i<6; i++) {
      if(i==selectP){
        stroke(0);
      }else{
        stroke(0,60);
      }
      if(i!=selectP){
        tint( 255.0, 127 );
      }else{
        tint( 255.0, 255 );
      }
      noFill();
      rect(Px+Pw*i, Py+Ph*j, Pw, Ph);
      //pattern(Px+(Pw)*i+Pw/2, Py+(Ph)*j+Ph/2, Pw*0.7, COLOR, i+j*7);
      if(i==selectP){
      image(pImage[i][selectCP[i]],Px+(Pw)*i+Pw/5, Py+(Ph)*j+Ph/5,Pw-10,Ph-10);
      }else{
        image(pImage[i][selectCP[i]],Px+(Pw)*i+Pw/5, Py+(Ph)*j+Ph/5,Pw-10,Ph-10);
      }
    }
  }
  tint( 255.0, 255 );

  for (int j=0; j<1; j++) {
    for (int i=0; i<11; i++) {
      noFill();
      stroke(0);
      rect(Px+Pw*i, Py+Ph*j+Ph, Pw, Ph);
      //pattern(Px+(Pw)*i+Pw/2, Py+(Ph)*j+Ph/2, Pw*0.7, COLOR, i+j*7);
      image(pImage[selectP][i],Px+(Pw)*i+Pw/5, Py+(Ph)*j+Ph/5+Ph,Pw-10,Ph-10);
    }
  }

  //直径バー
  stroke(0);
  line(PSx, PSy, PSx+PSw, PSy);
  float dm=dist(PSx, PSy, PSx+PSw, PSy)/18;
  for(int i=0;i<19;i++){
    line(PSx+dm*i,PSy-5,PSx+dm*i,PSy+5);
  }
  fill(255);
  ellipse(PSx+dm*((lensD/zoom)/0.5)-dm*2, PSy,10,10);
  fill(0);
  textAlign(CENTER);
  textSize(14);
  text("Size", PSx-20, PSy+5);
  text(nf(lensD/zoom,1,1), PSx+dm*((lensD/zoom)/0.5)-dm*2, PSy-10);
  
}
