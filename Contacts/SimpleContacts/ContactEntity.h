//
//  ContactEntity.h
//  SimpleContacts
//
//  Created by Leen on 7/24/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ContactEntity : NSManagedObject


//Properties defined in our model
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *nameFirstLetter;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
//For simplicity we made the phoneNumber a string.
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, retain) NSData * image;

@end
