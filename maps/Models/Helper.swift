//
//  Helper.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 15/11/23.
//

import Foundation
import Observation

@Observable
 class Helper{
    private var _city: City
     
     var selectedIndex: Int = 0
     var isSelected:Bool = false
     //Change to false
     var incrementSize:Bool = false
    
     init(_city: City = City.this.first!) {
        self._city = _city
    }
     
     
    
    public var city: City {
          get {
              return self._city;
          }
          set {
              self._city = newValue
          }
      }
    
    
}




