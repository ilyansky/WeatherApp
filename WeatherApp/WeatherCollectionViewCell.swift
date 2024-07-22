import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let id = "weatherTableViewCell"
    let weatherButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    @objc func tap() {
        print("tap")
    }
    
    private func setUI() {
        addSubview(weatherButton)
        weatherButton.layer.cornerRadius = 20
        weatherButton.backgroundColor = .systemIndigo
//        weatherButton.setTitle("asdasd", for: .normal)
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            weatherButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            weatherButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),

        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
