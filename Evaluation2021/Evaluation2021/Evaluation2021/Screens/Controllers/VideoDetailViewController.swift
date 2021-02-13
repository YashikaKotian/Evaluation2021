//
//  VideoDetailViewController.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoDetailViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!

    //MARK: Action Methods
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        
    }
    
    
    //Variable
    var videoDetail: VideoResponse?
    var videoID = Double()

    //Instantiate controller
    class func controller() -> VideoDetailViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(VideoDetailViewController.self)") as? VideoDetailViewController
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
    
    //MARK: Fetch video detail api
    private func callDetailApi() {
        HomeScreenManager().GetEachVideo(id: videoID, completionHandler: { [weak self] (response) in
                    if let responseList = response {
                        print(responseList)
                        self?.videoDetail = responseList
                        self?.updateUI()
                    }else {
                        print("Empty Data")

                            }
                }) { (error) in
                    print(error)
                }

    }

    //Update ui after api fetch
    private func updateUI() {
        userNameLabel.text = videoDetail?.user?.name ?? ""
        let unSelectedImage = UIImage(named: "favUnselected")
        favButton.setImage(unSelectedImage, for: .normal)
        //Set the player view to play video
        let videoURL = URL(string: videoDetail?.video_files?[0].link ?? "")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = playerView.bounds
        playerView.layer.addSublayer(playerLayer)
        player.play()

    }

}
