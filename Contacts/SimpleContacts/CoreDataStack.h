//
//  CoreDataStack.h
//  Diary
//
//  Created by Leen on 7/13/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype) defaultStack;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
