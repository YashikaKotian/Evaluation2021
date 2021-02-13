//
//  HomeTableViewCell.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var videoPlayButton: UIButton!
    
    //ClosureMethods
    var playVideo: (()-> Void)?
    var favTapped: (()-> Void)?
    
    var photodata: PhotoResponse?
    
    //Handle fav tap
    @IBAction func favTapped(_ sender: UIButton) {
        if var data = photodata {
        data.liked = true
        HomeScreenManager.favPhoto.append(data)
        favTapped?()
        }
    }
    
    //Play video tapped
    @IBAction func playButtonTapped(_ sender: UIButton) {
        playVideo?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //Configure Photo cell
    func connfigureCell(data: PhotoResponse, type: TabType) {
        photodata = data
        let bgImageURL = URL(string: data.src?.medium ?? "")
        self.bgImageView.downloadImage(from: bgImageURL!)
        userNameLabel.text = data.photographer ?? ""
        let selectedImage = UIImage(named: "favSelected")
        let unSelectedImage = UIImage(named: "favUnselected")
        favButton.setImage((data.liked ==  true || type == .fav) ? selectedImage : unSelectedImage, for: .normal)
        videoPlayButton.isHidden = type == .videos ? false : true
    }
    
    //Configure Video cell
    func configureVideoCell(data: VideoResponse, type: TabType) {
        let bgImageURL = URL(string: data.image ?? "")
        self.bgImageView.downloadImage(from: bgImageURL!)
        userNameLabel.text = data.user?.name ?? ""
        let selectedImage = UIImage(named: "favUnselected")
        favButton.setImage(selectedImage, for: .normal)
        videoPlayButton.isHidden = false
    }
    
    //Reset all elements
    override func prepareForReuse() {
        super.prepareForReuse()
        bgImageView.image = nil
        userNameLabel.text = nil
        videoPlayButton.isHidden = true
    }
}
