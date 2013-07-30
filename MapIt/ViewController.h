//
//  ViewController.h
//  MapIt
//
//  Created by Umut Kanbak on 7/29/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKAnnotation>

@end
