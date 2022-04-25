//
//  PveView.swift
//  selesai
//
//  Created by User12 on 2022/4/22.
//

import SwiftUI
import AVFoundation
struct PveView: View {
    enum playround{
            case black, white
        }
    @Binding var showPveView:Bool
    @Binding var nowmode:gamemode
    @State var checker:[[checkers]] = Array(repeating: Array(repeating: checkers(), count: 8), count: 8)
    @State var round:playround = .white
    @State var recovery = [coordinate]()
    @State var enemys = [coordinate]()
    @State var changespot = coordinate(x: 0, y: 0)
    @State var eatspots = [coordinate]()
    @State var track: Bool = false
    @State var white_numbers: Int = 12
    @State var black_numbers: Int = 12
    @State var best_color: String = ""
    @State var black_finished: Bool = false
    @State var black_eat: Bool = false
   
    var body: some View {
        ZStack{
            Image("bintang")
                .resizable()
                .frame(width: 400,height:670)
        ScrollView {
           
        VStack(spacing:30){
            
            HStack{
                Spacer()
                Button(action: {showPveView = false}, label: {
                    
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height:30)
                        .foregroundColor(.black)
                    
                })
               
               
            }.padding(.leading, 40)
            .padding(.trailing, 30)
            Spacer()
        }
          
            VStack(spacing:10){
               
                HStack {
                    Image("robot")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                    
                    VStack {
                        HStack {
                            Text("robot")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("Computer")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text("")
                            Spacer()
                            Text("VS")
                             .foregroundColor(.white)
                            Spacer()
                            Text("")
                        }
                    }.padding(.leading, 15)
                    .padding(.trailing, 15)
                    
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 50)
                    Spacer()
                }}.padding(.leading, 10)
                .padding(.trailing, 10)
                
            
                    Button(action: {Initial()}, label: {
                        
                        Image("play2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70,height:40)
                       
                    })
                
    
                 
            VStack(spacing:40){
                Spacer()
               ZStack{
                   VStack(alignment: .center, spacing: 0.0) {
                       ForEach(0..<8) { i in
                           HStack(spacing: 0.0) {
                               ForEach(0..<8) { j in
                                   Rectangle()
                                       .frame(width: 50, height: 50)
                                       .foregroundColor(GridColor(i: i, j: j))
                               }
                           }
                       }
                   }
                   ZStack{
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .stroke(ChoicedColor(x: i, y: j),lineWidth:8)
                                           .frame(width: 42, height: 42)
                                           .opacity(ChoicedOp(x: i, y: j))
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .frame(width: 42, height: 42)
                                           .foregroundColor(checker[i][j].color)
                                           .opacity(checker[i][j].opacity)
                                           .onTapGesture {
                                               TapCheck(i: i, j: j)
                                           }
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Text("K")
                                           .padding(.all, 13.0)
                                           .frame(width: 42, height: 42)
                                           .foregroundColor(.green)
                                           .opacity(king_check(i: i, j: j))
                                   }
                               }
                           }
                       }
                       VStack{
                           if best_color != ""{
                               Button(best_color){
                                   showPveView = false
                               }.font(.largeTitle)
                           }
                       }
                   }
              
           
        
        
        }
        }
            }
    }
        }

    //AudioServicesPlaySystemSound(1026)
    func GridColor(i:Int, j:Int)->Color{
        if i % 2 == 0{
            if j % 2 == 0{
                return Color.blue
            }
            else{
                return Color.yellow
            }
        }
        else{
            if j % 2 == 0{
                return Color.yellow
            }
            else{
                return Color.blue
            }
        }
    }
    
    //初始化
    func Initial(){
    
        checker = Array(repeating: Array(repeating: checkers(), count: 8), count: 8)
        round = .white
        recovery = [coordinate]()
        enemys = [coordinate]()
        changespot = coordinate(x: 0, y: 0)
        eatspots = [coordinate]()
        track = false
        white_numbers = 12
        black_numbers = 12
        best_color = ""
        for i in 0...7{
            for j in 0...7{
                    if i < 3{
                        if i % 2 == 0{
                            if j % 2 == 0{
                                checker[i][j].color = Color.black
                                checker[i][j].opacity = 1
                            }
                        }
                        else{
                            if j % 2 == 1{
                                checker[i][j].color = Color.black
                                checker[i][j].opacity = 1
                            }
                        }
                    }
                    else if i > 4{
                        if i % 2 == 0{
                            if j % 2 == 0{
                                checker[i][j].color = Color.white
                                checker[i][j].opacity = 1
                            }
                        }
                        else{
                            if j % 2 == 1{
                                checker[i][j].color = Color.white
                                checker[i][j].opacity = 1
                            }
                        }
                    }
                }
            }
    }
    
    //選定圓環
    func ChoicedColor(x:Int, y:Int) -> Color{
        if checker[x][y].choiced == true{
            return Color.purple
        }
        else{
            return checker[x][y].color
        }
    }
    func ChoicedOp(x:Int, y:Int) -> Double{
        if checker[x][y].choiced == true{
            return 1
        }
        else{
            return 0
        }
    }
    //恢復顏色
    func RecoveryColor(){
        for rec in recovery{
            if checker[rec.x][rec.y].opacity == 0.3{
                checker[rec.x][rec.y].opacity = 0
                checker[rec.x][rec.y].color = Color.red
            }
        }
        recovery = [coordinate]()
    }
    //標記吃完敵人位子
    func AtePosition(i:Int, j:Int, roundcolor:Color, enemycolor: Color){
        if checker[i][j].color == Color.black{
            if checker[i][j].king == false{
                if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == enemycolor && checker[i+2][j-2].opacity == 0{
                    checker[i+2][j-2].color = roundcolor
                    checker[i+2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j-2))
                }
                if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == enemycolor && checker[i+2][j+2].opacity == 0{
                    checker[i+2][j+2].color = roundcolor
                    checker[i+2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j+2))
                }
            }
            else{
                if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == enemycolor && checker[i-2][j-2].opacity == 0{
                    checker[i-2][j-2].color = roundcolor
                    checker[i-2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j-2))
                }
                if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == enemycolor && checker[i-2][j+2].opacity == 0{
                    checker[i-2][j+2].color = roundcolor
                    checker[i-2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j+2))
                }
                if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == enemycolor && checker[i+2][j-2].opacity == 0{
                    checker[i+2][j-2].color = roundcolor
                    checker[i+2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j-2))
                }
                if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == enemycolor && checker[i+2][j+2].opacity == 0{
                    checker[i+2][j+2].color = roundcolor
                    checker[i+2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j+2))
                }
            }
        }
        else if checker[i][j].color == Color.white{
            if checker[i][j].king == false{
                if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == enemycolor && checker[i-2][j-2].opacity == 0{
                    checker[i-2][j-2].color = roundcolor
                    checker[i-2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j-2))
                }
                if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == enemycolor && checker[i-2][j+2].opacity == 0{
                    checker[i-2][j+2].color = roundcolor
                    checker[i-2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j+2))
                }
            }
            else{
                if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == enemycolor && checker[i-2][j-2].opacity == 0{
                    checker[i-2][j-2].color = roundcolor
                    checker[i-2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j-2))
                }
                if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == enemycolor && checker[i-2][j+2].opacity == 0{
                    checker[i-2][j+2].color = roundcolor
                    checker[i-2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i-2, y: j+2))
                }
                if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == enemycolor && checker[i+2][j-2].opacity == 0{
                    checker[i+2][j-2].color = roundcolor
                    checker[i+2][j-2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j-2))
                }
                if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == enemycolor && checker[i+2][j+2].opacity == 0{
                    checker[i+2][j+2].color = roundcolor
                    checker[i+2][j+2].opacity = 0.3
                    enemys.append(coordinate(x: i+2, y: j+2))
                }
            }
        }
    }
    
    //恢復點亮敵人
    func Brightenemy(){
        for e in enemys{
            checker[e.x][e.y].opacity = 0
            checker[e.x][e.y].color = Color.red
        }
        enemys = [coordinate]()
    }
    //恢復選定
    func NoChoiced(x:Int, y:Int){
        for i in 0...7{
            for j in 0...7{
                if i == x && j == y{
                    checker[i][j].choiced = true
                }
                else{
                    checker[i][j].choiced = false
                }
            }
        }
    }
    //恢復吃的
    func EatEmpty(){
        eatspots = [coordinate]()
    }
    
    //確認是否有能吃的
    func EatCheck(mycolor:Color,opcolor:Color){
        for i in 0...7{
            for j in 0...7{
                if mycolor == Color.black && checker[i][j].color == mycolor{
                    var tmp_index = 0
                    if checker[i][j].king == false{
                        if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == opcolor && checker[i+1][j-1].opacity == 1 && checker[i+2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == opcolor && checker[i+1][j+1].opacity == 1 && checker[i+2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if tmp_index == 1{
                            eatspots.append(coordinate(x: i, y: j))
                        }
                    }
                    else{
                        if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == opcolor && checker[i+1][j-1].opacity == 1  && checker[i+2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == opcolor && checker[i+1][j+1].opacity == 1  && checker[i+2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == opcolor && checker[i-1][j-1].opacity == 1  && checker[i-2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == opcolor && checker[i-1][j+1].opacity == 1  && checker[i-2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if tmp_index == 1{
                            eatspots.append(coordinate(x: i, y: j))
                        }
                    }
                }
                else if mycolor == Color.white && checker[i][j].color == mycolor{
                    var tmp_index = 0
                    if checker[i][j].king == false{
                        if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == opcolor && checker[i-1][j-1].opacity == 1  && checker[i-2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == opcolor && checker[i-1][j+1].opacity == 1  && checker[i-2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if tmp_index == 1{
                            eatspots.append(coordinate(x: i, y: j))
                        }
                    }
                    else{
                        if i + 2 < 8 && j - 2 >= 0 && checker[i+1][j-1].color == opcolor && checker[i+1][j-1].opacity == 1  && checker[i+2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i + 2 < 8 && j + 2 < 8 && checker[i+1][j+1].color == opcolor && checker[i+1][j+1].opacity == 1  && checker[i+2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if i - 2 >= 0 && j - 2 >= 0 && checker[i-1][j-1].color == opcolor && checker[i-1][j-1].opacity == 1  && checker[i-2][j-2].opacity == 0{
                            tmp_index = 1
                        }
                        if i - 2 >= 0 && j + 2 < 8 && checker[i-1][j+1].color == opcolor && checker[i-1][j+1].opacity == 1  && checker[i-2][j+2].opacity == 0{
                            tmp_index = 1
                        }
                        if tmp_index == 1{
                            eatspots.append(coordinate(x: i, y: j))
                        }
                    }
                }
            }
        }
    }
    func colortoround(color:Color)->playround{
        if color == Color.black{
            return .black
        }
        else{
            return .white
        }
    }
    
    func win_color(){
        if black_numbers == 0{
            best_color = "You Win"
        }
        if white_numbers == 0{
            best_color = "You Lose"
        }
    }
    
    func move_check(color:Color)->Bool{
        for i in 0...7{
            for j in 0...7{
                if color == Color.black{
                    if checker[i][j].king == false{
                        if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && checker[i + 1][j - 1].opacity == 0{
                                return true
                            }
                             if j + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                                return true
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && checker[i + 1][j - 1].opacity == 0{
                                return true
                            }
                             if j + 1 < 8 && i + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                                return true
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                                return true
                            }
                            if j + 1 < 8 && i - 1 >= 0 && checker[i - 1][j + 1].opacity == 0{
                               return true
                            }
                        }
                    }
                }
                else{
                    if checker[i][j].king == false{
                        if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                                return true
                            }
                             if j + 1 < 8 && checker[i - 1][j + 1].opacity == 0{
                                return true
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && checker[i + 1][j - 1].opacity == 0{
                                return true
                            }
                             if j + 1 < 8 && i + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                                return true
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                                return true
                            }
                            if j + 1 < 8 && i - 1 >= 0 && checker[i - 1][j + 1].opacity == 0{
                               return true
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    //點擊確認
    func TapCheck(i:Int, j:Int){
        var roundcolor: Color
        var enemycolor: Color
        switch round{
        case.black:
            roundcolor = Color.black
        case.white:
            roundcolor = Color.white
        }
        if roundcolor == Color.black{
            enemycolor = Color.white
        }
        else{
            enemycolor = Color.black
        }
        if roundcolor == Color.white{
            black_finished = false
        }
        if move_check(color: roundcolor)==false{
            if roundcolor == Color.white{
                best_color = "You Lose"
            }
            else{
                best_color = "You Win"
            }
        }
       
        if eatspots.count != 0{
            for e in eatspots{
                checker[e.x][e.y].choiced = true
            }
            if checker[i][j].choiced == true && checker[i][j].color == roundcolor && track == false{
                NoChoiced(x: i,y: j)
                Brightenemy()
                changespot = coordinate(x: i, y: j)
                AtePosition(i: i, j: j, roundcolor: roundcolor, enemycolor: enemycolor)
                if roundcolor == Color.black{
                 let ind = Int.random(in: 0...enemys.count - 1)
                    TapCheck(i: enemys[ind].x, j: enemys[ind].y)
                }
            }
            else if checker[i][j].opacity == 0.3 && checker[i][j].color == roundcolor{
                Brightenemy()
                checker[i][j].opacity = 1
                checker[i][j].color = roundcolor
                checker[changespot.x][changespot.y].color = Color.red
                checker[changespot.x][changespot.y].opacity = 0
                checker[i][j].king = checker[changespot.x][changespot.y].king
                checker[changespot.x][changespot.y].king = false
                checker[(changespot.x+i)/2][(changespot.y + j)/2].opacity = 0
                checker[(changespot.x+i)/2][(changespot.y + j)/2].king = false
                if checker[(changespot.x+i)/2][(changespot.y + j)/2].color == Color.black{
                    black_numbers -= 1
                }
                else{
                    white_numbers -= 1
                }
                checker[(changespot.x+i)/2][(changespot.y + j)/2].color = Color.red
                win_color()
                if checker[i][j].color==Color.black && i==7{
                    checker[i][j].king = true
                }
                else if checker[i][j].color==Color.white && i==0{
                    checker[i][j].king = true
                }
                AtePosition(i: i, j: j, roundcolor: roundcolor, enemycolor: enemycolor)
                if enemys.count == 0{
                    track = false
                    NoChoiced(x: -1, y: -1)
                    EatEmpty()
                    EatCheck(mycolor: enemycolor, opcolor: roundcolor)
                    round = colortoround(color: enemycolor)
                    if roundcolor == Color.black{
                        black_finished = true
                    }
                    if enemycolor == Color.black{
                        if eatspots.count == 0{
                            for col in 0...7{
                                for row in 0...7{
                                    if black_finished == false && checker[col][row].color == Color.black{
                                        TapCheck(i: col, j: row)
                                    }
                                    else if black_finished == true{
                                        break
                                    }
                                }
                                if black_finished == true{
                                    break
                                }
                            }
                            black_finished = false
                        }
                        else{
                            black_finished = false
                         let tmp = Int.random(in: 0...eatspots.count-1)
                            TapCheck(i: eatspots[tmp].x, j: eatspots[tmp].y)
                        }
                    }
                }
                else{
                    changespot = coordinate(x: i, y: j)
                    NoChoiced(x: i, y: j)
                    track = true
                    EatEmpty()
                    eatspots.append(coordinate(x: i, y: j))
                    if roundcolor == Color.black{
                        track = false
                        black_finished = false
                        TapCheck(i: eatspots[0].x, j: eatspots[0].y)
                    }
                }
            }
        }
        else if checker[i][j].color == roundcolor && checker[i][j].opacity == 1{
            checker[changespot.x][changespot.y].choiced = false
            checker[i][j].choiced = true
            RecoveryColor()
            changespot = coordinate(x: i, y: j)
            if roundcolor == Color.black{
                if checker[i][j].king == false{
                    if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                        if j - 1 >= 0 && checker[i + 1][j - 1].opacity == 0{
                            checker[i + 1][j - 1].opacity = 0.3
                            checker[i + 1][j - 1].color = Color.black
                            recovery.append(coordinate(x: i + 1, y: j - 1))
                        }
                         if j + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                            checker[i + 1][j + 1].opacity = 0.3
                            checker[i + 1][j + 1].color = Color.black
                            recovery.append(coordinate(x: i + 1, y: j + 1))
                        }
                    }
                }
                else{
                    if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                        if j - 1 >= 0 && i + 1 < 8 && checker[i + 1][j - 1].opacity == 0{
                            checker[i + 1][j - 1].opacity = 0.3
                            checker[i + 1][j - 1].color = Color.black
                            recovery.append(coordinate(x: i + 1, y: j - 1))
                        }
                         if j + 1 < 8 && i + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                            checker[i + 1][j + 1].opacity = 0.3
                            checker[i + 1][j + 1].color = Color.black
                            recovery.append(coordinate(x: i + 1, y: j + 1))
                         }
                        if j - 1 >= 0 && i - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                            checker[i - 1][j - 1].opacity = 0.3
                            checker[i - 1][j - 1].color = Color.black
                            recovery.append(coordinate(x: i - 1, y: j - 1))
                        }
                        if j + 1 < 8 && i - 1 >= 0 && checker[i - 1][j + 1].opacity == 0{
                           checker[i - 1][j + 1].opacity = 0.3
                           checker[i - 1][j + 1].color = Color.black
                           recovery.append(coordinate(x: i - 1, y: j + 1))
                        }
                    }
                }
                if recovery.count != 0{
                 let ind = Int.random(in: 0...recovery.count - 1)
                    
                    TapCheck(i: recovery[ind].x, j: recovery[ind].y)
                }
            }
            else{
                if checker[i][j].king == false{
                    if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                        if j - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                            checker[i - 1][j - 1].opacity = 0.3
                            checker[i - 1][j - 1].color = Color.white
                            recovery.append(coordinate(x: i - 1, y: j - 1))
                        }
                         if j + 1 < 8 && checker[i - 1][j + 1].opacity == 0{
                            checker[i - 1][j + 1].opacity = 0.3
                            checker[i - 1][j + 1].color = Color.white
                            recovery.append(coordinate(x: i - 1, y: j + 1))
                        }
                    }
                }
                else{
                    if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                        if j - 1 >= 0 && i + 1 < 8 && checker[i + 1][j - 1].opacity == 0{
                            checker[i + 1][j - 1].opacity = 0.3
                            checker[i + 1][j - 1].color = Color.white
                            recovery.append(coordinate(x: i + 1, y: j - 1))
                        }
                         if j + 1 < 8 && i + 1 < 8 && checker[i + 1][j + 1].opacity == 0{
                            checker[i + 1][j + 1].opacity = 0.3
                            checker[i + 1][j + 1].color = Color.white
                            recovery.append(coordinate(x: i + 1, y: j + 1))
                         }
                        if j - 1 >= 0 && i - 1 >= 0 && checker[i - 1][j - 1].opacity == 0{
                            checker[i - 1][j - 1].opacity = 0.3
                            checker[i - 1][j - 1].color = Color.white
                            recovery.append(coordinate(x: i - 1, y: j - 1))
                        }
                        if j + 1 < 8 && i - 1 >= 0 && checker[i - 1][j + 1].opacity == 0{
                           checker[i - 1][j + 1].opacity = 0.3
                           checker[i - 1][j + 1].color = Color.white
                           recovery.append(coordinate(x: i - 1, y: j + 1))
                        }
                    }
                }
            }
        }
        else if checker[i][j].color == roundcolor && checker[i][j].opacity == 0.3{
            checker[i][j].opacity = 1
            checker[changespot.x][changespot.y].color = Color.red
            checker[changespot.x][changespot.y].choiced = false
            checker[i][j].king = checker[changespot.x][changespot.y].king
            checker[changespot.x][changespot.y].opacity = 0
            checker[changespot.x][changespot.y].king = false
            if checker[i][j].color==Color.black && i==7{
                checker[i][j].king = true
            }
            else if checker[i][j].color==Color.white && i==0{
                checker[i][j].king = true
            }
            RecoveryColor()
            round = colortoround(color: enemycolor)
            EatEmpty()
            EatCheck(mycolor: enemycolor, opcolor: roundcolor)
            if roundcolor == Color.black{
                black_finished = true
            }
            if enemycolor == Color.black{
                if eatspots.count == 0{
                    for col in 0...7{
                        for row in 0...7{
                            if black_finished == false && checker[col][row].color == Color.black{
                                TapCheck(i: col, j: row)
                            }
                            else if black_finished == true{
                                break
                            }
                        }
                        if black_finished == true{
                            break
                        }
                    }
                    black_finished = false
                }
                else{
                    black_finished = false
                 let tmp = Int.random(in: 0...eatspots.count-1)
                    TapCheck(i: eatspots[tmp].x, j: eatspots[tmp].y)
                }
            }
        }
        if eatspots.count != 0{
            for e in eatspots{
                checker[e.x][e.y].choiced = true
            }
        }
    }
    
    func king_check(i:Int, j:Int) -> Double{
        if checker[i][j].king == true{
            return 1
        }
        else{
            return 0
        }
    }
}

struct PveView_Previews: PreviewProvider {
    static var previews: some View {
        PveView(showPveView: .constant(true), nowmode: .constant(.pve))
    }
}
