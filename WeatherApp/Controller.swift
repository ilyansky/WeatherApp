import Foundation

class Controller {
    private let model = Model()
    
    func getWeatherTypes() -> [String] {
        return model.weatherTypes
    }
}
