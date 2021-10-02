//
//  ModalView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI
import MapKit


struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var title = ""
    @State private var Rtitle = ""
    @State private var text = ""
    @State private var Rtext = ""
    @State private var editting = false
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("タイトルを入力", text: $title,
                          
                          onEditingChanged :{ begin in
                            if begin {
                                self.editting = true
                                self.Rtitle = ""
                            } else {
                                self.editting = false
                            }
                          },
                          
                          onCommit: {
                            self.Rtitle = "入力されたタイトル:\(self.title)"
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .shadow(color: editting ? .blue : .clear, radius: 3)
                
                Text(Rtitle)
                
                TextField("テキストを入力", text: $text,
                          
                          onEditingChanged: { begin in
                            if begin {
                                self.editting = true
                                self.Rtext = ""
                            } else {
                                self.editting = false
                            }
                          },
                          
                          onCommit: {
                            self.Rtext = "入力されたテキスト:\(self.text)"
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .shadow(color: editting ? .blue : .clear, radius: 3)
                
                Text(Rtext)
            }
            .navigationBarTitle("ピンを立てる", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                            self.presentationMode.wrappedValue.dismiss() }){
                                        Text("Close")
                                    }
            )
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
