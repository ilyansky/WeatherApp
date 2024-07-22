import UIKit

class MainView: UIViewController {
    private let controller = Controller()
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCore()
        setUI()
    }
    
    private func setCore() {
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
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
        controller.getWeatherTypes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: 0)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { fatalError() }
        
        return cell
    }

}

// UI
extension MainView {
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(weatherCollectionView)
//        weatherCollectionView.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            weatherCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)


        
            
        ])
        
    }
}

