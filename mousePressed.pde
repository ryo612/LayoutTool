void mousePressed() {
    if(Fy < mouseY &&  mouseY < Fy + Fh) {
        if (Fx < mouseX &&  mouseX < Fx + Fw) {
            file = 1;//save
        } else if (Fx + Fw < mouseX &&  mouseX < Fx + Fw * 2) {
            file = 2;//output
        }
}
    
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
