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
    
    var body: some View {
        
        NavigationView{
            mapView(manager: $manager, alert: $alert).alert(isPresented: $alert) {
                Alert(title: Text("Please Enable Location Access In Setting Panel!!!"))
            }
            .navigationBarTitle("Map", displayMode: .inline)
            .navigationBarItems(trailing:
                                    
                                        Button("ピンを立てる") {
                                            self.showingModal.toggle()
                                        }.sheet(isPresented: $showingModal) {
                                            ModalView()
                                        }
                                    
            )
        }
    }
}

struct mapView : UIViewRepresentable {
    
    //    typealias UIViewType = MKMapView
    
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> mapView.Coordinator {
        
        return mapView.Coordinator(parent1: self)
    }
    
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
           
            _ = CLGeocoder()
            
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
