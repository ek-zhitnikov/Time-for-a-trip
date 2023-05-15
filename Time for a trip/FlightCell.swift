//
//  FlightCell.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import UIKit

class FlightCell: UICollectionViewCell {
    private var departureLabel: UILabel!
    private var arrivalLabel: UILabel!
    private var departureDateLabel: UILabel!
    private var returnDateLabel: UILabel!
    private var priceLabel: UILabel!
    private var likeButton: UIButton!
    private var isLiked: Bool = false
    var flight: Flight!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLabels()
        setupLikeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        departureLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 300, height: 20))
        addSubview(departureLabel)
        
        arrivalLabel = UILabel(frame: CGRect(x: 20, y: departureLabel.frame.maxY + 10, width: 300, height: 20))
        addSubview(arrivalLabel)
        
        departureDateLabel = UILabel(frame: CGRect(x: 20, y: arrivalLabel.frame.maxY + 10, width: 300, height: 20))
        addSubview(departureDateLabel)
        
        returnDateLabel = UILabel(frame: CGRect(x: 20, y: departureDateLabel.frame.maxY + 10, width: 300, height: 20))
        addSubview(returnDateLabel)
        
        priceLabel = UILabel(frame: CGRect(x: 20, y: returnDateLabel.frame.maxY + 10, width: 300, height: 20))
        addSubview(priceLabel)
    }
    
    private func setupLikeButton() {
        likeButton = UIButton(frame: CGRect(x: bounds.width - 50, y: bounds.height / 2 - 15, width: 30, height: 30))
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        addSubview(likeButton)
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func configure(with flight: Flight) {
        self.flight = flight
        
        departureLabel.text = "From: \(flight.startCity)"
        arrivalLabel.text = "To: \(flight.endCity)"
        departureDateLabel.text = "Departure: \(flight.startDate)"
        returnDateLabel.text = "Return: \(flight.endDate)"
        priceLabel.text = "Price: \(flight.price) rubles"
    }
}
