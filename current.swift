//
//  current.swift
//  Stormy
//
//  Created by Nikita Chhabra on 6/18/15.
//  Copyright (c) 2015 Nikita Chhabra. All rights reserved.
//

import Foundation
import UIKit
struct current
{
    var apparentTemperature : Double
    var cloudCover : Double
    var dewPoint : Double
    var humidity : Double
    var icon : UIImage?
    var ozone : Double
    var precipIntensity : Int
    var precipProbability : Int
    var pressure : Double
    var summary : String
    var temperature : Double
    var time : String?
    var windBearing : Int
    var windSpeed : Double
   
 
    func dateStringFromUnixTime(unixTime: Double)->String
    {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(weatherDate)
        
    }
    

    init(weatherDictionary : NSDictionary)
    {
        let currentWeather=weatherDictionary["currently"] as! NSDictionary
                apparentTemperature = currentWeather["apparentTemperature"] as! Double
       

        cloudCover = currentWeather["cloudCover"] as! Double
         dewPoint = currentWeather["dewPoint"] as! Double
         humidity = currentWeather["humidity"] as! Double
      let iconString = currentWeather["icon"] as! String
        
         ozone = currentWeather["ozone"] as! Double
         precipIntensity = currentWeather["precipIntensity"] as! Int
         precipProbability = currentWeather["precipProbability"] as! Int
          pressure = currentWeather["pressure"] as! Double
          summary = currentWeather["summary"] as! String
          temperature = currentWeather["temperature"] as! Double
        
          windBearing = currentWeather["windBearing"] as! Int
         windSpeed = currentWeather["windSpeed"] as! Double
        let timeInt = currentWeather["time"] as! Double
        time = dateStringFromUnixTime(timeInt)
    //    icon = imageIconFromString(iconString)
println(iconString)
    
    }

    func imageIconFromString(stringIcon: String)->UIImage
    {
        var imageName : String
        switch stringIcon{
        case "clear-day":
//                    "clear-night",
//                "sleet",
//            "snow",
//            "rain",
//            "wind",
//            "fog",
//            "cloudy",
//            "partly-cloudy-day",
//            "partly-cloudy-night"
        
            imageName="images"
        default: imageName = "images"
        }
      var imageIcon = UIImage(named: imageName)
        if(imageIcon != nil)
        {
            return imageIcon!
        }
      return imageIcon!
    }

    
}
