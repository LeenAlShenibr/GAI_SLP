//
//  GeoResultsTableViewController.m
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "GeoResultsTableViewController.h"

@interface GeoResultsTableViewController ()

@property (strong, nonatomic) NSMutableArray *processedInfo;

@end

@implementation GeoResultsTableViewController

@synthesize results = _results;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.address)
    {
        [self processAddress];
        
    }
    
    else
    {
        [self processCoordinates];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"result";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.processedInfo objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}


-(void)processAddress
{
    self.processedInfo = [[NSMutableArray alloc] init];
    
    for (CLPlacemark *mark in self.results) {
        
        
        NSDictionary *addressDict = mark.addressDictionary;
        
        
        NSArray *keys = [[NSArray alloc] initWithObjects:@"Street", @"City", @"State",@"ZIP", nil];
        NSString *address;
        NSString *temp;
        
        for (NSString *key in keys) {
            
            if ([addressDict objectForKey:key]){
                temp = [addressDict objectForKey:key];
                
                
                address = [NSString stringWithFormat:@" %@", temp];
            }
            
        }
        
        [self.processedInfo addObject: address];
        
        
    }
    
}

-(void)processCoordinates
{
    self.processedInfo = [[NSMutableArray alloc] init];
    
    for (CLPlacemark *mark in self.results) {
        
        NSString *temp = [NSString stringWithFormat:@"Latitude: %f, Longitude: %f",
                          mark.location.coordinate.latitude,
                          mark.location.coordinate.longitude];
        
        
        
        [self.processedInfo addObject: temp];
        
        
        
    }
    
    
}

@end
