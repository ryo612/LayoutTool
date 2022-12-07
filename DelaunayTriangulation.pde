public class DelaunayTriangulation
{
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<Triangle> diagram = new ArrayList<Triangle>();
  Triangle superTriangle;

  public DelaunayTriangulation()
  {
    superTriangle = GenerateSuperTriangle();
    diagram.add(superTriangle);
  }

  void Draw()
  {
    //superTriangle.Draw();
    for (PVector p : points) Point(p.x, p.y);
    for (Triangle t : diagram)
    {
      switch(dispMode) {
      case 0:
        //Voronoi 
        // Line(t.circum.center, GetTriangleShareEdgeND(t, t.AB, diagram).circum.center);
        // Line(t.circum.center, GetTriangleShareEdgeND(t, t.BC, diagram).circum.center);
        // Line(t.circum.center, GetTriangleShareEdgeND(t, t.CA, diagram).circum.center);
        Line(GetCircumscribedCircle(t).center, GetCircumscribedCircle(GetTriangleShareEdgeND(t, t.AB, diagram)).center);
        Line(GetCircumscribedCircle(t).center, GetCircumscribedCircle(GetTriangleShareEdgeND(t, t.BC, diagram)).center);
        Line(GetCircumscribedCircle(t).center, GetCircumscribedCircle(GetTriangleShareEdgeND(t, t.CA, diagram)).center);
        break;
      case 1:
        t.TDraw();
        break;
      default:
        t.TDraw();
        noFill();
        stroke(CContains(GetCircumscribedCircle(t), new PVector(mouseX, mouseY))? #F00000 : #000000, 100);
        stroke(CContains(GetCircumscribedCircle(t), new PVector(mouseX, mouseY))? #F00000 : #A0A0A0, 100);
        GetCircumscribedCircle(t).CDraw();
        break;
      }
    }
  }

  float[] Area(PVector p) {
    float xg=0;//重心のx座標
    float yg=0;//重心のy座標
    float[] newpoint={0, 0};

    ArrayList<PVector> area=new ArrayList<PVector>();//p(ラインストーンの中心)を囲むボロノイ図の点を格納するリスト
    for (Triangle t : diagram) {
      if (CContains(GetCircumscribedCircle(t), new PVector(p.x, p.y))) {
              //println("0k"); 
        if (0<GetCircumscribedCircle(t).center.x&&GetCircumscribedCircle(t).center.x<displayW) {
          if (0<GetCircumscribedCircle(t).center.y&&GetCircumscribedCircle(t).center.y<displayH) {
            //Point(GetCircumscribedCircle(t).center.x, GetCircumscribedCircle(t).center.y);
            area.add(GetCircumscribedCircle(t).center);
          }
        }
      }
    }

    for (int i=0; i<area.size(); i++) {//重複の削除
      for (int j=0; j<area.size(); j++) {
        if (i!=j) {
          if (area.get(i).equals(area.get(j))) {
            area.remove(j);
          }
        }
      }
    }

    if (area.size()>0) {
      PVector left=area.get(0);

      for (int i=0; i<area.size(); i++) {//一番左の頂点を探す
        if (left.x>area.get(i).x) {
          left=area.get(i);
        }
        if (left.x==area.get(i).x) {
          if (left.y>area.get(i).y) {
            left=area.get(i);
          }
        }
      }

      int check=0;
      float[][] areaangle=new float[area.size()][3];
      for (int i=0; i<area.size(); i++) {//それぞれの基準点からの角度を格納，基準点は0
        areaangle[i][0]=area.get(i).x;
        areaangle[i][1]=area.get(i).y;
        areaangle[i][2]=degrees(atan2(area.get(i).x-left.x, area.get(i).y-left.y));//角度
        if (ceil(areaangle[i][2])%30==0||ceil(areaangle[i][2])%30==1) {
          check++;
        }
      }

      //if (check==areaangle.length) {//正六角形の除外
      //  newpoint[0]=0;
      //  newpoint[1]=0;
      //} else {

      float[] stock;
      for (int i=0; i<areaangle.length-1; i++) {//角度が小さi順にソート
        for (int j=0; j<areaangle.length-1-i; j++) {
          if (areaangle[j][2]>areaangle[j+1][2]) {
            stock=areaangle[j];
            areaangle[j]=areaangle[j+1];
            areaangle[j+1]=stock;
          }
        }
      }
      //for (int i=0; i<areaangle.length; i++) {
      //  println(ceil(areaangle[i][2]));
      //}
      //println("^^^^^^"); 

      float[][] S=new float[areaangle.length][3];//各三角形の重心のx,y,面積
      float St=0;//多角形の面積

      for (int i=0; i<S.length-1; i++) {
        S[i][0]=(areaangle[i][0]+areaangle[i+1][0])/3.0;
        S[i][1]=(areaangle[i][1]+areaangle[i+1][1])/3.0;
        S[i][2]=areaangle[i][0]*areaangle[i+1][1]-areaangle[i][1]*areaangle[i+1][0];
        St+=S[i][2];
        xg+=S[i][0]*S[i][2];
        yg+=S[i][1]*S[i][2];
      }
      S[S.length-1][0]=(areaangle[0][0]+areaangle[S.length-1][0])/3.0;
      S[S.length-1][1]=(areaangle[0][1]+areaangle[S.length-1][1])/3.0;
      S[S.length-1][2]=areaangle[S.length-1][0]*areaangle[0][1]-areaangle[S.length-1][1]*areaangle[0][0];
      St+=S[S.length-1][2];
      xg+=S[S.length-1][0]*S[S.length-1][2];
      yg+=S[S.length-1][1]*S[S.length-1][2];

      xg=xg/St;
      yg=yg/St;

      //Point(xg, yg);
      newpoint[0]=xg;
      newpoint[1]=yg;
    }
    //}
    return newpoint;
  }

  void AddPoint(PVector p)
  {
    //points.clear();
    points.add(p);
    Triangulation(p);
  }

  //void test(){
  // println(diagram); 
  //}

  void ClearPoint() {
    points.clear();
    diagram.clear();
    superTriangle = GenerateSuperTriangle();
    diagram.add(superTriangle);
  }

  void Finalize()
  {
    //diagramから、superTriangleの各頂点を含む三角形を除外する
    ArrayList<Triangle> S = CopyStackOf(diagram);
    diagram.clear();
    while (S.size()>0)
    {
      //Triangle checking = S.pop();
      Triangle checking = S.remove(0);
      if (!IsSharingPoint(checking, superTriangle))
      {
        diagram./*push*/add(checking);
      }
    }
  }

  void Triangulation(PVector p)
  {
    //diagramと同じ内容のスタックを組む。
    ArrayList<Triangle> baseTriangles = CopyStackOf(diagram);

    //分割後の三角形を格納するスタック
    ArrayList<Triangle> newTriangles = new ArrayList<Triangle>();

    //pを含む三角形ABCを探す
    Triangle ABC = IsInsideOfTriangle(baseTriangles, p);

    for (Triangle t : Divide(baseTriangles, ABC, p)) newTriangles./*push*/add(t);

    while (baseTriangles.size()>0) newTriangles./*push*/add(baseTriangles.remove(0)/*pop()*/);

    //新しい三角形達でdiagramを更新
    diagram = CopyStackOf(newTriangles);
  }

  ArrayList<Triangle> Divide(ArrayList<Triangle> baseTriangles, Triangle checking, PVector p)
  {
    //pがABCの内側にあるため、ABP, BCP, CAPに分割
    ArrayList<Triangle> divided = new ArrayList<Triangle>();
    divided./*push*/add(new Triangle(checking.A, checking.B, p));
    divided./*push*/add(new Triangle(checking.B, checking.C, p));
    divided./*push*/add(new Triangle(checking.C, checking.A, p));

    ArrayList<Triangle> newTriangles = new ArrayList<Triangle>();
    //新しくできた三角形の集合dividedに対して処理を行っていく。
    //三角形をABPとして考える。pの対角辺である辺ABを共有する三角形ADBをbaseTrianglesから探す。
    //戻すトライアングル
    while (divided.size()>0)
    {
      Triangle ABC = divided.remove(0);/*pop();*/
      Edge AB = GetOppositeEdge(ABC, p);
      Triangle ADB = GetTriangleShareEdge(ABC, AB, baseTriangles);
      if (TIsEqual(ABC, ADB))
      {
        //println("isnt special");
        newTriangles./*push*/add(ABC);
        //println(PIsEqual(p, GetVertexPoint(ADB, AB)));
        //println(TIsEqual(ABC, ADB));
        continue;
      }

      PVector D = GetVertexPoint(ADB, AB);
      if (TContains(ABC, D))
      {
        //FLIP
        //println("flip");
        ArrayList<Triangle> FlipedTriangles = Flip(ADB, AB, p);
        for (Triangle t : FlipedTriangles) divided./*push*/add(t);
      } else
      {
        //println("call");
        newTriangles./*push*/add(ABC);
        newTriangles./*push*/add(ADB);
      }
    }

    return newTriangles;
  }

  ArrayList<Triangle> Flip(Triangle ADB, Edge AB, PVector p)
  {
    ArrayList<Triangle> FlipedTriangles = new ArrayList<Triangle>();

    PVector D = GetVertexPoint(ADB, AB);
    PVector A = AB.start;
    PVector B = AB.end;

    FlipedTriangles./*push*/add(new Triangle(A, D, p));
    FlipedTriangles./*push*/add(new Triangle(D, B, p));

    return FlipedTriangles;
  }

  ArrayList<Triangle> CopyStackOf(ArrayList<Triangle> stack)
  {
    ArrayList<Triangle> returnTriangles = new ArrayList<Triangle>();

    for (Triangle item : stack)
    {
      returnTriangles./*push*/add(item);
    }
    return returnTriangles;
  }
}