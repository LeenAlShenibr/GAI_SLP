//
//  SliderViewController.h
//  DelegationDemo
//
//  Created by Leen on 7/30/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//



@protocol SliderViewControllerDelegate <NSObject>

-(void)changeBackgroundColor: (UIColor *) color;

@end

@interface SliderViewController : UIViewController


//Note the weak property (It prevents cycles)
@property (nonatomic, weak) id<SliderViewControllerDelegate> delegate;

@end
