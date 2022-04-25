//
//  games.swift
//  selesai
//
//  Created by User12 on 2022/4/15.
//

import SwiftUI

struct games: View {
    @Binding var showgames: Bool
   //@State private var showSecondView = false
    @Binding var keyboard = [String]()
    @Binding var keyboard_color = [Color]()
    @Binding var numbers = [NumberData]()
    @State var showAlert = false
    @State var alertTitle = ""
    @State private var showResultView = false
    @Binding var lose: Int //戰敗為2,勝利為1 //ada di result binding
    @State var win: Int = 0
    @Binding var result_color: String = "" // ada di result binding
    @Binding var nowindex :Int
    @Binding  var guesstime: Int
    @Binding var answer: String
    @Binding var scale: Double
    @Binding var finishedrow : Int
    var body: some View {
        HStack{
           
            Button("Plz"){
                var co = 0
                for index in answer.indices{
                    if co == nowindex{
                        WriteChar(w: String(answer[index]))
                        break
                    }
                    co += 1
                }
            }.foregroundColor(Color.purple)
        }

        ZStack{
            let columns = Array(repeating: GridItem(), count: Int(scale))
            LazyVGrid(columns: columns){
                ForEach(numbers){number in
                    ZStack{
                        Rectangle().foregroundColor(number.color)
                            .frame(height: 50)
                            .padding(5)
                        Text("\(number.value)")
                    }
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(alertTitle))
            })
           
            if lose == 1{
                Button("CORRECT"){
                    showResultView = true
                }
                .font(.largeTitle)
                .fullScreenCover(isPresented: $showResultView, content:{ResultView(showResultView: $showResultView,result_color:$result_color,lose:$lose,scale:$scale)})
            }
            else if lose == 2{
                Button("LOSE"){
                    showResultView = true
                }
                .font(.largeTitle)
                .fullScreenCover(isPresented: $showResultView, content:{ResultView(showResultView: $showResultView,result_color:$result_color,lose:$lose,scale:$scale)})
            }
        }
        
    }
    func ReadFile(scale: Int){
        if (scale == 4){
            if let asset = NSDataAsset(name: "four"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                answer = String(array[num])
            }
        }
        else if (scale == 5){
            if let asset = NSDataAsset(name: "five"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                answer = String(array[num])
            }
        }
        else if (scale == 6){
            if let asset = NSDataAsset(name: "six"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                answer = String(array[num])
            }
        }
    }
    
    //初始化格子
    func InitialNumbers(){
        numbers = []
        result_color = ""
        for _ in 1...Int(scale)*guesstime{
            let number = ""
            numbers.append(NumberData(value: number))
        }
    }
    
    //更新格子
    func UpdateNumbers(){
        numbers = []
        result_color = ""
        for _ in 1...Int(scale)*guesstime{
            let number = ""
            numbers.append(NumberData(value: number))
        }
    }
    
   
    func UpdateGuess(guess: Int){
        guesstime = guess
    }
    //填上文字
    func WriteChar(w:String)->(){
        //AudioServicesPlaySystemSound(1026)
        if nowindex % Int(scale) != (Int(scale) - 1){
            numbers[nowindex].value = w
            nowindex += 1
        }
        else{
            numbers[nowindex].value = w
        }
    }
    
    //判斷Enter結果
    func EnterJudge(){
        if nowindex % Int(scale) == (Int(scale) - 1) && numbers[nowindex].value != ""{
            finishedrow += 1
            nowindex += 1
            var correct: Int = 0
            for i in nowindex-Int(scale)..<nowindex{
                var co: Int = 0
                for index in answer.indices{
                    if numbers[i].value == String(answer[index]){
                        numbers[i].color = .yellow
                        if i % Int(scale) == co{
                            numbers[i].color = .green
                            correct += 1
                            break
                        }
                    }
                    co += 1
                    if co == Int(scale) && numbers[i].color == .gray{
                        numbers[i].color = .red
                    }
                }
                for j in 0..<keyboard_color.count{
                    for k in 0..<keyboard_color[j].count{
                        if keyboard[j][k] == numbers[i].value{
                            if keyboard_color[j][k] != .green && keyboard_color[j][k] != .red{
                                keyboard_color[j][k] = numbers[i].color
                            }
                        }
                    }
                }
            }
            if correct == Int(scale){
                //顯示勝利
                //showAlert = true
                //alertTitle = "correct"
                for i in 0..<Int(scale)*guesstime{
                    if numbers[i].color == Color.yellow{
                        result_color += "2"
                    }
                    else if numbers[i].color == Color.green{
                        result_color += "1"
                    }
                    else {
                        result_color += "0"
                    }
                }
                lose = 1
                win += 1
            }
            else if finishedrow == guesstime{
                //showAlert = true
                for i in 0..<Int(scale)*guesstime{
                    if numbers[i].color == Color.yellow{
                        result_color += "2"
                    }
                    else if numbers[i].color == Color.green{
                        result_color += "1"
                    }
                    else {
                        result_color += "0"
                    }
                }
                lose = 2
                //alertTitle = "answer is \(answer)"
            }
            else{
                var exp:Int = 0
                for i in nowindex-Int(scale)..<nowindex{
                    if numbers[i].color == .red{
                        exp += 1
                    }
                }
                if exp == Int(scale){
                    showAlert = true
                    alertTitle = "not in word list"
                }
            }
        }
        else{
            showAlert = true
            alertTitle = "Not enough letters"
        }
    }
    
    //刪除
    func BackSpace(){
        if nowindex % Int(scale) != 0{
            numbers[nowindex].value = ""
            nowindex -= 1
        }
        else{
            numbers[nowindex].value = ""
        }
    }
    
}

struct games_Previews: PreviewProvider {
    static var previews: some View {
        games(showgames:.constant(true),scale:.constant(4),BackSpace:.constant())
      
    }
}
