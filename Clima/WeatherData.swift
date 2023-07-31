import Foundation
struct WeatherData:Decodable {
    let name:String
    let main:Main
    let weather:[Weather]
}
struct Main:Codable{
    let temp: Double
}
struct Weather:Decodable{
    let id:Int
}
