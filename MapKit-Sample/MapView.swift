//
//  MapView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var manager = CLLocationManager()
    @State var alert = false
    @State private var showingModal = false
    
    @State var title = ""
    @State var subtitle = ""
    
    var body: some View {
        //Group{
        
        NavigationView{
            
            ZStack(alignment: .bottom, content: {
                        mapView(manager: $manager, alert: $alert, title: $title, subtitle: $subtitle).alert(isPresented: $alert) {

                            Alert(title: Text("Please Enable Location Access In Setting Panel!!!"))
                        }

                        // 地名を取得した場合に表示
                        if self.title != "" {
                            HStack(spacing: 12) {
                                Image(systemName: "info.circle.fill").font(.largeTitle).foregroundColor(.black)
                                VStack(alignment: .leading, spacing: 5){
                                    Text(self.title).font(.body).foregroundColor(.black)
                                    Text(self.subtitle).font(.caption).foregroundColor(.gray)
                                }
                            Spacer()
                            }
                            .padding()
                            // "Color"はAssets.xcassetsで設定
                            .background(Color("Color"))
                            .cornerRadius(15)
                            .offset(y: -30)
                        .padding()
                        }
                    })
            .navigationBarTitle("Map", displayMode: .inline)
            .navigationBarItems(trailing:
                                        Button("ピンを立てる") {
                                            self.showingModal.toggle()
                                        }.sheet(isPresented: $showingModal) {
                                            ModalView()
                                        }
            )
        }
      //}//Group
    }


struct mapView : UIViewRepresentable {
    
    //    typealias UIViewType = MKMapView
    
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> mapView.Coordinator {
        
        return mapView.Coordinator(parent1: self)
    }
    
    @Binding var title : String
    @Binding var subtitle : String
    
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
        let center = CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        map.region = region
        
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        return map
    
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        
        var parent : mapView
        
        init(parent1 : mapView) {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                
                parent.alert.toggle()
                print("denied")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
            
            let location = locations.last
            
            let point = MKPointAnnotation()
            
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                self.parent.title = (places?.first?.administrativeArea)!
                self.parent.subtitle = (places?.first?.locality)!
                
                let place = places?.first?.administrativeArea
                let subPlace = places?.first?.locality
                point.title = place
                point.subtitle = subPlace
                
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                
                
            }
            
            manager.stopUpdatingLocation()
            
             let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            print(region)
            //                self.parent.map.region = region
            withAnimation{
                self.parent.map.region = region
                
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
}
