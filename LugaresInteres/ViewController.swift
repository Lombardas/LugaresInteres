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


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region,animated: true)
        mapView.showsUserLocation = true
    }
    var lugares : [Lugar] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
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
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        //mapView.userLocation.title = "Ubicación Actual"
                
        //mapView.showsUserLocation = true
        // creacion de los datos**********************
        
        
            
    
     manager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func bnuevoLugar(_ sender: UIButton) {
        
        
        //let geocoder = CLGeocoder()
         let annotation = MKPointAnnotation()
        switch sender.tag {
        case 1:
           // print(mapView.userLocation)
            annotation.subtitle = "Bar"
            break
        case 2:
            annotation.subtitle = "Concierto"
            break
            
        case 3:
            annotation.subtitle = "Hotel"
            break
            
        case 4:
            annotation.subtitle = "Café"
            break
         
        case 5:
            annotation.subtitle = "Taxi"
            break
        case 6:
            annotation.subtitle = "Museo"
            break
        case 7:
            annotation.subtitle = "Bus"
            break
        case 8:
            annotation.subtitle = "Teatro"
            break
        case 9:
            annotation.subtitle = "Parque"
            break
        
        default:
            break
            
        }
        annotation.title = "Nuevo Lugar"
        
        annotation.coordinate = (mapView.userLocation.location?.coordinate)!
        
        
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        
        let alert = UIAlertController(title: "Nuevo lugar añadido!", message: "Has añadido un nuevo lugar de interés!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default))
        self.present(alert,animated: true)
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
        if( annotation.subtitle as! String  == "Concierto"){
            imageView.image = #imageLiteral(resourceName: "concierto")
            annotationView?.pinTintColor = UIColor.brown
        }
        if( annotation.subtitle as! String  == "Hotel"){
            imageView.image = #imageLiteral(resourceName: "hotel")
            annotationView?.pinTintColor = UIColor.blue
        }
        if( annotation.subtitle as! String  == "Café"){
            imageView.image = #imageLiteral(resourceName: "cafe")
            annotationView?.pinTintColor = UIColor.brown
        }
        if( annotation.subtitle as! String  == "Parque"){
            imageView.image = #imageLiteral(resourceName: "parque")
            annotationView?.pinTintColor = UIColor.green
        }
        annotationView?.leftCalloutAccessoryView = imageView
        
        
       return annotationView
    }
}
