void stone(float space) {
  //pattern

  float dM;//マウス座標との距離
  float dS;//ストーン座標との距離
  stroke(0);
  pressX=Mouses.get(0).get(0);//初期位置
  pressY=Mouses.get(0).get(1);
  for (int i=0; i<Mouses.size()-1; i++) {
    boolean CD=true;
    if (Mouses.get(i).get(0)>0&&Mouses.get(i+1).get(1)>0) {
        dM=dist(pressX, pressY, Mouses.get(i+1).get(0), Mouses.get(i+1).get(1));
        if (dM>px(lensD+space)) {
          for (int j=0; j<Stones.size(); j++) {//他の全ての石との当たり判定
            dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), Mouses.get(i+1).get(0), Mouses.get(i+1).get(1));
            if (dS<px(Stones.get(j).get(5)/2.0+Mouses.get(i+1).get(5)/2.0+space)) {
              CD=false;
            }
          }

          if (CD==true) {//他の石と被らなければ，石の座標を登録
            noFill();
            ellipse(Mouses.get(i+1).get(0), Mouses.get(i+1).get(1), px(lensD), px(lensD));
            ArrayList<Float> Stone=new ArrayList<Float>();//一時保存
            Stone.add(Mouses.get(i+1).get(0));
            Stone.add(Mouses.get(i+1).get(1));
            Stone.add(Mouses.get(i+1).get(2));//描画順
            Stone.add(0.0);//選択チェック
            Stone.add(float(selectCol));//石の種類
            Stone.add(Mouses.get(i+1).get(5));//石の直径
            Stones.add(Stone);
            drawingStone++;
          }
        }
      }
    }
}
