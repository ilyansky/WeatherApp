import Foundation

class Controller {
    private let model = Model()
    
    func getWeatherTypes() -> [Int: String] {
        return model.weatherTypes
    }
}
