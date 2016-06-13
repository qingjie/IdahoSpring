//
//  InterstitialViewController.swift
//  IdahoSpring
//
//  Created by qingjiezhao on 6/13/16.
//  Copyright © 2016 dongyaocun. All rights reserved.
//

import UIKit
import GoogleMobileAds


class InterstitialViewController: UIViewController,GADBannerViewDelegate {

    var interstital:GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstital = GADInterstitial(adUnitID:"ca-app-pub-3372114682508787/4162226754")
        let request  = GADRequest()
        interstital.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func show(sender: AnyObject) {
        if (interstital.isReady) {
            interstital.presentFromRootViewController(self)
            interstital = createAd()
        }
    }
    
    func createAd() -> GADInterstitial{
        let interstital = GADInterstitial(adUnitID:"ca-app-pub-3372114682508787/4162226754")
        interstital.loadRequest(GADRequest())
        return interstital
    }

}
