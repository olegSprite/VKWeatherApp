//
//  ViewController + extention.swift
//  VKWeatherApp
//
//  Created by Олег Спиридонов on 18.07.2024.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topWeatherState.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopWetherSelectorCell else { return UICollectionViewCell() }
        cell.setupCell(weather: topWeatherState[indexPath.row])
        if self.curentWeather == topWeatherState[indexPath.row] {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            cell.selectCell()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopWetherSelectorCell else { return }
        cell.selectCell()
        self.curentWeather = topWeatherState[indexPath.row]
        self.updatePictureOnMainScreen()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopWetherSelectorCell else { return }
        cell.deselectCell()
    }
}
