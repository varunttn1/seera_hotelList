# Hotel Listing
> TO THE NEW -  Seera  assignment  for hotel listing.

## Version
1.0

## Build Requirements

- iOS 13.0+
- Xcode 12.0+

## Runtime Requirements
- iOS 13.0+

## Swift Version
- Swift 5.0

## Features

- [1] App shows the hotel list in tableview and mapView.
- [2] A search bar at top to search the hotels from the hotel list api.
- [3] Sorting list view for sorting the hotellist depend on lowest price, distance, starRating.
- [4] Pull to refersh to get the latest data in list view
- [5] Lazy loading to load the data 10 by 10.
- [6] Localization to supports the device language. 

## About Hotel Listing 

Hotel listing is a sample application to:
- [1] Use public API to fetch hotel list. 
- [2] List the results in a UITableView
        a) Display image, name, rating, address and price of hotel.
- [3] Display all hotels in mapView.
- [4] Search the hotel by name filter the hotel from the hotel list array and show them in tableview


## Application Architecture
This app follows MVVM - C Architecture with POP approach of the Swift Language.
This app is grouped into Model, View & ViewModel Xcode Groups. Each of these Xcode groups maps one-to-one with the section.

### Model
The main model of the app is 'Hotel' Struct. Which is used to store hotel information. It is actually a Data Model.

### View
The main view of the app is ContainerViewController which containes:
    a) Search Bar,
    b) Sort and Map Button- Tap on sort button sorting view will populate, Tap on Map Button Map view will populate
    c) Two Container Views- One is HotelList Container View, Another is MapView Container View.
    d) HotelListViewController display the hotel list
    e) MapListViewController display the hotels in Map.

HotelsTableViewCell is plain vanilla UITableViewCell subclass. This cell is styled with 'image, name, rating, address, price'

### ViewModel
The main ViewModel is 'HotelViewModel', Which is used to
a) fetch hotel list
b) loadMoreData when we scroll up the tableview.

+ HotelItemViewModel is used to show data on cell.

## Testing
I've added some unit tests to this sample to demonstrate how easy value types are to test since they have no dependencies. See the Swift files in the "HotelListingTests" Xcode group for more detailed descriptions of these tests.

+ ### HotelListViewControllerTests
        This is used to test the view controller have table view and confrom the required protocol of table view and cell is showing data from specified data model

+ ### HotelListTests
        This is used to test the code to check if data is available and or when some error occured in network request.


