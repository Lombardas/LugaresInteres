//
//  ViewController.swift
//  LugaresInteres
//
//  Created by Tasio on 1/3/18.
//  Copyright © 2018 Anastasio Almansa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var lugares : [Lugar] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        //mapView.userLocation.title = "Ubicación Actual"
                
        mapView.showsUserLocation = true
        // creacion de los datos**********************
        
        var lugar = Lugar(nombre: "Bar Manolo", cat: "Bar", direccion: "Calle de Cartaya, 1, 21002 Huelva, España")
        
        lugares.append(lugar)
        
        lugar = Lugar(nombre: "Museo de Arquelogía", cat: "Museo", direccion: "Calle de Cartaya, 25, 21002 Huelva, España")
        
        lugares.append(lugar)
        lugar = Lugar(nombre: "Cines Rábida", cat: "Cine", direccion: "Plaza del Campillo, 8, 21002 Huelva, España")
        
        lugares.append(lugar)
        lugar = Lugar(nombre: "Parada de Bus", cat: "Bus", direccion: "Paseo de la glorieta, 1, 21002 Huelva, España")
        
        lugares.append(lugar)
        
        
        //*********************************************
        for lugar in lugares{
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(lugar.direccion!) { (placemarks, error) in
                if error == nil{
                    for placemark in placemarks!{
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = lugar.nombre!
                        annotation.subtitle = lugar.cat
                        annotation.coordinate = (placemark.location?.coordinate)!
                        
                        
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            }
            
        } //end for in
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        
        if annotation.isKind(of: MKUserLocation.self)
        {
            return nil
            
        }
        var annotationView :MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        //Se deja en comentario la posibilidadde añadir fotos al lugar de interés.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        
        if( annotation.subtitle as! String  == "Bar"){
            imageView.image = #imageLiteral(resourceName: "bar")
            annotationView?.pinTintColor = UIColor.purple
        }
        if( annotation.subtitle as! String  == "Museo"){
            imageView.image = #imageLiteral(resourceName: "museo")
            annotationView?.pinTintColor = UIColor.orange
        }
        if( annotation.subtitle as! String  == "Cine"){
            imageView.image = #imageLiteral(resourceName: "cine")
            annotationView?.pinTintColor = UIColor.brown
        }
        if( annotation.subtitle as! String  == "Bus"){
            imageView.image = #imageLiteral(resourceName: "bus")
            annotationView?.pinTintColor = UIColor.blue
        }
        
        annotationView?.leftCalloutAccessoryView = imageView
        
        
       return annotationView
    }
}
