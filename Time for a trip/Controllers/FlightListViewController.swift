//
//  ViewController.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import UIKit

class FlightListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    private var flights: [Flight] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = UIColor(named: "WB color dark")
        }
        
        setupCollectionView()
        setupActivityIndicator()
        
        fetchFlights()
//        loadTestData() метод для проверки без доступа к сети
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func loadTestData() {
        let testData = createTestData()
        flights = testData
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 150)
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FlightCell.self, forCellWithReuseIdentifier: "FlightCell")
        collectionView.backgroundColor = UIColor(named: "WB color dark")
        view.addSubview(collectionView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
    }
    
    private func fetchFlights() {
        activityIndicator.startAnimating()

        NetworkService.fetchFlights { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()

                switch result {
                case .success(let response):
                    self?.flights = response.flights
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func createTestData() -> [Flight] {
        let flight1 = Flight(startDate: "2023-05-18 00:00:00 +0000 UTC",
                             endDate: "2023-05-20 00:00:00 +0000 UTC",
                             startLocationCode: "ABC",
                             endLocationCode: "XYZ",
                             startCity: "City A",
                             endCity: "City B",
                             serviceClass: "Economy",
                             seats: [],
                             price: 500,
                             searchToken: "ABCXYZ123")

        let flight2 = Flight(startDate: "2023-05-21 00:00:00 +0000 UTC",
                             endDate: "2023-05-23 00:00:00 +0000 UTC",
                             startLocationCode: "DEF",
                             endLocationCode: "GHI",
                             startCity: "City C",
                             endCity: "City D",
                             serviceClass: "Business",
                             seats: [],
                             price: 1000,
                             searchToken: "DEFGHI456")

        return [flight1, flight2]
    }
}

extension FlightListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flights.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCell", for: indexPath) as! FlightCell
        let flight = flights[indexPath.item]
        cell.configure(with: flight)

        return cell
    }
}

extension FlightListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFlight = flights[indexPath.item]
        let detailViewController = FlightDetailViewController(flight: selectedFlight)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

