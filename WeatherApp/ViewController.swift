//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nikhil Jaggi on 04/09/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var textSearchLocation: UITextField!
    
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewTemperature: UIView!
    @IBOutlet weak var viewImageBackground: UIView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var imageWeatherCondition: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelLocationName: UILabel!
    
    @IBOutlet weak var labelMinimumTemperature: UILabel!
    @IBOutlet weak var labelMaximumTemperature: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        
    }

    func setupViews() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        textSearchLocation.delegate = self
        
        textSearchLocation.layer.cornerRadius = 5
        textSearchLocation.layer.borderWidth = 1
        textSearchLocation.layer.borderColor = UIColor.white.cgColor
        
        viewLocation.layer.cornerRadius = 5
        viewTemperature.layer.cornerRadius = 10
        viewBottom.layer.cornerRadius = 10
        
    defaultViews(views: [viewLocation,viewTemperature,viewBottom])
    }

    func defaultViews(views: [UIView]) {
        
        for view in views {
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
            
        }
        
    }
}

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        textSearchLocation.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textSearchLocation.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textSearchLocation.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        textSearchLocation.text = ""
        
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            updateViews(weatherData: weather)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func updateViews(weatherData: WeatherModel) {
        
        labelTemperature.text = "\(weatherData.temperatureString)°C"
        imageWeatherCondition.image = UIImage(systemName: weatherData.conditionName)
        labelLocationName.text = weatherData.cityName
        imageBackground.image = UIImage(named: weatherData.conditionImage)
        
        labelMinimumTemperature.text = "\(weatherData.minimumTemperature)°C"
        labelMaximumTemperature.text = "\(weatherData.maximumTemperature)°C"
        
        //Going to add wind
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
