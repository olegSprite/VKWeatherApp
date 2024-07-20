//
//  ViewController.swift
//  VKWeatherApp
//
//  Created by Олег Спиридонов on 16.07.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Public Properties
    
    let topWeatherState: [WeatherModel] = [
        WeatherModel(title: NSLocalizedString("sun.max", comment: "Ясно"), image: UIImage(systemName: "sun.max")),
        WeatherModel(title: NSLocalizedString("cloud.rain", comment: "Дождь"), image: UIImage(systemName: "cloud.rain")),
        WeatherModel(title: NSLocalizedString("cloud.bolt", comment: "Гроза"), image: UIImage(systemName: "cloud.bolt")),
        WeatherModel(title: NSLocalizedString("smoke", comment: "Туман"), image: UIImage(systemName: "smoke")),
        WeatherModel(title: NSLocalizedString("cloud.sun", comment: "Облачно"), image: UIImage(systemName: "cloud.sun")),
        WeatherModel(title: NSLocalizedString("snowflake", comment: "Снег"), image: UIImage(systemName: "snowflake"))
    ]
    var curentWeather: WeatherModel?
    
    // MARK: - Private Properties
    
    private let topWeatherSelectorCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let imageOnMainScreen = UIImageView()
    
    // MARK: - Initializers
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curentWeather = topWeatherState.randomElement()
        setupTableView()
        setupViews()
        updatePictureOnMainScreen()
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        addTopWeatherSelectorCollectionView()
        addImageOnMainScreen()
    }
    
    private func addTopWeatherSelectorCollectionView() {
        topWeatherSelectorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topWeatherSelectorCollectionView)
        NSLayoutConstraint.activate([
            topWeatherSelectorCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topWeatherSelectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topWeatherSelectorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topWeatherSelectorCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addImageOnMainScreen() {
        imageOnMainScreen.contentMode = .scaleAspectFit
        imageOnMainScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageOnMainScreen)
        NSLayoutConstraint.activate([
            imageOnMainScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOnMainScreen.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageOnMainScreen.heightAnchor.constraint(equalToConstant: 400),
            imageOnMainScreen.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    // MARK: - Public Methods
    
    func updatePictureOnMainScreen() {
        stopPulsatingAnimation()
        UIView.transition(with: imageOnMainScreen,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            self.imageOnMainScreen.image = self.curentWeather?.image
        },
                          completion: { _ in
            self.startPulsatingAnimation()
        })
        let bounceAnimation = CAKeyframeAnimation(keyPath: "position")
        let startPoint = imageOnMainScreen.layer.position
        let bounceDistance: CGFloat = 20
        bounceAnimation.values = [
            CGPoint(x: startPoint.x, y: startPoint.y),
            CGPoint(x: startPoint.x, y: startPoint.y - bounceDistance),
            CGPoint(x: startPoint.x, y: startPoint.y + bounceDistance),
            startPoint
        ]
        bounceAnimation.keyTimes = [0, 0.5, 0.75, 1]
        bounceAnimation.duration = 0.5
        bounceAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeIn),
            CAMediaTimingFunction(name: .easeOut)
        ]
        imageOnMainScreen.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        topWeatherSelectorCollectionView.dataSource = self
        topWeatherSelectorCollectionView.delegate = self
        topWeatherSelectorCollectionView.showsHorizontalScrollIndicator = false
        topWeatherSelectorCollectionView.register(TopWetherSelectorCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func startPulsatingAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.2
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        imageOnMainScreen.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    private func stopPulsatingAnimation() {
        imageOnMainScreen.layer.removeAnimation(forKey: "pulseAnimation")
    }
    
    // MARK: - Public Actions
    // MARK: - Private Actions
    
}

