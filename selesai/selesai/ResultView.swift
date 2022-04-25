//
//  ResultView.swift
//  selesai
//
//  Created by User12 on 2022/4/15.
//

import SwiftUI

struct ResultView: View {
    @Binding var showResultView:Bool
       @Binding var result_color: String
       @Binding var lose: Int
       @Binding var scale: Double
       @State var result = [Color]()
       @State var showresult = 0
    var body: some View {
        if lose == 1{
                    Text("You Win").font(.largeTitle)
                    Button("Show Result"){
                    InitialColor()
                    }.font(.largeTitle)
                    if showresult == 1{
                        let columns = Array(repeating: GridItem(), count: Int(scale))
                        LazyVGrid(columns: columns){
                            ForEach(0..<result.count){i in
                                Rectangle().foregroundColor(result[i])
                                    .frame(height: 50)
                                    .padding(5)
                            }
                        }
                    }
                }
                else if lose == 2{
                    Text("You Suck").font(.largeTitle)
                    Button("Show Result"){
                    InitialColor()
                    }.font(.largeTitle)
                    if showresult == 1{
                        let columns = Array(repeating: GridItem(), count: Int(scale))
                        LazyVGrid(columns: columns){
                            ForEach(0..<result.count){i in
                                Rectangle().foregroundColor(result[i])
                                    .frame(height: 50)
                                    .padding(5)
                            }
                        }
                    }
                }
                Button("Back"){
                    showResultView = false
                    lose = 0
                }
    }
    func InitialColor(){
        result = [Color]()
        for index in result_color.indices{
            if result_color[index] == "0"{
                result.append(Color.black)
            }
            else if result_color[index] == "1"{
                result.append(Color.green)
            }
            else{
                result.append(Color.yellow)
            }
        }
        showresult = 1
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(showResultView: .constant(true), result_color: .constant(""), lose: .constant(1),scale: .constant(4))
    }
}
