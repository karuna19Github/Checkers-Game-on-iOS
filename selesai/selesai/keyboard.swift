//
//  keyboard.swift
//  selesai
//
//  Created by User12 on 2022/4/16.
//

import SwiftUI

struct keyboard: View {
    @Binding var showkeyboard:Bool
    @State var keyboard = [[String]]()
    @State var keyboard_color = [[Color]]()
    @Binding var finishedrow :Int
    @Binding var nowindex :Int
    @Binding var lose: Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    func InitialKeyboard(){
        keyboard = []
        keyboard_color = []
        finishedrow = 0
        nowindex = 0
        lose = 0
        keyboard.append(["Q","W","E","R","T","Y","U","I","O","P"])
        keyboard_color.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
        keyboard.append(["A","S","D","F","G","H","J","K","L"])
        
        keyboard_color.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
        keyboard.append(["ENTER","Z","X","C","V","B","N","M","<-"])
        
        keyboard_color.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
    }

}

struct keyboard_Previews: PreviewProvider {
    static var previews: some View {
        keyboard(showkeyboard :.constant(true),finishedrow: .constant(""))
        ResultView(showResultView: .constant(true), finishedrow: .constant(""), lose: .constant(1),scale: .constant(4))
    }
}
