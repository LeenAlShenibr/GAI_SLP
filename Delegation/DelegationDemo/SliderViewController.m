//
//  SliderViewController.m
//  DelegationDemo
//
//  Created by Leen on 7/30/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()

@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;
@property (strong, nonatomic) IBOutlet UISlider *blueSlider;

@end


@implementation SliderViewController

@synthesize redSlider, greenSlider, blueSlider, delegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    redSlider.minimumValue = 0;
    redSlider.maximumValue = 255;
    
    greenSlider.minimumValue = 0;
    greenSlider.maximumValue = 255;
    
    blueSlider.minimumValue = 0;
    blueSlider.maximumValue = 255;
    
    
}



- (IBAction)donePressed:(id)sender {
    
    UIColor *rgb = [UIColor colorWithRed:(redSlider.value/255.0) green:(greenSlider.value/255.0) blue: (blueSlider.value/255.0) alpha:1];
    
    NSLog(@"Red: %f, Green: %f, Blue: %f", redSlider.value, greenSlider.value, blueSlider.value);
    
    [self.delegate changeBackgroundColor:rgb];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
