import UIKit

class MainView: UIViewController {
    private let controller = Controller()
    private var weatherTypes = [Int: String]()
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private var weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTypes = controller.getWeatherTypes()
        setCore()
        setCloud()
        setUI()
    }
    
    private func setCore() {
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
    }
    
    
}

// Animations
extension MainView {
    private func setRain() {
        let rain = CAEmitterLayer()
        rain.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        rain.emitterSize = CGSize(width: view.bounds.width, height: 1)
        rain.emitterShape = .line
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(systemName: "drop.fill")?.withTintColor(.systemBlue)?.cgImage
        rainCell.birthRate = 40.0
        rainCell.lifetime = 5.0
        rainCell.velocity = 200
        rainCell.velocityRange = 100
        rainCell.yAcceleration = 300
        rainCell.scale = 0.2
        rainCell.scaleRange = 0.05
        
        rain.emitterCells = [rainCell]
        weatherView.layer.addSublayer(rain)
    }

    private func setSnow() {
        let snow = CAEmitterLayer()
        snow.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        snow.emitterSize = CGSize(width: view.bounds.width, height: 1)
        snow.emitterShape = .line
        
        let snowCell = CAEmitterCell()
        snowCell.contents = UIImage(systemName: "snow")?.withTintColor(.systemIndigo)?.cgImage
        snowCell.birthRate = 14.0
        snowCell.lifetime = 10.0
        snowCell.velocityRange = 10
        snowCell.yAcceleration = 50
        snowCell.scale = 0.35
        
        snow.emitterCells = [snowCell]
        weatherView.layer.addSublayer(snow)
    }
    
    private func setCloud() {
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: -100, y: view.bounds.height / 2)
        cloud.emitterSize = CGSize(width: 1, height: view.bounds.height)
        cloud.emitterShape = .rectangle
        
        let cloudCell = CAEmitterCell()
        cloudCell.contents = UIImage(systemName: "cloud.fill")?.withTintColor(.systemGray)?.cgImage
        cloudCell.birthRate = 2.0
        cloudCell.lifetime = 20.0
        cloudCell.velocity = 50
        cloudCell.velocityRange = 10
        cloudCell.yAcceleration = 0
        cloudCell.scale = 0.8
        
        cloud.emitterCells = [cloudCell]
        weatherView.layer.addSublayer(cloud)
    }
    
    private func setClear() {
        let sun = CAEmitterLayer()
        sun.emitterPosition = CGPoint(x: -100, y: view.bounds.height / 2)
        sun.emitterSize = CGSize(width: 1, height: view.bounds.height)
        sun.emitterShape = .rectangle
        
        let sunCell = CAEmitterCell()
        sunCell.contents = UIImage(systemName: "sun.max.fill")?.withTintColor(.systemYellow)?.cgImage
        sunCell.birthRate = 2.0
        sunCell.lifetime = 20.0
        sunCell.velocity = 50
        sunCell.velocityRange = 10
        sunCell.yAcceleration = 0
        sunCell.scale = 0.7
        
        sun.emitterCells = [sunCell]
        weatherView.layer.addSublayer(sun)
        
    }
    
    private func setThunder() {
        setRain()
        
        let thunderCloud = CAEmitterLayer()
        thunderCloud.emitterPosition = CGPoint(x: -100, y: view.bounds.height / 2)
        thunderCloud.emitterSize = CGSize(width: 1, height: view.bounds.height)
        thunderCloud.emitterShape = .rectangle
        
        let thunderCell = CAEmitterCell()
        thunderCell.contents = UIImage(systemName: "cloud.bolt.fill")?.withTintColor(.systemGray2)?.cgImage
        thunderCell.birthRate = 2.0
        thunderCell.lifetime = 20.0
        thunderCell.velocity = 50
        thunderCell.velocityRange = 10
        thunderCell.yAcceleration = 0
        thunderCell.scale = 0.8
        
        thunderCloud.emitterCells = [thunderCell]
        weatherView.layer.addSublayer(thunderCloud)
    }

}

// Targets
extension MainView {
    @objc func sun() {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherView.alpha = 0.0
        }) { _ in
            self.weatherView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setClear()
            UIView.animate(withDuration: 0.3) {
                self.weatherView.alpha = 1.0
            }
        }
    }
    
    @objc func rain() {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherView.alpha = 0.0
        }) { _ in
            self.weatherView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setRain()
            UIView.animate(withDuration: 0.3) {
                self.weatherView.alpha = 1.0
            }
        }
    }
    
    @objc func snow() {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherView.alpha = 0.0
        }) { _ in
            self.weatherView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setSnow()
            UIView.animate(withDuration: 0.3) {
                self.weatherView.alpha = 1.0
            }
        }
    }
    
    @objc func cloud() {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherView.alpha = 0.0
        }) { _ in
            self.weatherView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setCloud()
            UIView.animate(withDuration: 0.3) {
                self.weatherView.alpha = 1.0
            }
        }
    }
    
    @objc func thunder() {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherView.alpha = 0.0
        }) { _ in
            self.weatherView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setThunder()
            UIView.animate(withDuration: 0.3) {
                self.weatherView.alpha = 1.0
            }
        }
        
    }
}

// TableView
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        weatherTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: 0)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { fatalError() }
        
        cell.weatherImage.image = UIImage(named: String(indexPath.section))
        cell.weatherName.text = weatherTypes[indexPath.section]

        switch indexPath.section {
        case 0: cell.weatherButton.addTarget(self, action: #selector(sun), for: .touchUpInside)
        case 1: cell.weatherButton.addTarget(self, action: #selector(cloud), for: .touchUpInside)
        case 2: cell.weatherButton.addTarget(self, action: #selector(rain), for: .touchUpInside)
        case 3: cell.weatherButton.addTarget(self, action: #selector(snow), for: .touchUpInside)
        case 4: cell.weatherButton.addTarget(self, action: #selector(thunder), for: .touchUpInside)
        default: break
        }
        
        
        return cell
    }

}

// UI
extension MainView {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(weatherCollectionView)
        view.addSubview(weatherView)
        view.sendSubviewToBack(weatherView)
        
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            weatherCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
        
    }
}

extension UIImage {
    func withTintColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        withRenderingMode(.alwaysOriginal).draw(in: CGRect(origin: .zero, size: size))
        
        context.setFillColor(color.cgColor)
        context.setBlendMode(.sourceAtop)
        context.fill(CGRect(origin: .zero, size: size))
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
}
