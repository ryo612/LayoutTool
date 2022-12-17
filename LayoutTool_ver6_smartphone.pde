/* @pjs preload="tool_0.png, tool_1.png, tool_2.png, tool_3.png, tool_0_icon.png, tool_1_icon.png, tool_2_icon.png, tool_3_icon.png, P0.png, P2.png, P3.png, P4.png, P5.png, P6.png, P7.png, P8.png, P9.png, P10.png, P11.png, P12.png, P13.png, download.png, back.png, nekome.png"; */

DelaunayTriangulation diagram;
int dispMode = 0;

int time=0;
int starttime=0;
int endtime=0;
int stop=0;

String getFile = null;

PrintWriter csv; 
String filename = "backdata.txt";

ArrayList<Integer> backnum=new ArrayList<Integer>();
ArrayList<ArrayList<Float>> Mouses=new ArrayList<ArrayList<Float>>();
//[x,y,描画順,選択チェック,石の種類，石の直径]
ArrayList<ArrayList<Float>> MOUSE=new ArrayList<ArrayList<Float>>();
int mouseCouunt=0;
ArrayList<ArrayList<Float>> Stones=new ArrayList<ArrayList<Float>>();//石の情報

float releaseNum=0;
float drawCount=0;
float select=-1;
//ArrayList<Float> selects=new ArrayList<Float>();
int drawingStone=0;
int fillstone=0;
int backstart=0;
int backend=0;
int backcount=0;

float pressX=0;
float pressY=0;
float lensD=3*2;//レンズ直径mm(見掛け)
float space=0.2;
float zoom=2;
float scaling=0.25;//拡大率(高解像度仕様)
float lineWeight=px(1);

int displayW=innerWidth;
int displayH=innerHeight;
//クリック範囲
//draw
float Dx=0;
float Dy=0;
float Dw=0;
float Dh=0;
//Tool
float Tx=0;
float Ty=0;
float Tw=0;
float Th=0;
//file
float Fx=0;
float Fy=0;
float Fw=0;
float Fh=0;
int file=0;//1=save, 2=output

//pattern
float Px=0;
float Py=0;
float Pw=0;
float Ph=0;
int[][][] COLOR={ //https://materialui.co/colors/
  {{240, 0, 20}, {255, 138, 128}, {253, 216, 53}}, //red
  {{236, 64, 122}, {244, 143, 177}, {253, 216, 53}}, //pink
  {{224, 64, 251}, {234, 128, 252}, {253, 216, 53}}, //lightpurple
  {{156, 39, 176}, {206, 147, 216}, {253, 216, 53}}, //purple
  {{63, 81, 181}, {159, 168, 218}, {253, 216, 53}}, //blue
  {{3, 169, 244}, {129, 212, 250}, {253, 216, 53}}, //lightblue
  {{24, 255, 255}, {0, 172, 193}, {253, 216, 53}}, //bluegreen
  {{0, 150, 136}, {128, 203, 196}, {253, 216, 53}}, //green
  {{139, 195, 74}, {51, 105, 30}, {253, 216, 53}}, //lightgreen
  {{255, 235, 59}, {255, 111, 0}, {253, 216, 53}}, //yellow
  {{251, 140, 0}, {255, 204, 128}, {253, 216, 53}}, //orange
  {{109, 76, 65}, {188, 170, 164}, {253, 216, 53}}, //brown
  {{158, 158, 158}, {66, 66, 66}, {253, 216, 53}}, //grey
  {{0, 0, 0}, {189, 189, 189}, {253, 216, 53}}//black
};
int selectCol=0;//選択中のパターン

float PSx=0;
float PSy=0;
float PSw=0;
float PSh=0;

PImage[] tImage=new PImage[4];
PImage[] tImageIcon=new PImage[4];
PGraphics[] iconP=new PGraphics[14];
PImage[] pImage=new PImage[14];
PImage dImage;
PImage back;

int tool=1;//0-select, 1-pen
int pick=-1;

void setup() {
  //frameRate(60);
  size(displayW,displayH/*,P2D*/);
  diagram = new DelaunayTriangulation();
  smooth();
  //pixelDensity(displayDensity());
  //pixelDensity(I);
  Dx=10;
  Dy=50;
  Dw=displayW-35;
  Dh=displayH-180;

  Tx=Dx;
  Ty=Dy+Dh+25;
  Tw=displayW/10;
  Th=displayW/10;

  Fw=displayW/10;
  Fh=displayW/10;
  Fx=displayW-Fw-25;
  Fy=0;

  Pw=displayW/15;
  Ph=displayW/15;
  //Px=Dx+Dw+30;
  Px=/*displayW-Pw*5-25*/Tx;
  Py=/*Dy+Dh+50*/Ty+Th+5;

  //直径バー
  PSw=displayW/2-40;
  PSh=10;
  PSx=displayW-PSw-25;
  PSy=Dy+Dh+40;


  // for (int j=0; j<7*2; j++) {//カーソル用のパターン保存
  //   iconP[j] = createGraphics(100, 100);
  //   iconP[j].beginDraw();
  //   iconP[j].background(0, 0, 0, 0); 
  //   iconP[j].noStroke();
  //   for (int i=0; i<8; i++) {
  //     if (i%2==0) {
  //       iconP[j].fill(COLOR[j][0][0], COLOR[j][0][1], COLOR[j][0][2]);
  //     } else if (i%4==1) {
  //       iconP[j].fill(COLOR[j][1][0], COLOR[j][1][1], COLOR[j][1][2]);
  //     } else {
  //       iconP[j].fill(COLOR[j][2][0], COLOR[j][2][1], COLOR[j][2][2]);
  //     }
  //     iconP[j].arc(50, 50, 100, 100, radians(0+i*45), radians(45+i*45));
  //     iconP[j].fill(COLOR[j][0][0], COLOR[j][0][1], COLOR[j][0][2]);
  //     iconP[j].ellipse(50, 50, 100/2.5, 100/2.5);
  //   }
  //   iconP[j].endDraw();
  //   //println(COLOR[j][0][0]);
  //   iconP[j].save("data/P"+j+".png");
  // }


  tImage[0]=loadImage("tool_0.png");
  tImage[1]=loadImage("tool_1.png");
  tImage[2]=loadImage("tool_2.png");
  tImage[3]=loadImage("tool_3.png");
  tImageIcon[0]=loadImage("tool_0_icon.png");
  tImageIcon[1]=loadImage("tool_1_icon.png");
  tImageIcon[2]=loadImage("tool_2_icon.png");
  tImageIcon[3]=loadImage("tool_3_icon.png");
  dImage=loadImage("download.png");
  back=loadImage("back.png");
  for (int i=0; i<tImage.length; i++) {
    tImageIcon[i].resize(15, 15);
  }

  for (int i=0; i<13; i++) {
    pImage[i]=loadImage("P"+i+".png");
  }
  pImage[13]=loadImage("nekome.png");


  ArrayList<Float> Mouse=new ArrayList<Float>();//一時保存
  Mouse.add(-1.0);
  Mouse.add(-1.0);
  Mouse.add(drawCount);//描画順
  Mouse.add(0.0);//選択チェック
  Mouse.add(-1.0);//石の種類
  Mouse.add(lensD);//石の直径
  Mouses.add(Mouse);

  backnum.add(0);
  //backnum.add(0);
}

void Point(float x, float y)
{
  strokeWeight(3);
  ellipse(x, y, 1, 1);
}

float puramai(float a, float b) {
  if (a-b<=0) {
    return 1.0;
  } else {
    return -1.0;
  }
}

float px(float a) {//mm→px
  return a*72/25.4;
}

void draw() {
  //println(tool);
  background(255);

  //保存
  if (file==1) {
    //save();
    
    //String imgPath = selectInput("Select a file to process:", "fileSelected");
    //selectInput("Select a file to process:", "fileSelected");
    //selectFolder("保存するディレクトリを選択してください","fileSelected");
    //println(getFileName());
    
    //csv = createWriter("stone.csv");
    
    
    //exit();
    //println(5);
    /*String savefile = "save.txt";
    PrintWriter output = createWriter(savefile);
    String saves = "Howdy Howdy!\nSave to text file by createWrite";
    output.println(saves);
    output.flush();
    output.close();
    exit();*/
    
  }

  //見かけ上の描画
  noStroke();
  fill(255);
  rect(0, 0, width, height);

  //マウス(描画)
  if (mousePressed) {

    //draw
    if (Dx<mouseX&&mouseX<Dx+Dw) {
      if (Dy<mouseY&&mouseY<Dy+Dh) {

        if (tool==0) {//選択ツール
        float dS;//ストーン座標との距離
          boolean CD=true;
          if (pick>=0) {
            /*for (int j=0; j<Stones.size(); j++) {//他の全ての石との当たり判定
              dS=dist(Stones.get(j).get(0), Stones.get(j).get(1), mouseX, mouseY);
              if (dS<px(Stones.get(j).get(5)+space)) {
                CD=false;
              }
            }*/
            if (CD) {
              //println("ok");
              Stones.get(pick).set(0, float(mouseX));
              Stones.get(pick).set(1, float(mouseY));
            }
          }
        }

        if (tool==1) {//ペンツール
          pressX=float(mouseX);
          pressY=float(mouseY);
          float ppressX=Mouses.get(Mouses.size()-1).get(0);//前の
          float ppressY=Mouses.get(Mouses.size()-1).get(1);
          float dM=dist(ppressX, ppressY, pressX, pressY);//1つ前のマウス位置との距離

          if (Mouses.get(Mouses.size()-1).get(2)==drawCount) {
            if (Mouses.get(Mouses.size()-1).get(0)>0) {
              //MOUSE.add(Mouses.get(j));//今のを保存
              int div=int(dM/px(1));//何分割できるか
              if (div>1) {
                for (int i=0; i<div-1; i++) {//分割分の点座標を追加
                  float ratio=float(i)/float(div);
                  ArrayList<Float> M=new ArrayList<Float>();//一時保存
                  M.add(lerp(ppressX, pressX, ratio));
                  M.add(lerp(ppressY, pressY, ratio));
                  M.add(drawCount);//描画順
                  M.add(0.0);//選択チェック
                  M.add(-1.0);//石の種類
                  M.add(lensD);//石の直径
                  Mouses.add(M);
                }
              }
            }
          }

          ArrayList<Float> Mouse=new ArrayList<Float>();//一時保存
          Mouse.add(pressX);
          Mouse.add(pressY);
          Mouse.add(drawCount);//描画順
          Mouse.add(0.0);//選択チェック
          Mouse.add(-1.0);//石の種類
          Mouse.add(lensD);//石の直径
          Mouses.add(Mouse);

          stone(space);

          //描画時の線
          //if (Mouses.size()!=0) {
          /*stroke(180);
           strokeWeight(lineWeight);
           for (int i=int(releaseNum); i<Mouses.size()-1; i++) {
           if (Mouses.get(i).get(0)>0&&Mouses.get(i+1).get(0)>0) {
           line(Mouses.get(i).get(0), Mouses.get(i).get(1), Mouses.get(i+1).get(0), Mouses.get(i+1).get(1));
           }
           }
           //}
           strokeWeight(1);*/
        }

        if (tool==2) {//消しゴム
          for (int i=0; i<Mouses.size(); i++) {
            if (mouseX-px(lensD)<Mouses.get(i).get(0)&&Mouses.get(i).get(0)<mouseX+px(lensD)) {
              if (mouseY-px(lensD)<Mouses.get(i).get(1)&&Mouses.get(i).get(1)<mouseY+px(lensD)) {
                Mouses.remove(i);
              }
            }
          }
          for (int i=0; i<Stones.size(); i++) {
            if (mouseX-px(lensD)<Stones.get(i).get(0)&&Stones.get(i).get(0)<mouseX+px(lensD)) {
              if (mouseY-px(lensD)<Stones.get(i).get(1)&&Stones.get(i).get(1)<mouseY+px(lensD)) {
                Stones.remove(i);
              }
            }
          }
          float drawNum=0;
          if (tool==2) {//消しゴムで描画順の更新
            for (int i=0; i<Mouses.size()-1; i++) {
              if (dist(Mouses.get(i).get(0), Mouses.get(i).get(1), Mouses.get(i+1).get(0), Mouses.get(i+1).get(1))>px(lensD)) {
                drawNum++;
              }
              Mouses.get(i+1).set(2, drawNum);
            }
          }
        }
      }
    }

    //直径バー

    float dm=dist(PSx, PSy, PSx+PSw, PSy)/18;
    if (PSy-PSh<mouseY&&mouseY<PSy+PSh) {
      for (int i=0; i<19; i++) {
        if (PSx+dm*i-dm/2.0<mouseX&&mouseX<PSx+dm*i+dm/2.0) {
          lensD=(1.0+0.5*i)*zoom;
        }
      }
    }

    //toolの番号
    for (int i=0; i<tImage.length; i++) {
      if (Tx+Tw*i<mouseX&&mouseX<Tx+Tw*i+Tw) {
        if (Ty<mouseY&&mouseY<Ty+Th) {
          tool=i;
        }
      }
    }
  }

  UI();

  for (int i=0; i<Stones.size(); i++) {
    if (Stones.get(i).get(4)!=-1.0) {
      // pattern(Stones.get(i).get(0), Stones.get(i).get(1), px(Stones.get(i).get(5)), COLOR, int(Stones.get(i).get(4)));
      // stroke(0);
      // strokeWeight(0);
      // noFill();
      // ellipse(Stones.get(i).get(0), Stones.get(i).get(1), px(Stones.get(i).get(5)), px(Stones.get(i).get(5)));
      image(pImage[int(Stones.get(i).get(4))],Stones.get(i).get(0)-px(Stones.get(i).get(5))/2,Stones.get(i).get(1)-px(Stones.get(i).get(5))/2,px(Stones.get(i).get(5)),px(Stones.get(i).get(5)));
    }
  }

  //Cursor();

  // String lines = loadStrings(filename);
  // String back = lines+","+Stones.size();
  // //lines+=","+Stone.size();
  // println(back);
  // String[] list = split(back, ',');
  // saveStrings(backdata, list);
  //printArray(backnum);

  time++;
  
}

float test(){
  String data="";
  for (int i=0; i<Stones.size()-1; i++) {
      data+=Stones.get(i).get(0)+",";
  }
  data+=Stones.get(Stones.size()-1).get(0)+"\n";

  for (int i=0; i<Stones.size()-1; i++) {
      data+=Stones.get(i).get(1)+",";
  }
  data+=Stones.get(Stones.size()-1).get(1)+"\n";

  for (int i=0; i<Stones.size()-1; i++) {
      data+=Stones.get(i).get(5)/2.0+",";
  }
  data+=Stones.get(Stones.size()-1).get(5)/2.0+"\n";

  for (int i=0; i<Stones.size()-1; i++) {
      data+=Stones.get(i).get(4)+",";
  }
  data+=Stones.get(Stones.size()-1).get(4)+"\n";
  return data;
}

float[] download(){
  float[] F={Fx,Fy,Fw,Fh};
  return F;
}

void mouseReleased() {//図形を描き終わった判定
if(tool==1||tool==3){
  boolean backcheck=true;
    for(int i=0;i<backnum.size();i++){
      if(Stones.size()==backnum.get(i)){
        backcheck=false;
      }
    }

    if(backcheck){
      backnum.add(int(Stones.size()));
    }
  String S=backnum.get(0)+"";
  for(int i=1;i<backnum.size();i++){
    S+=","+backnum.get(i);
  }
  // println(S);
  //}
}




  if (Dx<mouseX&&mouseX<Dx+Dw) {
    if (Dy<mouseY&&mouseY<Dy+Dh) {
      drawCount++;
    }
  }

  pressX=0;
  pressY=0; 
  releaseNum=Mouses.size();
  Mouses.clear();
  ArrayList<Float> Mouse=new ArrayList<Float>();//一時保存
  Mouse.add(-1.0);
  Mouse.add(-1.0);
  Mouse.add(drawCount);//描画順
  Mouse.add(0.0);//選択チェック
  Mouse.add(-1.0);//石の種類
  Mouses.add(Mouse);
  pick=-1;
}



