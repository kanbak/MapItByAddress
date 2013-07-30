//
//  ViewController.m
//  MapIt
//
//  Created by Umut Kanbak on 7/29/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CLLocationManager *locationManager;
    MKMapView *mapView;
    __weak IBOutlet MKMapView *mapViewOutlet;
    MKCoordinateRegion myRegion;
    __weak IBOutlet UITextField *latitudeTextField;
    float latitudeTextFieldInput;
    float longitudeTextFieldInput;
    NSString *searchItem;
    NSURL *url;
    NSString *urlValue;
    NSArray *googleMapsArray;
    NSDictionary *googleMapsDictionary;
    NSDictionary *googleMapsDictionary2;
    NSDictionary *googleMapsDictionary3;
    NSDictionary *googleMapsDictionary4;
    NSDictionary *googleMapsDictionary5;
    NSString *latString;
    NSString *lngString;
    float latStringFloat;
    float lngStringFloat;

    
}
- (IBAction)goToAddress:(id)sender;


@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate =self;

    myRegion.center= CLLocationCoordinate2DMake(41.893740, -87.635330);
    myRegion.span.latitudeDelta=0.02;
    myRegion.span.longitudeDelta=0.02;
    [mapViewOutlet setRegion:myRegion animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location = %@",[locations objectAtIndex:0]);
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"eror %@",error);
}



- (IBAction)goToAddress:(id)sender {
    searchItem=latitudeTextField.text;
    NSString *newString=[searchItem stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    urlValue=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",newString];
    NSURL *myUrl = [[NSURL  alloc]initWithString:urlValue];
    NSURLRequest *request = [NSURLRequest requestWithURL:myUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
        completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         googleMapsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         googleMapsArray=[googleMapsDictionary objectForKey:@"results"];
       //  NSLog(@"layer 1 %@",googleMapsDictionary);
       //  NSLog(@"layer 2 %@",googleMapsArray);
         googleMapsDictionary2=[googleMapsArray objectAtIndex:0];
       //  NSLog(@"layer 1 %@",googleMapsDictionary2);
         googleMapsDictionary3=[googleMapsDictionary2 objectForKey:@"geometry"];
         googleMapsDictionary4=[googleMapsDictionary3 objectForKey:@"location"];
         latString=[googleMapsDictionary4 objectForKey:@"lat"];
         lngString=[googleMapsDictionary4 objectForKey:@"lng"];
         latStringFloat=latString.floatValue;
         lngStringFloat=lngString.floatValue;
         myRegion.center= CLLocationCoordinate2DMake(latStringFloat, lngStringFloat);
         myRegion.span.latitudeDelta=0.03;
         myRegion.span.longitudeDelta=0.03;
         [mapViewOutlet setRegion:myRegion animated:YES];
         NSLog(@"Latitude %f Longitude %f", latStringFloat, lngStringFloat);
         [latitudeTextField resignFirstResponder];
         
     }];
   
    
}

@end
