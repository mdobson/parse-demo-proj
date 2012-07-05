//
//  CoreLocationDataSource.h
//  ParseStarterProject
//
//  Created by Matthew Dobson on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationDataSourceDelegate
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationDataSource : NSObject <CoreLocationDataSourceDelegate>{
    CLLocationManager *locMgr;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, retain) id delegate;
@end

