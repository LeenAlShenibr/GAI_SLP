//
//  AddressViewController.m
//  mapKitDemo
//
//  Created by Leen on 6/20/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "AddressViewController.h"
#import "MapViewController.h"
#import "GeoResultsTableViewController.h"

@interface AddressViewController ()

@property (strong, nonatomic) NSMutableArray *placemarks;

@end

@implementation AddressViewController

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
    
    //Connect text fields delgates
    self.addressTextField.delegate = self;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToMapAddress"]) {
        MapViewController *controller = (MapViewController *)segue.destinationViewController;
        
        //Create coordinates
        
        CLLocationCoordinate2D coordinate = [self getTopCoordinate];
        controller.coordinate = coordinate;
        controller.address = self.addressTextField.text;
    }
    
    else if ([segue.identifier isEqualToString:@"AddressCoordinateInfo"])
    {
        
        
        
        GeoResultsTableViewController *controller = (GeoResultsTableViewController *)segue.destinationViewController;
        
        controller.address = NO;
        controller.results = self.placemarks;
        
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CLLocationCoordinate2D) getTopCoordinate
{
    
    
    
    CLLocationCoordinate2D addressCoordinates;
    if([self.placemarks count] > 0)
    {
        
        
        CLPlacemark *firstPlacemark = [self.placemarks objectAtIndex:0];
        
        addressCoordinates.latitude = firstPlacemark.location.coordinate.latitude;
        addressCoordinates.longitude = firstPlacemark.location.coordinate.longitude;
        
    }
    
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Address Not Found!" message:@"Please enter a valid address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
    
    return addressCoordinates;
}


-(IBAction)getCoordinatesForAddress:(id)sender
{
    
    
    NSString *address = self.addressTextField.text;
    self.placemarks = [[NSMutableArray alloc] init];
    
    //Create the coder
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder geocodeAddressString: address completionHandler:^(NSArray* placemarks, NSError* error){
        
        //All the results are contained in placemarks
        
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            
            [self.placemarks addObject:aPlacemark];
            
            
        }
        
        
        [self performSegueWithIdentifier:@"goToMapAddress" sender:self];
        
        
    }];
    
    
}

-(IBAction)getCoordinatesListForAddress:(id)sender
{
    
    
    NSString *address = self.addressTextField.text;
    self.placemarks = [[NSMutableArray alloc] init];
    
    //Create the coder
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder geocodeAddressString: address completionHandler:^(NSArray* placemarks, NSError* error){
        
        //All the results are contained in placemarks
        
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            
            [self.placemarks addObject:aPlacemark];
            
            
        }
        
        
        [self performSegueWithIdentifier:
         @"AddressCoordinateInfo" sender:self];
        
        
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
