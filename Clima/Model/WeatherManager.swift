import Foundation
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=33770419c14e424c48882d00300952e3&units=metric"
    func fetchWeather(cityName: String){
        let urlString="\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        //create a url
        if let url = URL(string: urlString){
            //create a url session
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    self.parseJSON(weatherData: safeData)
                }
            }
            //start the task
            task.resume()
        }
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id=(decodedData.weather[0].id)
            print(getConditionName(weatherId: id))
        }catch{
            print(error)
        }
        }
    func getConditionName(weatherId:Int)-> String {
        switch weatherid {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"

    }
    
}
}
