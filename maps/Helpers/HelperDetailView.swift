//
//  HelperDetailView.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 17/11/23.
//

import Foundation
import Observation
import SwiftUI


@Observable
class HelperDetailView{

    var city:City? = nil
    var isDraggable = false

    
    init(city: City? = nil, isDraggable: Bool = false) {
        self.city = city
        self.isDraggable = isDraggable

    }
    
    
    
    
}

