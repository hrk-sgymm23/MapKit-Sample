//
//  SettingView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView{
        Text("Setting")
            .navigationBarTitle("Setting", displayMode: .inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
