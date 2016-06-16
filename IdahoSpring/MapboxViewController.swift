//
//  MapboxViewController.swift
//  IdahoSpring
//
//  Created by qingjiezhao on 6/15/16.
//  Copyright © 2016 dongyaocun. All rights reserved.
//

import UIKit
import Mapbox
import Firebase
import FirebaseDatabase


class MapboxViewController: UIViewController, MGLMapViewDelegate {
    
    let rootRef = FIRDatabase.database().reference()
    
    
    @IBOutlet var mapView: MGLMapView!
    @IBOutlet var progressView: UIProgressView!
    var offlinePacks = [MGLOfflinePack]()
    
    static let IDAHO_REGION = MGLCoordinateBounds(
        sw: CLLocationCoordinate2D(latitude: 42.0, longitude: -117.05),
        ne: CLLocationCoordinate2D(latitude: 49.0, longitude: -111.04668))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(offlinePackProgressDidChange), name: MGLOfflinePackProgressChangedNotification, object: nil)
        
        mapView.setVisibleCoordinateBounds(MapboxViewController.IDAHO_REGION, animated: false)
        
        
        
        retieveDataFromFirebase()
        
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 43.6036,longitude: -116.208710)
        point.title = "Boise State University"
        point.subtitle = "Idaho, USA"
        mapView.addAnnotation(point)
        
    }
    
    
    
    
    func startOfflineDownloading() {
        let idahoRegion = MGLTilePyramidOfflineRegion(styleURL: mapView.styleURL,
                                                      bounds: MapboxViewController.IDAHO_REGION,
                                                      fromZoomLevel: 0, toZoomLevel: 10)
        let userInfo = ["name": "Idaho"]
        let context = try! NSJSONSerialization.dataWithJSONObject(userInfo, options: NSJSONWritingOptions(rawValue: 0))
        
        MGLOfflineStorage.sharedOfflineStorage().addPackForRegion(idahoRegion, withContext: context) { (pack, err) in
            guard err == nil else {
                print("Error: \(err?.localizedDescription)")
                return
            }
            
            guard let idahoPack = pack else {
                print("Error: Pack is nil!")
                return
            }
            
            idahoPack.resume()
            self.progressView.progress = self.progressFor(idahoPack).percent
            self.progressView.hidden = false
            self.offlinePacks.append(idahoPack)
        }
    }
    
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(mapView: MGLMapView) {
        if let idahoPack = MGLOfflineStorage.sharedOfflineStorage().packs?.first {
            if idahoPack.state != .Complete {
                idahoPack.resume()
            }
        }
        else {
            startOfflineDownloading()
        }
    }
    
    func offlinePackProgressDidChange(notification: NSNotification) {
        guard let pack = notification.object as? MGLOfflinePack else {
            return
        }
        
        let progress = progressFor(pack)
        
        progressView.progress = progress.percent
        
        if progress.complete {
            progressView.hidden = true
        }
    }
    
    // MARK: private
    
    private func progressFor(pack: MGLOfflinePack) -> (percent: Float, complete: Bool) {
        let progress = pack.progress
        let completeResources = progress.countOfResourcesCompleted
        let expectedResources = progress.countOfResourcesExpected
        
        return (
            percent: Float(completeResources) / Float(expectedResources),
            complete: completeResources == expectedResources
        )
    }
    
    func mapView(mapView:MGLMapView,annotationCanShowCallout annotation:MGLAnnotation) -> Bool{
        return true
    }
    
    func retieveDataFromFirebase(){
       /*
        rootRef.child("Thermal Spring/0/location/coordinates/0").observeEventType(.Value) { (snap:FIRDataSnapshot) in
            
            print(snap.value?.description)
        }
         */
        rootRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                print(item.key)
            }
        })
        
    }
    
    
    
    
}
