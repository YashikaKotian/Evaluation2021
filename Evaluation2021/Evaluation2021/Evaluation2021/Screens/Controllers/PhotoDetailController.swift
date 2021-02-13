//
//  PhotoDetailController.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailController: UIViewController {
    
    //Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favIcon: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    
    //MARK: Action methods
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func favTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func zoomInTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func zoomOutTapped(_ sender: Any) {
        
    }
    
    //Variable
    var photoDetail: PhotoResponse?
    var photoID = Double()
    
    //Instantiate controller
    class func controller() -> PhotoDetailController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(PhotoDetailController.self)") as? PhotoDetailController
    }
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    private func initialSetUp() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        callDetailApi()
    }
    
    //API for photo details
    private func callDetailApi() {
        HomeScreenManager().GetEachPhoto(id: photoID, completionHandler: { [weak self] (response) in
            if let responseList = response {
                print(responseList)
                self?.photoDetail = responseList
                self?.updateUI()
            }else {
                print("Empty Data")
                
            }
        }) { (error) in
            print(error)
        }
        
    }
    
    //Update ui after api data fetch
    private func updateUI() {
        userNameLabel.text = photoDetail?.photographer ?? ""
        let selectedImage = UIImage(named: "favSelected")
        let unSelectedImage = UIImage(named: "favUnselected")
        favIcon.setImage(photoDetail?.liked ==  true ? selectedImage : unSelectedImage, for: .normal)
        let bgImageURL = URL(string: photoDetail?.src?.portrait ?? "")
        self.bgImageView.downloadImage(from: bgImageURL!)
    }
}
