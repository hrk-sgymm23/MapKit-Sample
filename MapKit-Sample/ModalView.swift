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
//    @State var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.3351, longitude: -122.0088),
//            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var body: some View {
        NavigationView {

//            Map(coordinateRegion: $region)
            Text("Infomation")
                .navigationBarTitle("infomation", displayMode: .inline)
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
