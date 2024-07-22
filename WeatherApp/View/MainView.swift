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
        
        return view
    }()
    
    private let weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTypes = controller.getWeatherTypes()
        setCore()
        setSnow()
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
        rainCell.contents = UIImage(systemName: "drop.fill")?.cgImage
        rainCell.birthRate = 40.0
        rainCell.lifetime = 5.0
        rainCell.velocity = 200
        rainCell.velocityRange = 100
        rainCell.yAcceleration = 300
        rainCell.scale = 0.1
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
        snowCell.contents = UIImage(systemName: "snow")?.cgImage
        snowCell.birthRate = 14.0
        snowCell.lifetime = 10.0
        snowCell.velocityRange = 10
        snowCell.yAcceleration = 50
        snowCell.scale = 0.35
        
        snow.emitterCells = [snowCell]
        weatherView.layer.addSublayer(snow)
    }
    
    private func setClear() {
        let sun = CALayer()
        let sunSize: CGFloat = 100

        sun.contents = UIImage(systemName: "sun.max.fill")?.withTintColor(.yellow).cgImage
        
        sun.bounds = CGRect(x: 0, y: 0, width: sunSize, height: sunSize)
        sun.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        
        let rotAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotAnimation.duration = 10
        rotAnimation.isCumulative = true
        rotAnimation.repeatCount = .infinity
        
        weatherView.layer.addSublayer(sun)
        
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
        
//        cell.weatherButton.addTarget(self, action: #selector(/*<#T##@objc method#>*/), for: <#T##UIControl.Event#>)
        
        return cell
    }

}

// UI
extension MainView {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(weatherCollectionView)
        view.addSubview(weatherView)
        
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

