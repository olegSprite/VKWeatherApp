//
//  TopWetherSelectorCell.swift
//  VKWeatherApp
//
//  Created by Олег Спиридонов on 18.07.2024.
//

import Foundation
import UIKit

final class TopWetherSelectorCell: UICollectionViewCell {
    // MARK: - Public Properties
    // MARK: - Private Properties
    
    private let imageWeatherView = UIImageView()
    private let titileWeatherLable = UILabel()
    private let borderView = UIView()
    
    // MARK: - Initializers
    // MARK: - Lifecycle
    // MARK: - Layout
    
    private func addImageView(weather: WeatherModel) {
        imageWeatherView.image = weather.image
        imageWeatherView.contentMode = .scaleAspectFit
        imageWeatherView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageWeatherView)
        NSLayoutConstraint.activate([
            imageWeatherView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageWeatherView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageWeatherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageWeatherView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addTitleWeatherLable(weather: WeatherModel) {
        titileWeatherLable.text = weather.title
        titileWeatherLable.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titileWeatherLable.textAlignment = .center
        titileWeatherLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titileWeatherLable)
        NSLayoutConstraint.activate([
            titileWeatherLable.topAnchor.constraint(equalTo: imageWeatherView.bottomAnchor, constant: 5),
            titileWeatherLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titileWeatherLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Public Methods
    
    func setupCell(weather: WeatherModel) {
        addImageView(weather: weather)
        addTitleWeatherLable(weather: weather)
    }
    
    func selectCell() {
        borderView.layer.borderWidth = 3
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.cornerRadius = 16
        borderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func deselectCell() {
        borderView.removeFromSuperview()
    }
    
    // MARK: - Private Methods
    // MARK: - Public Actions
    // MARK: - Private Actions
}
