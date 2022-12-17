void StoneFill2() {
  boolean CD=true;
  float dS=0;
  int plusstone=0;
  for (int j=0; j<Stones.size(); j++) {//他の全ての石との当たり判定
    dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), mouseX, mouseY);
    if (dS<px(Stones.get(j).get(5)/2.0+lensD/2.0)) {
      CD=false;
    }
  }

  if (CD) {
    noFill();
    ellipse(mouseX, mouseY, px(lensD), px(lensD));
    ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
    Stone.add(float(mouseX));
    Stone.add(float(mouseY));
    Stone.add(drawCount);//描画順
    Stone.add(0.0);//選択チェック
    Stone.add(float(selectCol));//石の種類
    Stone.add(lensD);//石の直径
    Stones.add(Stone);
    drawingStone++;
    fillstone++;
  }


  for (int i=0; i<6; i++) {
    boolean cd=true;
    float pX=0;
    float py=0;
    if (i==0) {//left
      pX=mouseX-px(lensD+space);
      py=mouseY;
    } else if (i==1) {//right
      pX=mouseX+px(lensD+space);
      py=mouseY;
    } else if (i==2) {//upleft
      pX=mouseX-px((lensD+space)/2);
      py=mouseY-px((lensD+space)/2*sqrt(3));
    } else if (i==3) {//upright
      pX=mouseX+px((lensD+space)/2);
      py=mouseY-px((lensD+space)/2*sqrt(3));
    } else if (i==4) {//downleft
      pX=mouseX-px((lensD+space)/2);
      py=mouseY+px((lensD+space)/2*sqrt(3));
    } else {//downright
      pX=mouseX+px((lensD+space)/2);
      py=mouseY+px((lensD+space)/2*sqrt(3));
    }
    for (int j=0; j<Stones.size(); j++) {
      dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), pX, py);
      if (dS<px(Stones.get(j).get(5)/2.0+lensD/2.0)) {
        cd=false;
      }
    }
    if (cd) {
      noFill();
      ellipse(pX, py, px(lensD), px(lensD));
      ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
      Stone.add(pX);
      Stone.add(py);
      Stone.add(drawCount);//描画順
      Stone.add(0.0);//選択チェック
      Stone.add(float(selectCol));//石の種類
      Stone.add(lensD);//石の直径
      Stones.add(Stone);
      drawingStone++;
      plusstone++;
      fillstone++;
    }
    //println(cd+","+dS);
  }

  while (plusstone>0) {
    int plus=0;
    for (int u=0; u<plusstone; u++) {
      int p=Stones.size()-plusstone+u-plus;
      for (int i=0; i<6; i++) {
        boolean cd=true;
        float pX=0;
        float py=0;

        if (i==0) {//left
          pX=Stones.get(p).get(0)-px(lensD+space);
          py=Stones.get(p).get(1);
        } else if (i==1) {//right
          pX=Stones.get(p).get(0)+px(lensD+space);
          py=Stones.get(p).get(1);
        } else if (i==2) {//upleft
          pX=Stones.get(p).get(0)-px((lensD+space)/2);
          py=Stones.get(p).get(1)-px((lensD+space)/2*sqrt(3));
        } else if (i==3) {//upright
          pX=Stones.get(p).get(0)+px((lensD+space)/2);
          py=Stones.get(p).get(1)-px((lensD+space)/2*sqrt(3));
        } else if (i==4) {//downleft
          pX=Stones.get(p).get(0)-px((lensD+space)/2);
          py=Stones.get(p).get(1)+px((lensD+space)/2*sqrt(3));
        } else {//downright
          pX=Stones.get(p).get(0)+px((lensD+space)/2);
          py=Stones.get(p).get(1)+px((lensD+space)/2*sqrt(3));
        }

        for (int j=0; j<Stones.size(); j++) {
          dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), pX, py);
          if (dS<px(Stones.get(j).get(5)/2.0+lensD/2.0)) {
            cd=false;
          }
          if (pX<Dx||Dx+Dw<pX) {
            cd=false;
          }
          if (py<Dy||Dy+Dh<py) {
            cd=false;
          }
        }
        for (int j=0; j<Stones.size(); j++) {
          //if (Stones.get(j).get(0)==px&&Stones.get(j).get(1)==py) {
          dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), pX, py);
          if (dS<=px(Stones.get(j).get(5)/2.0+lensD/2.0)) {
            cd=false;
          }
        }
        if (cd) {
          noFill();
          ellipse(pX, py, px(lensD), px(lensD));
          ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
          Stone.add(pX);
          Stone.add(py);
          Stone.add(drawCount);//描画順
          Stone.add(0.0);//選択チェック
          Stone.add(float(selectCol));//石の種類
          Stone.add(lensD);//石の直径
          Stones.add(Stone);
          drawingStone++;
          plus++;
          fillstone++;
        }
      }
    }
    plusstone=plus;
  }

  for (int u=0; u<10; u++) {
    int count=0;
    diagram.ClearPoint();
    for (int i=0; i<Stones.size(); i++) {
      //println("ok");
      diagram.AddPoint(new PVector(Stones.get(i).get(0), Stones.get(i).get(1)));
    }

    for (int i=0; i<fillstone; i++) {
      dS=0;
      CD=true;
      float[] newpoint=diagram.Area(new PVector(Stones.get(Stones.size()-fillstone+i).get(0), Stones.get(Stones.size()-fillstone+i).get(1)));
          //println("0k");
      for (int j=0; j<Stones.size(); j++) {//他の全ての石との当たり判定
        dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), newpoint[0], newpoint[1]);
        if (j!=Stones.size()-fillstone+i) {
          if (dS<px(Stones.get(j).get(5)/2.0+lensD/2.0+space)) {
            CD=false;
            break;
          }
        }
      }
      //float dist=dist(Stones.get(Stones.size()-fillstone+i).get(0),Stones.get(Stones.size()-fillstone+i).get(1),newpoint[0],newpoint[1]);
      if (Stones.get(Stones.size()-fillstone+i).get(0)!=newpoint[0]) {
        if (Stones.get(Stones.size()-fillstone+i).get(1)!=newpoint[1]) {
          //if(dist>0.05){
          //if (newpoint[0]!=0) {
            //if (newpoint[1]!=0) {
              if (CD) {
                Stones.get(Stones.size()-fillstone+i).set(0, newpoint[0]);
                Stones.get(Stones.size()-fillstone+i).set(1, newpoint[1]);
                count=1;
              //}
            //}
          }
        }
      }
    }
    //println(count+","+fillstone);
    if (count==0) {
      break;
    }
    //println(u);
  }
  fillstone=0;
  
}

