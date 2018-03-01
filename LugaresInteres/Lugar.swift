//
//  Lugar.swift
//  LugaresInteres
//
//  Created by Tasio on 1/3/18.
//  Copyright © 2018 Anastasio Almansa. All rights reserved.
//

import Foundation
//import CoreData

class Lugar : NSObject{

     var nombre : String?
     var cat : String?
     var direccion : String?
    
    init ( nombre : String?, cat: String?, direccion : String?)
    {
        self.nombre = nombre
        self.cat = cat
        self.direccion = direccion
        
    }
        
}
