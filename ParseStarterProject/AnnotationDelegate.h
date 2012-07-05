//
//  AnnotationDelegate.h
//  ParseStarterProject
//
//  Created by Matthew Dobson on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationDelegate : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 

@end
