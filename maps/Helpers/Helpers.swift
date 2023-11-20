//
//  Helpers.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 13/11/23.
//

import Foundation
import MapKit


extension CLLocationCoordinate2D {
    static let  begin = CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708)
    
    static let towerBridge = CLLocationCoordinate2D(latitude: 51.505507, longitude: -0.075402)
    
    static let manta = CLLocationCoordinate2D(latitude:  -0.9621200, longitude:  -80.7127100)
    static let mexico = CLLocationCoordinate2D(latitude:  19.451054, longitude:   -99.125519)
    static let spain = CLLocationCoordinate2D(latitude:  40.416775, longitude:   -3.703790)
    static let newYork = CLLocationCoordinate2D(latitude:  40.71427, longitude:    -74.00597)
    

}

extension MKCoordinateSpan {
    static let begin = MKCoordinateSpan(
        latitudeDelta:  0.5,
        longitudeDelta: 0.5
        )
}

extension MKCoordinateRegion {
    static let initilRegion = MKCoordinateRegion(center: .begin, span: .begin)
}
