public Triangle GetTriangleShareEdge(Triangle ABC, Edge AB, ArrayList<Triangle> triangles)
{
  Triangle ADB = ABC;//仮置
  PVector A = AB.start;
  PVector B = AB.end;

  boolean detected = false;
  ArrayList<Triangle> S = new ArrayList<Triangle>();

  while (triangles.size() > 0)
  {
    Triangle checking = triangles./*pop*/remove(0);
    //三角形がABを含むものかを調べる
    if (EContains(checking, AB))
    {
      if (TIsEqual(checking, ABC))
      {
        //ABCと同じやつだった場合
        S./*push*/add(checking);
      } else
      {
        PVector D = GetVertexPoint(checking, AB);
        //color Color = checking.Color;
        ADB = new Triangle(A, D, B);
        //ADB.Color = Color;
        break;
      }
    } else
    {
      //条件に合わなかった場合
      S./*push*/add(checking);
    }
  }


  while (S.size() >0) triangles./*push*/add(S.remove(0)/*pop()*/);

  return ADB;
}

public Triangle GetTriangleShareEdgeND(Triangle ABC, Edge AB, ArrayList<Triangle> triangles)
{
  Triangle ADB = ABC;//仮置
  PVector A = AB.start;
  PVector B = AB.end;

  for (Triangle checking : triangles)
  {
    //三角形がABを含むものかを調べる
    if (EContains(checking, AB) && !TIsEqual(checking, ABC))
    {
      PVector D = GetVertexPoint(checking, AB);
      // Color = checking.Color;
      ADB = new Triangle(A, D, B);
      //ADB.Color = Color;
      break;
    }
  }
  return ADB;
}