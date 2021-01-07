//
//  HotelTableViewCell.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

class HotelTableViewCell: UITableViewCell, ReuseIdentifiable, ViewFromNib {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLbl: UILabel!
    @IBOutlet weak var hotelRatingLbl: UILabel!
    @IBOutlet weak var hotelAddressLbl: UILabel!
    @IBOutlet weak var hotelPriceLbl: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    static let hotelCellIdentifier = "hotelCellIdentifier"

    static var resuseIdentifier: String {
        return HotelTableViewCell.hotelCellIdentifier
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        cardView.setCardView()
    }

    // MARK: - Configure Cell
    
    /// This method will show the data provided on the cell
    /// - Parameter hotelCellModel: HotelListCellViewModel, from which cell will show the data

    func configureCell(viewModel: HotelItemRepresentable) {
        self.hotelImageView.image = nil
        hotelNameLbl.text = viewModel.title
        hotelRatingLbl.text = viewModel.starRatingString
        hotelAddressLbl.text = viewModel.address
        hotelPriceLbl.text = viewModel.priceString

        
        if let imageURL = viewModel.imageURL {
            SRImageDownloader.shared.downloadImage(from: imageURL) { (image, error) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.hotelImageView.image = image.imageResized(to: self.hotelImageView.bounds.size)
                    }
                }else {
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    
}
