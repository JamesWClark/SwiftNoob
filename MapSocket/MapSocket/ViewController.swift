//
//  ViewController.swift
//  MapSocket
//
//  Created by J.W. Clark on 10/30/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

// import these
import MapKit
import CoreLocation

// inherit another delegate
class ViewController: UIViewController, CLLocationManagerDelegate{
    
    var socket: SocketIOClient? // optional

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    // main method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conditional compilation
        // Check if the user is on a simulator; else default to some IP
        #if (arch(i386) || arch(x86_64))
            socket = SocketIOClient(socketURL: URL(string: "http://localhost")!)
            socket!.connect()
        #else
            socket = SocketIOClient(socketURL: URL(string: "http://192.168.1.6")!)
        #endif
        
        addConnectionHandlers()
        addMessageHandlers()
        socket!.connect()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: Socket Handlers
    
    // register socket handlers for connected messaging
    func addMessageHandlers() {
        
        // server says hello
        socket?.on("welcome") {[weak self] data, ack in
            if let arr = data as? [[String: Any]] {
                if let txt = arr[0]["text"] as? String {
                    print("socket: welcome: ")
                    print(txt)
                }
            }
        }
        
        // another user connected
        socket?.on("otherUserConnect") { data, ack in
            let arr = data as! [String]
            //self.messagePump(msg: "\(arr[0]) connected")
        }
        
        // another user disconnected
        socket?.on("otherUserDisconnect") { data, ack in
            let arr = data as! [String]
            //self.messagePump(msg: "\(arr[0]) disconnected")
        }
    }
    
    // register socket handlers for connection events
    func addConnectionHandlers() {
        
        // connected to server
        socket?.on("connect") { data, ack in
            // TODO: connection status light
            print("### -- SOCKET CONNECTED                -- ###")
        }
        
        // server disconnected
        socket?.on("disconnect") { data, ack in
            // TODO: implement purposeful disconnect?
            print("### -- SOCKET DISCONNECTED             -- ###")
        }
        
        // can't connect to server
        socket?.on("error") { data, ack in
            print("### -- SOCKET ERROR                    -- ###")
        }
        
        // before trying to reconnect
        socket?.on("reconnect") { data, ack in
            // TODO: something before a reconnect
            print("### -- SOCKET BEFORE RECONNECT ATTEMPT -- ###")
            
        }
        
        // at the time of reconnect attempt
        socket?.on("reconnectAttempt") { data, ack in
            // TODO: something while attempting reconnecting
            print("### -- SOCKET RECONNECT ATTEMPT        -- ###")
        }
    }
    
    @IBAction func btnFindMe(_ sender: UIBarButtonItem) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let coord = locationManager.location?.coordinate
        print(coord)
        
        self.socket?.emit("coordinate",  "\(coord)")
        
        mapView.showsUserLocation = true
    }
}

