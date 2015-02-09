//
//  MapViewController.h
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *address;


@end
