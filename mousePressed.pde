void mousePressed() {
    if(stop==0){
    if(Fy < mouseY &&  mouseY < Fy + Fh) {
        if (Fx < mouseX &&  mouseX < Fx + Fw) {
            file = 1;//save
        } else if (Fx + Fw < mouseX &&  mouseX < Fx + Fw * 2) {
            file = 2;//output
        }
}

// //back
// if(Fy+5 < mouseY &&  mouseY < Fy+5 + Fh) {
//     if(5< mouseX &&  mouseX < 5 + Fw) {
//         // int dif=backnum.get(backnum.size()-1)-backnum.get(backnum.size()-2);
//         for(int i=backnum.get(backnum.size()-2);i<Stones.size();i++){
//             Stones.remove(backnum.get(backnum.size()-2));
//     }
//     backnum.remove(backnum.size()-1);
//     // backnum.remove(backnum.get(backnum.size()-1));
//     //println(backnum.get(backnum.size()-1));
// }
// }
    
    //pattern
    /*if (Py<mouseY&&mouseY<Py+Ph*2) {
    if (Px<mouseX&&mouseX<Px+Pw*7) {  */
    
    //pattern
    for (int j = 0; j < 1; j++) {
        for (int i = 0; i < 14; i++) {
           if (Px + Pw * i < mouseX &&  mouseX < Px + Pw * i + Pw) {
                if (Py + Ph * j < mouseY &&  mouseY < Py + Ph * j + Ph) {
                    selectCol = i + j * 7;
                }
        }
        }
}
    
    if(tool ==  0) {
        for (int i = 0; i < Stones.size(); i++) {//選択されたかの判定
           if (Stones.get(i).get(0) - px(Stones.get(i).get(5)) / 2.0<mouseX &&  mouseX<Stones.get(i).get(0) + px(Stones.get(i).get(5)) / 2.0) {
                if (Stones.get(i).get(1) - px(Stones.get(i).get(5)) / 2.0<mouseY &&  mouseY<Stones.get(i).get(1) + px(Stones.get(i).get(5)) / 2.0) {
                    pick = i;
                }
        }
        }
}
    
    if(tool ==  3) {
       if (Dx + 0 < mouseX &&  mouseX < Dx + Dw) {
            if (Dy + 0 < mouseY &&  mouseY < Dy + Dh) {
                StoneFill2();     
        }
        }
}
    }
}

void mouseClicked(){
//back
if(stop==0){
if(Fy+5 < mouseY &&  mouseY < Fy+5 + Fh) {
    if(5< mouseX &&  mouseX < 5 + Fw) {
        starttime=time;
        //println(abs(endtime-starttime));
        if(abs(endtime-starttime)>10){
        // int dif=backnum.get(backnum.size()-1)-backnum.get(backnum.size()-2);
        // println(backnum.get(backnum.size()-2)+","+Stones.size());
        for(int i=backnum.get(backnum.size()-2);i<backnum.get(backnum.size()-1);i++){
            Stones.remove(backnum.get(backnum.size()-2));
    }
    backnum.remove(backnum.size()-1);
        }
    endtime=time;
    // backnum.remove(backnum.get(backnum.size()-1));
    //println(backnum.get(backnum.size()-1));
}
}
}
}