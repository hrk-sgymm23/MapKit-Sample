//
//  ContentView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingModal = false
    var body: some View {
        //        Button("マップを開く") {
        //            // ボタンアクション:
        //            // ContentViewが持つshowingModal(self.showingModal)の切り替え
        //            self.showingModal.toggle()
        //        }.sheet(isPresented: $showingModal) {
        //            ModalView()
        //        }
        
        TabView{
            ARView()
                .tabItem{
                    VStack{
                        Image(systemName: "a")
                        Text("AR")
                    }
                }.tag(1)
            MapView()
                .tabItem{
                    VStack{
                        Image(systemName: "a")
                        Text("MAP")
                    }
                }.tag(2)
            SNSView()
                .tabItem{
                    VStack{
                        Image(systemName: "a")
                        Text("SNS")
                    }
                }.tag(3)
            SettingView()
                .tabItem{
                    VStack{
                        Image(systemName: "a")
                        Text("Setting")
                    }
                }.tag(4)
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
