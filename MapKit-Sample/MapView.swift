//
//  MapView.swift
//  MapKit-Sample
//
//  Created by 杉山悠己 on 2021/07/22.
//

import SwiftUI
import MapKit
import Firebase
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
            .navigationBarItems(leading:
                                    Button("Open") {
                                        self.showingModal.toggle()
                                    }.sheet(isPresented: $showingModal) {
                                        ModalView()
                                    }
            )
        }
    }
}

struct mapView : UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> mapView.Coordinator {
        
        return mapView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
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
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current Place"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 10000)
                print(region)
                self.parent.map.region = region
                
                
            }
            
        }
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
