// Copyright 2011 Ping Labs, Inc. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "CoreLocationDataSource.h"

@interface ParseStarterProjectViewController : UIViewController <CoreLocationDataSourceDelegate> {
    CoreLocationDataSource *CLDataSource;
    IBOutlet UILabel *label;
    IBOutlet UIButton *getLocButton;
    IBOutlet MKMapView *map;
    IBOutlet UITextField *issueDesc;
    double lat;
    double lon;
    CLLocation *loc;
}

- (IBAction)saveLocation:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) IBOutlet UITextField *issueDesc;
@property (nonatomic, retain) CoreLocationDataSource *CLDataSource;
@property double lat;
@property double lon;
@property (nonatomic, retain) CLLocation *loc;

@end
