//
//  CoreLocationDataSource.m
//  ParseStarterProject
//
//  Created by Matthew Dobson on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "CoreLocationDataSource.h"

@implementation CoreLocationDataSource

@synthesize locMgr, delegate;

- (id) init{
    self = [super init];
    
    if(self != nil) {
		self.locMgr = [[[CLLocationManager alloc] init] autorelease]; // Create new instance of locMgr
		self.locMgr.delegate = self; // Set the delegate as self.
	}
    
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if([self.delegate conformsToProtocol:@protocol(CoreLocationDataSourceDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self.delegate locationUpdate:newLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([self.delegate conformsToProtocol:@protocol(CoreLocationDataSourceDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self.delegate locationError:error];
	}
}

- (void)dealloc {
	[self.locMgr release];
	[super dealloc];
}

@end
