import UIKit
import CoreLocation
class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManger = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManger.delegate=self
        searchTextField.delegate = self//it is used to report the events of textfield to viewcontroller
    }
   
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
//MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let city = searchTextField.text{
            weatherManger.fetchWeather(cityName: city)
        }//this function is used to make the return work on the keyboard
        searchTextField.text = " "
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Enter a city name!!"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManger.fetchWeather(cityName: city)
        }
        searchTextField.text = " "
    }
}
 //MARK: - WeatherManagerDelegate

extension WeatherViewController:WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.temperatureValue
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
        }
        
    }
    func didFailWithWeather(error: Error) {
        print(error)
    }
}
 //MARK: - CLLocationMangerDelegate
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
