ViewController.swift

import UIKit
import GoogleMobileAds
 
class ViewController: UIViewController, GADBannerViewDelegate {
    
    var interstital: GADInterstitial!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        interstital = GADInterstitial(adUnitID: "ca-app-pub-7304033372417454/7933685840")
        
        let request = GADRequest()
        interstital.loadRequest(request)
    }
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func ShowAd(sender: AnyObject) {
        
        if (interstital.isReady) {
            
            interstital.presentFromRootViewController(self)
            interstital = CreateAd()
            
        }
    }
    
    
    func CreateAd() -> GADInterstitial {
        
        let interstital = GADInterstitial(adUnitID: "ca-app-pub-7304033372417454/7933685840")
        interstital.loadRequest(GADRequest())
        return interstital
        
    }
    
}