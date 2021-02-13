//
//  ViewController.swift
//  Evaluation2021
//
//  Created by Yashika on 2/12/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import UIKit

//enum for tab type
enum TabType: Int {
    case photos
    case videos
    case fav
}

class HomescreenViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageHEightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoSelectionView: UIView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var videoSelectionView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteSelectionView: UIView!
    @IBOutlet weak var tablewView: UITableView!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    //MARK: Action methods
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        updateFrameOnScrollDown()
        searchTextField.becomeFirstResponder()
    }
    
    @IBAction func tabSelected(_ sender: UIButton) {
        tabSelectedType = TabType(rawValue: sender.tag) ?? tabSelectedType
        updateTabSelected(type: sender.tag)
        switch tabSelectedType {
        case .photos:
            fetchPhotoApi()
        case .videos:
            fetchVideoApi()
        default:
            tablewView.reloadData()
            print("Do nothing")
        }
        
    }
    
    //MARK: Variables
    var tabSelectedType: TabType = .photos
    var searchText = "animals"
    var photoArray: [PhotoResponse]?
    var videosArray: [VideoResponse]?
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        // Do any additional setup after loading the view.
    }
    
    private func initialSetUp() {
        headerHeightConstraint.constant = 0
        updateTabSelected(type: 0)
        scrollView.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        tablewView.delegate = self
        tablewView.register(cell: HomeTableViewCell.self)
        checkFirstLaunch()
    }
    
    //Check first launch to show animal pictures
    private func checkFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            fetchPhotoApi()
        } else {
            print("First launch, setting UserDefault.")
            fetchSearchPhotoApi(searchText: "animals")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    //Handle scroll animation to hide banner image
    private func updateFrameOnScrollUp() {
        UIView.animate( withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.bannerImageHEightConstraint.constant = 0
            self.headerHeightConstraint.constant = 56
        })
    }
    
    //Handle scroll animation to Show banner image
    private func updateFrameOnScrollDown() {
        UIView.animate( withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.bannerImageHEightConstraint.constant = 300
            self.headerHeightConstraint.constant = 0
        })
    }
    
    //Handle tab selection
    private func updateTabSelected(type: Int) {
        let viewUnselectedColor = UIColor.clear
        photoButton.setTitleColor(photoButton.tag == type ? Colors.selectedTabColor : Colors.unselectedTabColor, for: .normal)
        videoButton.setTitleColor(videoButton.tag == type ? Colors.selectedTabColor : Colors.unselectedTabColor, for: .normal)
        favoriteButton.setTitleColor(favoriteButton.tag == type ? Colors.selectedTabColor : Colors.unselectedTabColor, for: .normal)
        photoSelectionView.backgroundColor = photoSelectionView.tag == type ? Colors.selectedTabColor : viewUnselectedColor
        videoSelectionView.backgroundColor = videoSelectionView.tag == type ? Colors.selectedTabColor : viewUnselectedColor
        favoriteSelectionView.backgroundColor = favoriteSelectionView.tag == type ? Colors.selectedTabColor : viewUnselectedColor
    }
    
    //API call for photo list
    private func fetchPhotoApi() {
        HomeScreenManager().fetchAllPhotos(completionHandler: { [weak self] (response) in
            if let responseList = response {
                if let photosArray = responseList.photos {
                    self?.photoArray = photosArray
                    let bgImageURL = URL(string: photosArray[0].src?.medium ?? "")
                    self?.bannerImageView.downloadImage(from: bgImageURL!)
                    self?.tablewView.reloadData()
                }
            }else {
                print("Empty Data")
            }
        }) { (error) in
            print(error)
        }
    }
    
    //Photo search api
    private func fetchSearchPhotoApi(searchText: String) {
        HomeScreenManager().fetchPhotoSearch(text: searchText, completionHandler: { [weak self] (response) in
            if let responseList = response {
                
                print(responseList)
                if let photosArray = responseList.photos {
                    self?.photoArray = photosArray
                    let bgImageURL = URL(string: photosArray[0].src?.medium ?? "")
                    self?.bannerImageView.downloadImage(from: bgImageURL!)
                    self?.tablewView.reloadData()
                }
            }else {
                print("Empty Data")
                
            }
        }) { (error) in
            print(error)
        }
        
    }
    
    //Video search api
    private func fetchSearchVideoApi(searchText: String) {
        HomeScreenManager().fetchVideoSearch(text: searchText, completionHandler: { [weak self] (response) in
            if let responseList = response {
                
                print(responseList)
                if let videos = responseList.videos {
                    self?.videosArray = videos
                    self?.tablewView.reloadData()
                }
            }else {
                print("Empty Data")
                
            }
        }) { (error) in
            print(error)
        }
    }
    
    //Video Fetch Api
    private func fetchVideoApi() {
        HomeScreenManager().fetchVideos(completionHandler: { [weak self] (response) in
            if let responseList = response {
                if let videos = responseList.videos {
                    self?.videosArray = videos
                    self?.tablewView.reloadData()
                }
            }else {
                print("Empty Data")
                
            }
        }) { (error) in
            print(error)
        }
        
    }
    
}

//MARK: TableViewDataSourceMethod
extension HomescreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabSelectedType {
        case .photos:
            return photoArray?.count ?? 0
        case .videos:
            return videosArray?.count ?? 0
        case .fav:
            return HomeScreenManager.favPhoto.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTableViewCell.self)", for: indexPath) as? HomeTableViewCell
        
        switch tabSelectedType {
        case .photos:
            if let data = photoArray?[indexPath.row] {
                cell?.connfigureCell(data: data, type: tabSelectedType)
                cell?.favTapped = {
                    
                }
            }
        case .videos:
            if let data = videosArray?[indexPath.row] {
                cell?.configureVideoCell(data: data, type: tabSelectedType)
                cell?.favTapped = {
                    
                }
            }
        case .fav:
            if let data = photoArray?[indexPath.row] {
                cell?.connfigureCell(data: data, type: tabSelectedType)
                cell?.favTapped = {
                    
                }
            }
        }
        return cell ?? UITableViewCell()
    }
}

//MARK: TableViewDelagateMethod
extension HomescreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tabSelectedType {
        case .photos:
            //Show photo detail screen
            if let photoDetailVC = PhotoDetailController.controller() {
                if let data = photoArray?[indexPath.row], let id = data.id {
                    photoDetailVC.photoID = id
                    self.navigationController?.pushViewController(photoDetailVC, animated: true)
                }
            }
            
        case .videos:
            //Show video detail screen
            if let videoDetailVC = VideoDetailViewController.controller() {
                if let data = videosArray?[indexPath.row], let id = data.id {
                    videoDetailVC.videoID = id
                    self.navigationController?.pushViewController(videoDetailVC, animated: true)
                }
            }
            
        case .fav:
            print("fav type tapped")
        }
    }
}

//MARK: Scrollviewdelegate
extension HomescreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > 0 {
            updateFrameOnScrollUp()
        }else if scrollView.contentOffset.y < 0 {
            updateFrameOnScrollDown()
        }
    }
}

//MARK: TextFieldDelegate
extension HomescreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text ?? ""
        textField.text = ""
        tabSelectedType == .photos ? fetchSearchPhotoApi(searchText: searchText) : fetchSearchVideoApi(searchText: searchText)
        textField.resignFirstResponder()
        return true
    }
}
