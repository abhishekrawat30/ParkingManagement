//
//  MapVC.swift
//  ParkingManagement
//
//  
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class MapVC: BaseViewController,MKMapViewDelegate {
    
    @IBOutlet weak var lblMallName:UILabel!
    @IBOutlet weak var mallAddress:UILabel!
    //@IBOutlet weak var mallAddress:UILabel!
    
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var googleMapView:GMSMapView!
    
    var  mapVM = MallMapVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func wantParking(_ sender: Any) {
        if let mall = mapVM.mallData, mall.availSlots <= 0 {
            showAlert("No Available slots", completion: nil)
            return
        } else {
            performSegue(withIdentifier: "wantParkingSegue", sender: self)
        }
    }
    
    
    func updateUI() {
        if let data = mapVM.mallData {
            lblMallName.text = "Mall name:  \(data.name)"
            mallAddress.text = "Mall address:  \(data.address)"
            createPolyline(mall: data.lat, longt: data.longt)
        }
    }
    
    
    func createPolyline(mall lat:Double,longt:Double) {
        AppLocationHandler.sharedLocation().checkForAuthorization { (permission) in
            if permission == .allowed {
                AppLocationHandler.sharedLocation().startLocationTrack { (clat, clong) in
                    DispatchQueue.main.async {
                        let locationCord = CLLocationCoordinate2D(latitude: clat, longitude: clong)
                        let mallCord =  CLLocationCoordinate2D(latitude: lat, longitude: longt)
                        self.setupGoogleMapVC(cordArray: [locationCord,mallCord])
                        //                        let geodesic = MKGeodesicPolyline(coordinates: points, count: points.count)
                        //                        self.mapView.addOverlay(geodesic)
                        //                        for item in points {
                        //                            let annotaions = MKPointAnnotation()
                        //                            annotaions.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                        //                            self.mapView.addAnnotation(annotaions)
                        //                        }
                        //                        UIView.animate(withDuration: 1.5, animations: { () -> Void in
                        //                            self.updateZoom()
                        //                        })
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKGeodesicPolyline {
            let polyLine = MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = .black
            polyLine.lineWidth = 5
            return polyLine
        }
        
        return MKOverlayRenderer()
    }
    
    
    func updateZoom(path:GMSPath) {
        //in case of googlemap
        DispatchQueue.main.async
            {
                if self.googleMapView != nil
                {
                    let bounds = GMSCoordinateBounds(path: path)
                    self.googleMapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                }
        }
        //
        
        
        //        if let first = mapView.overlays.first {
        //            let rect = mapView.overlays.reduce(first.boundingMapRect, {$0.union($1.boundingMapRect)})
        //            mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
        //        }
    }
    
    
    func setupGoogleMapVC(cordArray:[CLLocationCoordinate2D]) {
        let camera = GMSCameraPosition.camera(withLatitude: cordArray[0].latitude, longitude: cordArray[0].longitude, zoom: 6.0)
        googleMapView.camera = camera
        
        for item in cordArray {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
//            marker.title = "Sydney"
//            marker.snippet = "Australia"
            marker.map = googleMapView
            drawRectange(cordArray: cordArray)
        }
    }
    
    
    func drawRectange(cordArray:[CLLocationCoordinate2D]){
        /* create the path */
        let path = GMSMutablePath()
        for item in cordArray {
            path.add(item)
        }
        /* show what you have drawn */
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 3.0
        polyline.map = googleMapView
        updateZoom(path: path)
    }
    
}

extension MapVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wantParkingSegue" {
            let destin = segue.destination as! PriceDistVC
            destin.priceDistVM.mallData = mapVM.mallData
        }
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
