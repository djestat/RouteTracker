//
//  ViewController.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import CoreLocation

class GoogleMapViewController: UIViewController, HeaderControlViewDelegate {

    var header: HeaderControlView?
    var gMapView: GoogleMapView?
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.manager?.delegate = self
        addSubviews()
    }
    
    // MARK: - Add Subviews
    
    func addSubviews() {
        addHeaderControlView()
        addGoogleMapView()
    }
    
    func addHeaderControlView() {
        
        let originX: Int = 0
        let originY: Int = 0
        let width: Int = Int(self.view.frame.size.width)
        let height: Int = 100

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let headerView = HeaderControlView(frame: frame)
        headerView.delegate = self
        header = headerView
        
        self.view.addSubview(header!)
    }
    
    func addGoogleMapView() {
        let originX: Int = 0
        let originY: Int = 100
        let width: Int = Int(self.view.frame.size.width)
        let height: Int = Int(self.view.frame.size.height) - originY

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let mapView = GoogleMapView(frame: frame)
        gMapView = mapView

        self.view.addSubview(gMapView!)
    }
    
    // MARK: - Location
    
    func startTracker() {
        locationManager.manager?.startUpdatingLocation()
    }
    
    func didPressedStartTrackerButton() {
//        startTracker()
        print("Start tracker")
    }

}

extension GoogleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let firstLocation = locations.first {
            print(firstLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
