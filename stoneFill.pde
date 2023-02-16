void StoneFill() {
  boolean CD=true;
  float dS=0;
  int plusstone=0;
  for (int j=0; j<Stones.size(); j++) {//他の全ての石との当たり判定
    dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), mouseX, mouseY);
    if (dS<(Stones.get(j).get(5)/2.0+lensD/2.0+space)*72/25.4) {
      CD=false;
    }
  }
  if (CD==true) {
    noFill();
    //ellipse(mouseX, mouseY, lensD*72/25.4, lensD*72/25.4);
    //println(lensD);
    ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
    Stone.add(float(mouseX));
    Stone.add(float(mouseY));
    Stone.add(drawCount);//描画順
    Stone.add(0.0);//選択チェック
    Stone.add(float(selectCol));//石の種類
    Stone.add(lensD);//石の直径
    Stone.add(float(selectP));//石の種類
    Stones.add(Stone);
    drawingStone++;
  }


  for (int i=0; i<4; i++) {
    boolean cd=true;
    float px=0;
    float py=0;
    if (i==0) {//left
      px=mouseX-(lensD+space)*72/25.4;
      py=mouseY;
    } else if (i==1) {//right
      px=mouseX+(lensD+space)*72/25.4;
      py=mouseY;
    } else if (i==2) {//up
      px=mouseX;
      py=mouseY-(lensD+space)*72/25.4;
    } else {//down
      px=mouseX;
      py=mouseY+(lensD+space)*72/25.4;
    }
    for (int j=0; j<Stones.size()-(i+1); j++) {
      dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), px, py);
      if (dS<(Stones.get(j).get(5)/2.0+lensD/2.0)*72/25.4) {
        cd=false;
      }
    }
    if (cd) {
      noFill();
      ellipse(px, py, lensD*72/25.4, lensD*72/25.4);
      ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
      Stone.add(px);
      Stone.add(py);
      Stone.add(drawCount);//描画順
      Stone.add(0.0);//選択チェック
      Stone.add(float(selectCol));//石の種類
      Stone.add(lensD);//石の直径
      Stone.add(float(selectP));//石の種類2
      Stones.add(Stone);
      drawingStone++;
      plusstone++;
    }
    //println(cd+","+dS);
  }

  while (plusstone>0) {
    int plus=0;
    for (int u=0; u<plusstone; u++) {
      int p=Stones.size()-plusstone+u-plus;
      for (int i=0; i<4; i++) {
        boolean cd=true;
        float px=0;
        float py=0;
        if (i==0) {//left
          px=Stones.get(p).get(0)-(lensD+space)*72/25.4;
          py=Stones.get(p).get(1);
        } else if (i==1) {//right
          px=Stones.get(p).get(0)+(lensD+space)*72/25.4;
          py=Stones.get(p).get(1);
        } else if (i==2) {//up
          px=Stones.get(p).get(0);
          py=Stones.get(p).get(1)-(lensD+space)*72/25.4;
        } else {//down
          px=Stones.get(p).get(0);
          py=Stones.get(p).get(1)+(lensD+space)*72/25.4;
        }
        for (int j=0; j<Stones.size()-(i+1); j++) {
          dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), px, py);
          if (dS<(Stones.get(j).get(5)/2.0+lensD/2.0)*72/25.4) {
            cd=false;
          }
          if(px<Dx||Dx+Dw<px){
            cd=false;
          }
          if(py<Dy||Dy+Dh<py){
            cd=false;
          }
        }
        for (int j=0; j<Stones.size(); j++) {
          if(Stones.get(j).get(0)==px&&Stones.get(j).get(1)==py){
            cd=false;
            
          }
        }
        if (cd) {
          noFill();
          ellipse(px, py, lensD*72/25.4, lensD*72/25.4);
          ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
          Stone.add(px);
          Stone.add(py);
          Stone.add(drawCount);//描画順
          Stone.add(0.0);//選択チェック
          Stone.add(float(selectCol));//石の種類
          Stone.add(lensD);//石の直径
          Stone.add(float(selectP));//石の種類2
          Stones.add(Stone);
          drawingStone++;
          plus++;
        }
        //println(cd+","+dS);
      }   
    }
    plusstone=plus;
  }
}
