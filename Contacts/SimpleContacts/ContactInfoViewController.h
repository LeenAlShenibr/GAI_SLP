//
//  ContactInfoViewController.h
//  SimpleContacts
//
//  Created by Leen on 7/24/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <UIKit/UIKit.h>

//Doing this because we shouldn't import the modal views header files (creats a cycle).
@class ContactEntity;

@interface ContactInfoViewController : UIViewController

@property (nonatomic, strong) ContactEntity *contact;

@end
