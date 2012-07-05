// Copyright 2011 Ping Labs, Inc. All rights reserved.

#import "ParseStarterProjectViewController.h"
#import "AnnotationDelegate.h"


@implementation ParseStarterProjectViewController
@synthesize CLDataSource, lat, lon, map, loc, issueDesc;
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {  
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 42.3314;
    zoomLocation.longitude= -83.0458;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*400000, 0.5*400000);
    // 3
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];                
    // 4
    [self.map setRegion:adjustedRegion animated:YES];      
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //[testObject setObject:@"bar" forKey:@"foo"];
    //[testObject save];
    
    
    
    CLDataSource = [[CoreLocationDataSource alloc] init];
	CLDataSource.delegate = self;
	[CLDataSource.locMgr startUpdatingLocation];
    
    PFQuery *query = [[[PFQuery alloc] initWithClassName:@"Issue"] autorelease];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            for( PFObject *obj in objects)
            {
                PFGeoPoint *point = [obj objectForKey:@"loc"];
                NSString *issue = [obj objectForKey:@"issue"];
                AnnotationDelegate *delegate = [[AnnotationDelegate alloc] init];
                delegate.title = @"Issue";
                CLLocation *location = [[CLLocation alloc] initWithLatitude:point.latitude longitude:point.longitude];
                delegate.subtitle = issue;
                [delegate setCoordinate:location.coordinate];
                [self.map addAnnotation:delegate];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    [super viewDidLoad];
}

- (IBAction)saveLocation:(id)sender
{
    NSLog(@"Clicked.");
    AnnotationDelegate *delegate = [[AnnotationDelegate alloc] init];
    [delegate setCoordinate:self.loc.coordinate];
    delegate.title = @"Issue";
    delegate.subtitle = issueDesc.text;
    
    [self.map addAnnotation:delegate];
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:self.loc.coordinate.latitude longitude:self.loc.coordinate.longitude];
    PFObject *testObject = [PFObject objectWithClassName:@"Issue"];
    [testObject setObject:point forKey:@"loc"];
    [testObject setObject:issueDesc.text forKey:@"issue"];
    [testObject save];

}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

- (void)locationUpdate:(CLLocation *)location
{
    label.text = [location description];
    self.loc = location;
    self.lat = location.coordinate.latitude;
    self.lon = location.coordinate.longitude;
}
    
- (void)locationError:(NSError *)error
{
    label.text = [error description];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
