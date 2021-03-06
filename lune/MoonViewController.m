//
//  MoonViewController.m
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import "MoonViewController.h"
#import "CMCelestialObject.h"
#import "CMMoon.h"
#import <CoreMotion/CoreMotion.h>


@interface MoonViewController ()

@end

@implementation MoonViewController {
    float _phase;
    NSDate *now;
    
    CLLocationManager *locationManager;

    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocationDirection currentHeading;
    
    float moonAzimuth, moonElevation;
    CMMotionManager *motionManager;
    



}

- (IBAction)clickMoonPhase:(id)sender {
    now = [now dateByAddingTimeInterval:60*60*24*1];
    [self updateMoonPhase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager requestWhenInUseAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
    }
    [locationManager startUpdatingLocation];
    
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                    }];
    
    
    [_imgUp setHidden:YES];
    [_imgDown setHidden:YES];
    [_imgLeft setHidden:YES];
    [_imgRight setHidden:YES];
    
    [_lblMoon setHidden:YES];
    
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    NSLog(@"acceleration: %f %f %f", acceleration.x, acceleration.y, acceleration.z);
    
    float angle = acceleration.z * 180.0;
    
    if ( angle > moonElevation ) {
        [_imgDown setHidden:NO];
        [_imgUp setHidden:YES];
    } else {
        [_imgDown setHidden:YES];
        [_imgUp setHidden:NO];
    }

    
}
-(void)outputRotationData:(CMRotationRate)rotation
{
    //NSLog(@"rotation: %f %f %f", rotation.x, rotation.y, rotation.z);
}

- (void) updateMoonPhase {
    _phase = [self phase];
    NSLog(@"Phase: %f", _phase);
    // So zero is new, 0.5 is full, 0.75 is 3rd q
    
    // TODO: need to figure out the phases, the images we have, and map them
    // also since we're inverting the image... the images don't represent the phase well
    if ( _phase >= 0.4 && _phase < 0.6 ) {
        _btnPhase.imageView.image = [UIImage imageNamed:@"icon-moon-waning-gibbous.png"];
        
    } else if ( _phase >= 0.6) {
        _btnPhase.imageView.image = [UIImage imageNamed:@"icon-moon-waning-gibbous.png"];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    now = [NSDate date];
    // can go forward
    //now = [now dateByAddingTimeInterval:60*60*24*6];
    [self updateMoonPhase];
    
     NSMutableArray *images = [[NSMutableArray alloc] init];
    
    [images addObject:[UIImage imageNamed:@"icon-dish-0"]];
    [images addObject:[UIImage imageNamed:@"icon-dish-1"]];
    [images addObject:[UIImage imageNamed:@"icon-dish-2"]];
    [images addObject:[UIImage imageNamed:@"icon-dish-1"]];
    
    _imgDish.animationImages = images;
    _imgDish.animationDuration = 2.0;
    [_imgDish startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/////// Moon location code

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    currentHeading = theHeading;
    NSLog(@"Heading: %f", theHeading);
    
    [_lblMoon setHidden:NO];

    if ( theHeading > moonAzimuth ) {
        [_imgLeft setHidden:NO];
        [_imgRight setHidden:YES];
    } else {
        [_imgLeft setHidden:YES];
        [_imgRight setHidden:NO];
    }
}


- (void) findMoonPosition: (CLLocationCoordinate2D)location {
    NSDate *rightNow = [NSDate date];
    
    CMMoon *moon = [[CMMoon alloc] init];
    
    // Azimith: 0 due north, 90 due east
    float azimuth = [moon azimuthAngleAtDate:rightNow inLocation:location];
    // Elevation: 0 horizon
    float elevation = [moon elevationAtDate:rightNow inLocation:location];
    
    // distance in AU
    float distance = [moon geocentricDistanceAtDate:rightNow];
    
    NSLog(@"Moon azimuth: %f, elevation: %f", azimuth, elevation);
    NSLog(@"Moon azimuth: %f deg, elevation: %f deg", azimuth * 180.0 / M_PI, elevation * 180.0 / M_PI);
    NSLog(@"Moon distance: %f AU, %f million miles", distance, distance * 92.956);
    
    _lblMoonData.text = [NSString stringWithFormat:@"Phase: %.4f Az: %.2f\u00B0 El: %.2f\u00B0 D: %.0f km", _phase, azimuth * 180.0 / M_PI, elevation * 180.0 / M_PI, distance * 149600000 ];
    
    [_imgDish stopAnimating];
    [_imgDish setHidden:YES];
    [_lblLocating setHidden:YES];
    [_lblMoon setHidden:NO];

    
    moonAzimuth = azimuth * 180.0 / M_PI;
    moonElevation = elevation * 180.0 / M_PI;
}


/////// Location code


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil&& [placemarks count] >0) {
            placemark = [placemarks lastObject];
            
            NSString *latitude, *longitude, *state, *country;
            
            latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            state = placemark.administrativeArea;
            country = placemark.country;

            NSLog(@"Location: %@, %@, %@, %@", latitude, longitude, state, country);
            
            [self findMoonPosition:newLocation.coordinate];
            

        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location: %@", error);
}


/////// Moon Phase Code



float fixangle( float angle ){
    return angle - 360.0f * ( floor ( angle / 360.0f ) );
}

float torad( float deg ){
    return deg * ( M_PI / 180.0f );
}

float todeg( float rad ){
    return rad * ( 180.0f / M_PI );
}

float dsin( float deg ){
    return sin( torad( deg ) );
}

double jtime( double t ){
    return (t / 86400.0f) + 2440587.5f;
}

float kepler( float m, float ecc ){
    float EPSILON = 0.000001f;
    m = torad(m);
    float e = m;
    float delta;
    
    // first time
    delta = e - ecc * sin(e) - m;
    e -= delta / ( 1.0f - ecc * cos(e) );
    
    // loop
    while( abs(delta) > EPSILON ){
        delta = e - ecc * sin(e) - m;
        e -= delta / ( 1.0f - ecc * cos(e) );
    }
    
    return e;
}

- (float) phase {
    // const
    double Epoch = 2444238.5;
    float Elonge = 278.833540;
    float Elongp = 282.596403;
    float Eccent = 0.016718;
    float Mmlong = 64.975464;
    float Mmlongp = 349.383063;
    float Mlnode = 151.950429;
    float Minc = 5.145396;
    
    NSTimeInterval d = [now timeIntervalSince1970];
    
    double pdate = jtime( (float)d );
    double Day = pdate - Epoch;
    
    double N = fixangle( ( 360.0f / 365.2422f ) * Day );
    double M = fixangle( N + Elonge - Elongp );
    double Ec = kepler( M, Eccent );
    Ec = sqrt( ( 1.0f + Eccent ) / ( 1.0f - Eccent ) ) * tan( Ec / 2.0f );
    Ec = 2.0f * todeg( atan( Ec ) );
    double Lambdasun = fixangle( Ec + Elongp );
    
    double ml = fixangle( 13.1763966f * Day + Mmlong );
    double MM = fixangle( ml - 0.1114041f * Day - Mmlongp );
    double MN = fixangle( Mlnode - 0.0529539f * Day );
    double Ev = 1.2739f * sin( torad( 2.0f * ( ml - Lambdasun ) - MM ) );
    double Ae = 0.1858f * sin( torad( M ) );
    double A3 = 0.37f * sin( torad( M ) );
    double MmP = MM + Ev - Ae - A3;
    double mEc = 6.2886f * sin( torad( MmP ) );
    double A4 = 0.214f * sin( torad( 2.0f * MmP ) );
    double lP = ml + Ev + mEc - Ae + A4;
    double V = 0.6583f * sin( torad( 2.0f * ( lP - Lambdasun ) ) );
    double lPP = lP + V;
    double NP = MN - 0.16f * sin( torad( M ) );
    double y = sin( torad( lPP - NP ) ) * cos( torad( Minc ) );
    double x = cos( torad( lPP - NP ) );
    double Lambdamoon = todeg( atan2( y, x ) );
    Lambdamoon += NP;
    
    double MoonAge = lPP - Lambdasun;
    float mpfrac = fixangle( MoonAge ) / 360.0f;
    
    return mpfrac;
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
