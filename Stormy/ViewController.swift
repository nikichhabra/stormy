//
//  ViewController.swift
//  Stormy
//
//  Created by Nikita Chhabra on 6/16/15.
//  Copyright (c) 2015 Nikita Chhabra. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    
    
    @IBOutlet var currentTimeLabel: UILabel!
    
    
    
    @IBOutlet var temperatureLabel: UILabel!
    
    
    
    @IBOutlet var humidityLabel: UILabel!
    
    
    
    
    @IBOutlet var precipitationLabel: UILabel!
    
    
    @IBOutlet var summerLabel: UILabel!
    
    private let apikey="5b62fe5bb9b6aa330cd580eb117eb435"
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let baseUrl = NSURL(string:"https://api.forecast.io/forecast/\(apikey)/")
        let weatherURL = NSURL(string: "28.422094,77.057759", relativeToURL: baseUrl)
        
        let weatherData = NSData (contentsOfURL: weatherURL!)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask : NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(weatherURL! , completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError! ) -> Void in
            
            let url =  location as NSURL
            
            if error == nil {
                let dataObject = NSData(contentsOfURL: url)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
                
                println(weatherDictionary)
                let currentWeather = current(weatherDictionary: weatherDictionary)
                dispatch_async(dispatch_get_main_queue()){
                    println(currentWeather.precipProbability)
                    self.temperatureLabel.text = "\(currentWeather.apparentTemperature)"
                    self.currentTimeLabel.text = "At \(currentWeather.time!) it is!"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.precipitationLabel.text="\(currentWeather.precipProbability)"
                }
            }
            
        })
        downloadTask.resume()
    }
    
    func displayLocationInfo(placemark : CLPlacemark)
    {
        self.locationManager.stopUpdatingLocation()
        println(placemark.lat)
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println("error : " + error.localizedDescription)
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    func locationManager(manager: CLLocationManager!, didUpdateLocations: [AnyObject]!){
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if(error != nil)
            {
                println("error : " + error.localizedDescription)
                return
                
            }
            if(placemarks.count>0)
            {
                let pl = placemarks[0] as! CLPlacemark
                  self.displayLocationInfo(pl)
            }
            else{
                print("error with data")
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that c an be recreated.
    }
    
    
}