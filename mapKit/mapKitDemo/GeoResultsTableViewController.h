//
//  GeoResultsTableViewController.h
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface GeoResultsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *results;

@property BOOL address;


@end
