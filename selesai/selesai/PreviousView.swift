//
//  PreviousView.swift
//  selesai
//
//  Created by User12 on 2022/4/22.
//

import SwiftUI
import AVFoundation

struct PreviousView: View {
    @State private var showContentView = false
      @State private var showPveView = false
      @State private var nowmode:gamemode = .pvp
      @State private var moveDistance: Double = 50
      @State private var opacity: Double = 1
    //@State var soundon = true
   
      //let musicPlayer = AVPlayer()
    var body: some View {
        ZStack{
            Image("blue")
                .resizable()
                .ignoresSafeArea()
        VStack(spacing: 50){
            Text("CHECKERS")
                .font(.system(size: 40, weight: .heavy, design: .default))
                .bold()
          
            Button(action: {showContentView = true;
                nowmode = .pvp;playSound(key:"playing")
                               
                                }, label: {
                                    VStack{
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 30)
                                            .frame(width: 400, height: 60)
                                            .foregroundColor(.white)
                                        HStack {
                                            Image("person")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                          
                                               
                                                    Text("VS")
                                                        .foregroundColor(Color.black)
                                             
                                            Image("person")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                    }
                                }).fullScreenCover(isPresented: $showContentView, content:{ContentView(showContentView: $showContentView, nowmode: $nowmode )})
            Button(action: { showPveView = true;
                nowmode = .pve;playSound(key:"playing")
                               
                                }, label: {
                                    VStack{
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 30)
                                            .frame(width: 400, height: 60)
                                            .foregroundColor(.white)
                                        HStack {
                                            Image("robot")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                          
                                               
                                                    Text("VS")
                                                        .foregroundColor(Color.black)
                                             
                                            Image("person")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                        }
                                    }}}).fullScreenCover(isPresented: $showPveView, content:{PveView(showPveView: $showPveView, nowmode: $nowmode)})
                    }
    
        }}
   
    
}

struct PreviousView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousView()
    }
}
