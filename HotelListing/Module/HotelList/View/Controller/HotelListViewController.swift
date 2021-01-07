//
//  HotelListViewController.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

class HotelListViewController: BaseViewController, AlertPresenatable {
    
    @IBOutlet weak var hotelTableView: UITableView!
    
    var isLoading: Bool = false
    
    var sortBy: SortBy! = .priority{
        didSet{
            guard let viewModel = viewModel else {return }
            viewModel.updateDataSource(sortedBy: sortBy)
            viewModel.resetDataSource()
            updateTableView()
            loadMoreData()
        }
    }
    /// initiate a refreshControl variable
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(HotelListViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.backgroundColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        refreshControl.tintColor = UIColor(red: 0/255.0, green: 49/255.0, blue: 67/255.0, alpha: 1.0)
        
        return refreshControl
    }()
    
    var viewModel: HotelViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchHotelList()
    }
    
    /// pull to refresh action
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchHotelList()
        
    }
    
    /// load data 10 by 10 when we scroll the tableview
    func loadMoreData() {
        guard !viewModel.reachedEndOfItems else {
            return
        }
        
        if !isLoading {
            isLoading = true
            let (start,end) = viewModel.loadMoreData()
            
            var reloadIndexPaths = [IndexPath]()
            
            for row in start..<end {
                reloadIndexPaths += [IndexPath(row: row, section: 0)]
            }
            
            DispatchQueue.main.async {
                self.hotelTableView.beginUpdates()
                self.hotelTableView.insertRows(at: reloadIndexPaths, with: .automatic)
                self.hotelTableView.endUpdates()
            }
            
            isLoading = false
            return
        }
        
        updateTableView()
        
    }
    /// to filter the hotels depend on the user type in search box and update in the list
    func filterHotels(_ hotel: String) {
        viewModel.filterHotels(hotel)
        viewModel.resetDataSource()
        updateTableView()
        loadMoreData()
    }
    
    /// when user clear all the typed string in search box.
    func clearFilter() {
        viewModel.clearFilter()
        viewModel.resetDataSource()
        updateTableView()
        loadMoreData()
    }

    func updateTableView() {
        self.hotelTableView.reloadData()
    }
}

extension HotelListViewController {
    
    /// Initialize the reuired items and ui customization and coonfiguration
    fileprivate func initialSetup() {
        self.hotelTableView.addSubview(self.refreshControl)
        self.hotelTableView.rowHeight = UITableView.automaticDimension
        self.hotelTableView.estimatedRowHeight = 44
        hotelTableView.register(HotelTableViewCell.nib, forCellReuseIdentifier: HotelTableViewCell.resuseIdentifier)
    }
    
    /// This method fetch hotels and display the updated data on tableview
    fileprivate func fetchHotelList() {
        if !refreshControl.isRefreshing {
            Loader.presentOnWindow()
        }

        viewModel.fetchHotelItems { [weak self] (result) in
            guard let self = self else { return }
            Loader.dismissFromWindow()
            self.refreshControl.endRefreshing()

            switch result {
            case .success(let hotels):
                self.viewModel.resetDataSource()
                self.updateTableView()
                self.refreshData(hotelList: hotels)
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    /// This method show tha updated data on table view if data is not available it will show an alert message
    /// - Parameter hotelList: array of HotelListCellViewModel which updated with data source to show latest data
    private func refreshData(hotelList: [HotelItemViewModel]) {
        
        guard  hotelList.isNotEmpty else {
            return showAlert(message: NoHotelMsg.localized)
        }
        
        self.loadMoreData()
    }
    
    /// This method will show an alert with specified message
    /// - Parameter message: this is the message which we need to show on alert
    private func showAlert(message: String?) {
        showAlert(title: "", message: message, actionTexts: [kOK], completion: nil)
    }
}

extension HotelListViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRows() - 1 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HotelTableViewCell = tableView.dequeueReusableCell(withIdentifier: HotelTableViewCell.resuseIdentifier) as? HotelTableViewCell ?? HotelTableViewCell.firstView as! HotelTableViewCell
        let item = viewModel.itemViewModel(at: indexPath)
        cell.configureCell(viewModel: item)
        return cell
    }
    
}

extension HotelListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
