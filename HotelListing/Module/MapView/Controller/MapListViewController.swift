//
//  MapListViewController.swift
//  HotelListing
//
//  Created by Varun Kumar on 05/01/21.
//

import UIKit
import MapKit

class MapListViewController: BaseViewController {
        
    @IBOutlet weak var mapView: MKMapView!

    var hotels: [Hotel]?
    
    var viewModel: HotelFetchable?
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hotels = viewModel?.allHotels
        addAllPin()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// add the pin on mapView
    func addAllPin() {
        guard let hotels = hotels, hotels.count > 0 else { return }
        mapView.delegate = self
        mapView.register(
            MapItemAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(
            ClusterAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        let centerCoordinate = CLLocationCoordinate2D(latitude: hotels[0].latitude, longitude: hotels[0].longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: false)

        for hotel in hotels {
            let coordinate = CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
            let annotation = MapItem(coordinate: coordinate)
            mapView.addAnnotation(annotation)
        }
  
    }
    
    private func makeRandomCoordinates() -> [CLLocationCoordinate2D]{
        return hotels!.map({ (hotel) -> CLLocationCoordinate2D in
           return CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
        })
    }
    
}


extension MapListViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let hotelAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            hotelAnnotationView.animatesWhenAdded = true
            hotelAnnotationView.titleVisibility = .adaptive
            return  hotelAnnotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard view is ClusterAnnotationView else { return }
        
        // if the user taps a cluster, zoom in
        let currentSpan = mapView.region.span
        let zoomSpan = MKCoordinateSpan(latitudeDelta: currentSpan.latitudeDelta / 2.0, longitudeDelta: currentSpan.longitudeDelta / 2.0)
        let zoomCoordinate = view.annotation?.coordinate ?? mapView.region.center
        let zoomed = MKCoordinateRegion(center: zoomCoordinate, span: zoomSpan)
        mapView.setRegion(zoomed, animated: true)
    }
}

