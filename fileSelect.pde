void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String path =selection.getPath();
    csv = createWriter(path+"/StoneData/stone.csv");

    for (int i=0; i<Stones.size()-1; i++) {
      csv.print(Stones.get(i).get(0));
      csv.print(",");
    }
    csv.println(Stones.get(Stones.size()-1).get(0));

    for (int i=0; i<Stones.size()-1; i++) {
      csv.print(Stones.get(i).get(1));
      csv.print(",");
    }
    csv.println(Stones.get(Stones.size()-1).get(1));

    for (int i=0; i<Stones.size()-1; i++) {
      csv.print(Stones.get(i).get(5)/2);
      csv.print(",");
    }
    csv.println(Stones.get(Stones.size()-1).get(5)/2);

    for (int i=0; i<Stones.size()-1; i++) {
      csv.print(Stones.get(i).get(4));
      csv.print(",");
    }
    csv.println(Stones.get(Stones.size()-1).get(4));

    csv.flush();
    csv.close();
    boolean a=false;
    for (int i=0; i<iconP.length; i++) {
      for (int j=0; j<Stones.size()-1; j++) {
        if (Stones.get(j).get(4)==i) {
          a=true;
        }
        if (a) {
          iconP[i].save(path+"/StoneData/P"+i+".png");
        }
        a=false;
      }
    }
  }
}

/*//ファイル選択画面、選択ファイルパス取得の処理 
 String getFileName(){
 //処理タイミングの設定 
 SwingUtilities.invokeLater(new Runnable() { 
 public void run() {
 try {
 //ファイル選択画面表示 
 JFileChooser fc = new JFileChooser(); 
 int returnVal = fc.showOpenDialog(null);
 //「開く」ボタンが押された場合
 if (returnVal == JFileChooser.APPROVE_OPTION) {
 //選択ファイル取得 
 File file = fc.getSelectedFile();
 //選択ファイルのパス取得 
 getFile = file.getPath(); 
 } 
 }
 //上記以外の場合 
 catch (Exception e) {
 //エラー出力 
 e.printStackTrace(); 
 } 
 } 
 } 
 );
 //選択ファイルパス取得
 return getFile; 
 }*/
