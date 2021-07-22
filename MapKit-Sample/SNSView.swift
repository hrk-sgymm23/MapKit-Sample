//
//  SNSView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI

struct SNSView: View {
    var body: some View {
        NavigationView{
        Text("SNS")
            .navigationBarTitle("SNS", displayMode: .inline)
        }
    }
}

struct SNSView_Previews: PreviewProvider {
    static var previews: some View {
        SNSView()
    }
}
