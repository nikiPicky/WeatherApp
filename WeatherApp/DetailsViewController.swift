//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Nikhil Jaggi on 08/09/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var weatherData: WeatherModel?
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelSunrise: UILabel!
    @IBOutlet weak var labelSunset: UILabel!
    
    @IBOutlet weak var labelFeelsLike: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func dismissControllerFunc(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setupViews() {
        defaultViews(views: [viewBackground])
        viewBackground.layer.cornerRadius = 10
        
        labelWind.text = "\(weatherData?.wind ?? 1.0) km/h"
        labelSunrise.text = weatherData?.sunriseString
        labelSunset.text = weatherData?.sunsetString
        
        labelFeelsLike.text = "\(weatherData?.feelsLike ?? 25)°C"
    }
    
    func instance() -> DetailsViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    }
    
}
