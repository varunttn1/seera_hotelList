//
//  ContainerViewController.swift
//  HotelListing
//
//  Created by Varun Kumar on 05/01/21.
//

import UIKit

enum SelectionType: Int  {
    case hotel
    case map
    var title: String {
        switch self  {
        case .hotel:
            return kSort
        case .map:
            return kMap
        }
    }
}

enum SortBy: Int {
    case priority, lowestPrice, starRating, distance, count
    static var titles = [priority: "Priority", lowestPrice: "Lowest Price", starRating: "Star Rating", distance: "Distance"]
    var title: String {
        return SortBy.titles[self] ?? ""
    }
}


class ContainerViewController: BaseViewController {

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchImageView: UIImageView!
    @IBOutlet weak var vContainerView: UIView!
    
    @IBOutlet weak var sortButton: UIButton!
    
    private var currentViewController: UIViewController?
    
    var hotelDataSource: HotelFetchable!

    lazy var hotelListViewController: HotelListViewController = {
        let viewController = HotelListViewController.viewController()
        self.addChildViewController(viewController, inView: vContainerView)
        return viewController
    }()

    lazy var mapListController: MapListViewController = {
        let viewController =  MapListViewController.viewController()
        self.addChildViewController(viewController, inView: vContainerView)
        return viewController

    }()
    
    var selectionType: SelectionType = .hotel

    fileprivate var currentTab : SelectionType = .hotel {
        didSet{
            switch self.currentTab {
            case .hotel:
                remove(asChildViewController: mapListController)
                self.addChildViewController(hotelListViewController, inView: vContainerView)
                
            case .map:
                remove(asChildViewController: hotelListViewController)
                self.addChildViewController(mapListController, inView: vContainerView)

            }
        }
    }
    
    let dropDown = DropDown()
    var dropDownRowHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureGestureRecognizer()
        currentTab = selectionType
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpDropDown()
    }
}

extension ContainerViewController {
    
    /// Initialize the reuired items and ui customization and coonfiguration
    fileprivate func initialSetup() {
        hotelListViewController =  HotelListViewController.viewController()
        mapListController = MapListViewController.viewController()
        
        hotelDataSource = HotelDataSource(apiService: HotelAPIService())
        let viewModel = HotelViewModel(hotelDataSource: hotelDataSource)
        hotelListViewController.viewModel = viewModel
        mapListController.viewModel = hotelDataSource

        searchTextField.text = ""
        clearSearchImageView.isHidden = true
//        searchTextField.becomeFirstResponder()
        searchBarView.clipsToBounds = true
        searchBarView.layer.cornerRadius = 6.0
    }
    
}
extension ContainerViewController {
    /// Gesture recongnizer setup
    private func configureGestureRecognizer(){
        clearSearchImageView.isUserInteractionEnabled = true
        let clearButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.clearTextField(_:)))
        clearSearchImageView.addGestureRecognizer(clearButtonTap)

    }
    
    /// Clear the TextField when cross button tapped
    /// - Parameter sender: UITapGestureRecognizer
    @objc func clearTextField(_ sender: UITapGestureRecognizer? = nil) {
        searchTextField.text = ""
        clearSearchImageView.isHidden = true
    }
    
    /// Place holder configuration
    private func configurePlaceHolder() {
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: KSearchKeyWord.localized ,attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)])
    }
    
    //MARK: - IBActions -
    
    /// If textfield charcters are more then one then the clear textfield cross button is shown else remains hidden
    /// - Parameter sender: Any
    @IBAction func searchEditingChanged(_ sender: Any) {
        if searchTextField.text!.removeWhiteSpace().count < 1 {
            clearSearchImageView.isHidden = true
        } else {
            clearSearchImageView.isHidden = false
        }
        self.dropDown.hideDropDown()
    }
    
    
}

extension ContainerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dropDown.hideDropDown()

    }
    
    /// when user enter any text in textfield
    /// - Parameter textField: selected textfield, removes white spaces , appends the searched item into the recently searched item.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = searchTextField.text!.removeWhiteSpace()
        guard !text.isEmpty else {
            hotelListViewController.clearFilter()
            return
        }
        
        hotelListViewController.filterHotels(text)
    }
    
    /// when return button of the keyboard is tapped hides the keyboard , removes white spaces , appends the searched item into the recently searched item.
    /// - Parameter textField: selected textfield
    /// - Returns: boolean
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchTextField.text!.removeWhiteSpace().count > 0 {
            searchTextField.resignFirstResponder()
            searchTextField.endEditing(true)
        } else {
            searchTextField.resignFirstResponder()
            searchTextField.endEditing(true)
        }
        return true
    }
}

extension ContainerViewController {
    ///when the sort button tapped show the sort view
    @IBAction func sortByAction(_sender : AnyObject){
        currentTab = .hotel
        self.dropDown.showDropDown(height: self.dropDownRowHeight * CGFloat(SortBy.count.rawValue))

    }
    
    ///when the sort button tapped hide the sortview and show the map view
    @IBAction func mapViewAction(_sender : AnyObject){
        currentTab = .map
        self.dropDown.hideDropDown()
    }
}

extension ContainerViewController: DropDownProtocol {
    
    /// configure the drop down view to  show the list of sorting
    func setUpDropDown(){
        dropDown.dropDownIdentifier = "DROP_DOWN"
        dropDown.cellReusableIdentifier = "sortingCell"
        dropDown.dropDownProtocol = self
        dropDown.setUpDropDown(viewPositionReference: (sortButton.frame), offset: 65)
        dropDown.nib = UINib(nibName: "SortingTableCell", bundle: nil)
        dropDown.setRowHeight(height: self.dropDownRowHeight)
        self.view.addSubview(dropDown)
    }
    
    /// DropDownProtocol method to cofigur the data in sorting cell
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, dropDownIdentifier: String) {
        if dropDownIdentifier == "DROP_DOWN"{
            let customCell = cell as! SortingTableCell
            customCell.titleLabel.text = SortBy(rawValue: indexPos)?.title
        }
    }
    
    /// DropDownProtocol method to setup the number of row
    func numberOfRows(dropDownIdentifier: String) -> Int {
        return SortBy.count.rawValue
    }
    
    /// DropDownProtocol method when we select any sorting indix from list
    func selectItemInDropDown(indexPos: Int, dropDownIdentifier: String) {
        hotelListViewController.sortBy = SortBy(rawValue: indexPos)
        self.dropDown.hideDropDown()
    }
    
}


