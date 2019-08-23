//
//  BackgroundGeolocationFirebase.h
//  BackgroundGeolocationFirebase
//
//  Created by Christopher Scott on 2018-08-23
//  Copyright © 2019 Christopher Scott, Transistor Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundGeolocationFirebase : NSObject

#pragma mark - Singleton
+ (BackgroundGeolocationFirebase *)sharedInstance;

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* locationsCollection;
@property (nonatomic) NSString* geofencesCollection;
@property (nonatomic) BOOL updateSingleDocument;
@end


