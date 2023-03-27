//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController, WeatherManagerDelegate, UIScrollViewDelegate {
    
//    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var manager = Manager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        manager.delegate = self
        locationManager.delegate = self
        locationManager.requestLocation()
//        scrollView.isScrollEnabled = true
//
//        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = scrollView.contentOffset.y
        let angle = -topOffset * 2 * CGFloat(Double.pi / 180)
        self.rockImage.transform = CGAffineTransform(rotationAngle: angle)
    }


    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter City", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter the name of the city here"
            // add identifier to the textfield inside the allert
            textField.accessibilityIdentifier = "AlertTextfieldIdentifier"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            action.accessibilityIdentifier = "OKButtonIdentifier"
            if let text = alert.textFields?.first?.text {
                self.manager.fetchWeather(cityName: text)
            }
        }))
        alert.view.accessibilityIdentifier = "AllertIdentifier"
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let storydoard = UIStoryboard(name: "InfoStoryboard", bundle: nil)
        guard let destinationVC = storydoard
            .instantiateViewController(withIdentifier: "InfoStoryboard") as? InfoViewController
        else {
            return
        }
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
    
    func didUpdateWeather(_ manager: Manager, weather: WeatherModel) {
        DispatchQueue.main.async {
            let foggyWeatherRange = 701...771
            self.temperatureLabel.text = "\(weather.tempInt)°"
            self.cityLabel.text = "\(weather.cityName), \(weather.country)"
            self.weatherLabel.text = weather.weatherName
            
            if weather.tempInt >= 30 {
                // if the temperature is hot
                self.rockImage.image = UIImage(named: "image_stone_cracks")
            } else if foggyWeatherRange.contains(weather.conditionId) {
                // make the rock a bit more transparent
                self.rockImage.image = UIImage(named: weather.conditionName)
                self.rockImage.alpha = 0.2
            } else if weather.conditionId == 781 {
                // create pendulum animation for tornado
                self.rockImage.image = UIImage(named: weather.conditionName)
            } else {
                self.rockImage.image = UIImage(named: weather.conditionName)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        print("duration: \(duration) angle: \(angle) offset: \(yOffset)")
        
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        rockImage.layer.anchorPoint = (CGPoint(x: 0.5, y: yOffset))
        
        print("anchorPoint: \(rockImage.layer.anchorPoint)")
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5,
                               relativeDuration: frameDuration) {
                self.rockImage.transform = CGAffineTransform.identity
            }
        },
                                completion: nil
        )
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.manager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
