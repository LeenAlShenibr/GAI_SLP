//
//  CoordinatesViewController.m
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "CoordinatesViewController.h"
#import "MapViewController.h"
#import "GeoResultsTableViewController.h"

@interface CoordinatesViewController ()

@property (strong, nonatomic) NSMutableArray *placemarks;

@end

@implementation CoordinatesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Connect text fields delegates
    self.latitudeTextField.delegate = self;
    self.longitudeTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToLocation"]) {
        MapViewController *controller = (MapViewController *)segue.destinationViewController;
        
        
        controller.coordinate = self.location.coordinate;
        
        CLPlacemark *mark = [self.placemarks objectAtIndex:0];
        
        NSDictionary *addressDict = mark.addressDictionary;
        
        
        NSArray *keys = [[NSArray alloc] initWithObjects:@"Street", @
                         "City", @"State",@ "ZIP", nil];
        NSString *address;
        NSString *temp;
        
        for (NSString *key in keys) {
            
            temp = [addressDict objectForKey:key];
            
            if (temp){
                
                
                address = [NSString stringWithFormat:@" %@", temp];
            }
        }
        
        
        controller.address = address;
    }
    
    else if ([segue.identifier isEqualToString:@"CoordinateAddressInfo"])
    {
        
        GeoResultsTableViewController *controller = (GeoResultsTableViewController *)segue.destinationViewController;
        
        controller.address = YES;
        controller.results = self.placemarks;
        
        
    }
}


-(IBAction)getAddressForCoordinate:(id)sender
{
    
    
    self.placemarks = [[NSMutableArray alloc] init];
    
    self.location = [[CLLocation alloc] init];
    
    self.location = [[CLLocation alloc] initWithLatitude:[self.latitudeTextField.text floatValue] longitude:[self.longitudeTextField.text floatValue]];
    
    
    
    
    //Create the coder
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    
    [geocoder reverseGeocodeLocation:self.location completionHandler:
     ^(NSArray* placemarks, NSError* error){
         
         if ([placemarks count] > 0)
         {
             
             [self.placemarks addObject:[placemarks objectAtIndex:0]];
             
         }
         
         
         [self performSegueWithIdentifier:@"goToLocation" sender:self];
     }];
    
    
}

-(IBAction)getAddressListForCoordinate:(id)sender
{
    
    self.placemarks = [[NSMutableArray alloc] init];
    
    self.location = [[CLLocation alloc] init];
    
    self.location = [[CLLocation alloc] initWithLatitude:[self.latitudeTextField.text floatValue] longitude:[self.longitudeTextField.text floatValue]];
    
    
    
    //Create the coder
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    
    [geocoder reverseGeocodeLocation:self.location completionHandler:
     ^(NSArray* placemarks, NSError* error){
         
         if ([placemarks count] > 0)
         {
             
             [self.placemarks addObject:[placemarks objectAtIndex:0]];
             
         }
         
         
         [self performSegueWithIdentifier:@"CoordinateAddressInfo" sender:self];
     }];
    
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


//Keyboard methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
