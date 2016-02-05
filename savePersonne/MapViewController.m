//
//  MapViewController.m
//  savePersonne
//
//  Created by xavier on 05/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation MapViewController

CLGeocoder *geocoder;
CLPlacemark *placemark;


int i =0;
int j =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
    
    
    self.mapView.delegate = self;
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeHybrid;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *loc = locations.lastObject;
    CLLocationDegrees latitude = loc.coordinate.latitude;
    CLLocationDegrees longitude = loc.coordinate.longitude;
    
    self.longitude.text = [NSString stringWithFormat:@"%.6f", longitude];
    self.latitude.text = [NSString stringWithFormat:@"%.6f", latitude];
    if(j == 0){
        //focus on location
        MKCoordinateRegion region;
        region.center = loc.coordinate;
    
        //zoom
        MKCoordinateSpan span;
        span.latitudeDelta = 0.015;
        span.longitudeDelta = 0.015;
        region.span = span;
    
        [self.mapView setRegion:region animated:YES];
        j++;
    }
    //reverse geocoding
    if(!geocoder){
        geocoder = [[CLGeocoder alloc]init];
    }
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray * placemarks, NSError * error){
        NSLog(@"found placemarks: %@, error: %@", placemarks, error);
        if(error == nil && [placemarks count]>0){
            placemark = [placemarks lastObject];
            self.adresse.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        }else{
            NSLog(@"%@", error.debugDescription);
        }
    }];
    
    
    
   if(self.locationManager.location!=nil && i==0){
        
        // creer la punaise
        CLLocationCoordinate2D coordinate =self.locationManager.location.coordinate;
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.title =@"title";
        annotation.coordinate = coordinate;
        [self.mapView addAnnotation:annotation];
        
        // zoom sur la punaise
        MKMapPoint annotationPoint = MKMapPointForCoordinate(coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        [self.mapView setVisibleMapRect:pointRect animated:YES];
        i++;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinView =nil;
    if([annotation isKindOfClass:[MKPointAnnotation class]]){
        // try to dequeue an existing pin view first.
        pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if(!pinView){
            //if an existing pin view was not available, create one
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //add detail
            UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
            pinView.animatesDrop = YES;
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.canShowCallout = YES;
        }else{
            pinView.annotation = annotation;
        }
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    id<MKAnnotation> annotation = [view annotation];
    if([annotation isKindOfClass:[MKPointAnnotation class]]){
        NSLog(@"Clicked");
    }
    [self performSegueWithIdentifier:@"showMapDetail" sender:self];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
