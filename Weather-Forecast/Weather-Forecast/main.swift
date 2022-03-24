//
//  main.swift
//  Weather-Forecast
//
//  Created by Suhyoung Eo on 2022/03/22.
//

// 특정지역의 날씨를 일별로 조회하여 표시합니다.
// 검색어로 지역명을 조회할 수 있습니다. (예를들어 "york 검색어는 York 와 New York 두 지역을 검색할 수 있습니다.)
// 특정 지역의 날씨를 조회합니다.
// 날짜별로 날씨현황, 최고/저 온도를 표시합니다.
// 지역 및 날씨 조회는 www.metaweather.com 에서 제공하는 Open API를 사용합니다.
// 네트워크로 조회한 결과로 반환되는 JSON을 파싱하여 사용합니다.


import Foundation

struct Location: Codable {
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
}

struct WeatherInfo: Codable {
    let consolidated_weather: [Weather]
}

struct Weather: Codable {
    let weather_state_name: String
    let wind_direction_compass: String
    let applicable_date: String
    let min_temp: Float
    let max_temp: Float
    let the_temp: Float
    let wind_speed: Float
    let wind_direction: Float
    let air_pressure: Float
    let humidity: Float
    let visibility: Float
    let predictability: Float
}

// 정보취득 순서
// 지역 검색 -> [Location]
// Location -> woeid -> [Weather]
// Weather -> print

// let query = "seoul"
// let locQueryUrl = URL(string: "https://www.metaweather.com/api/location/search?query=\(query)")!
//
// if let locData = try? Data(contentsOf: locQueryUrl) {
//     if let locations = try? JSONDecoder().decode([Location].self, from: locData) {
//
//         for location in locations {
//             print("[\(location.title)]")
//
//             let woeid = location.woeid
//             let weatherUrl = URL(string: "https://www.metaweather.com/api/location/\(woeid)")!
//
//             if let weatherData = try? Data(contentsOf: weatherUrl) {
//                 if let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: weatherData) {
//
//                     let weathers = weatherInfo.consolidated_weather
//                     for weather in weathers {
//                         let state = weather.weather_state_name.padding(toLength: 15,
//                                                                        withPad: " ",
//                                                                        startingAt: 0)
//                         let forecast = String(format: "%@: %@ %2.2f°C ~ %2.2f°C",
//                                               weather.applicable_date,
//                                               state,
//                                               weather.max_temp,
//                                               weather.min_temp)
//                         print(forecast)
//                     }
//                 }
//             }
//
//             print("")
//         }
//     }
// }

/* 첫번째 */

func getData(_ url: URL, completion: @escaping (Data) -> Void) {
    // 비동기 처리로 동시에 수행 될 수 있도록 함
    DispatchQueue.global(qos: .default).async {
        if let data = try? Data(contentsOf: url) {
            completion(data)
        }
    }
}

// 지역 검색 -> [Location]
func getLocation(_ query: String, completion: @escaping ([Location]) -> Void) {
    let url = URL(string: "https://www.metaweather.com/api/location/search?query=\(query)")!
    getData(url) { data in
        if let location = try? JSONDecoder().decode([Location].self, from: data) {
            completion(location)
        }
    }
}

// Location -> woeid -> [Weather]
func getWeather(_ woeid: Int, completion: @escaping ([Weather]) -> Void) {
    let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)")!
    getData(url) { data in
        if let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: data) {
            completion(weatherInfo.consolidated_weather)
        }
    }
}

// Weather -> print
func printWeather(_ weather: Weather) {
    
        let state = weather.weather_state_name.padding(toLength: 15,
                                                       withPad: " ",
                                                       startingAt: 0)
        let forecast = String(format: "%@: %@ %2.2f°C ~ %2.2f°C",
                              weather.applicable_date,
                              state,
                              weather.max_temp,
                              weather.min_temp)
        print(forecast)
}

getLocation("san") { locations in
    locations.forEach { location in
        getWeather(location.woeid) { weathers in
            print(location.title)
            weathers.forEach { weather in
                printWeather(weather)
            }
            print("")
        }
    }
}

RunLoop.main.run() //비동기 된 함수 결과값이 올때까지 실행을 끝내지 않고 기다리게 하는 역할
