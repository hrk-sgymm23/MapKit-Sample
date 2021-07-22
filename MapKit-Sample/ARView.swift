//
//  SwiftUIView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI

struct ARView: View {
    var body: some View {
        NavigationView{
        Text("AR")
            .navigationBarTitle("AR", displayMode: .inline)
        }
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
