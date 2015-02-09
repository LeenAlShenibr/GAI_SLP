//
//  CoordinatesViewController.h
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CoordinatesViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;

@property (nonatomic) CLLocation *location;

@end
