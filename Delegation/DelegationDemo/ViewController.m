//
//  ViewController.m
//  DelegationDemo
//
//  Created by Leen on 7/30/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "ViewController.h"
#import "SliderViewController.h"

@interface ViewController ()<SliderViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


//The delegate method
-(void)changeBackgroundColor:(UIColor *)color
{
    self.view.backgroundColor = color;

//    NSLog(@"Color is %@", color);
};


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"setColor"]) {
        
        //Get the SliderViewController
        SliderViewController *sliderController = [segue destinationViewController];
        
        //Set up the delegate
        sliderController.delegate = self;
        
    }
}


@end