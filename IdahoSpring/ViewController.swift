//
//  ViewController.swift
//  IdahoSpring
//
//  Created by qingjiezhao on 6/12/16.
//  Copyright © 2016 dongyaocun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCrash
import FirebaseStorage
import FirebaseDatabase
import GoogleMobileAds


class ViewController: UIViewController,GADBannerViewDelegate {

    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.hidden = true
        bannerView.delegate = self
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-3372114682508787/2781395156"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adViewDidReceiveAd(bannerView: GADBannerView!) {
        bannerView.hidden = false
    }
    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        bannerView.hidden = true
    }

    

}

