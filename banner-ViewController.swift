ViewController.swift

import UIKit
import GoogleMobileAds
 
class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet var banner: GADBannerView!    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        banner.hidden = true
        
        banner.delegate = self
        
        banner.adUnitID = "ca-app-pub-7304033372417454/9689620645"
        banner.rootViewController = self
        banner.loadRequest(GADRequest())
    }
 
 



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    func adViewDidReceiveAd(bannerView: GADBannerView!) {
        banner.hidden = false
    }
    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        banner.hidden = true
    }
}