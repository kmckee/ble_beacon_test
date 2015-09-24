//
//  ViewController.swift
//  BikeBuddy
//
//  Created by Kyle McKee on 9/22/15.
//  Copyright © 2015 Kyle McKee. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!, identifier: "RadBeacon");
    
    @IBOutlet weak var distanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        
        var color: UIColor
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon            
            switch closestBeacon.proximity.rawValue {
            case 1:
                color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            case 2:
                color = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            case 3:
                color = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
            case 4:
                color = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            case 5:
                color = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
            default:
                color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            }
            distanceLabel.text = String(closestBeacon.rssi)
        } else {
            color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            distanceLabel.text = "N/A"
        }
        
        self.view.backgroundColor = color
    }

}

