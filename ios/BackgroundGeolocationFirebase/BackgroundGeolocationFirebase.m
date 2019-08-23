//
//  BackgroundGeolocationFirebase.m
//  BackgroundGeolocationFirebase
//
//  Created by Christopher Scott on 2019-08-23.
//  Copyright © 2019 Christopher Scott. All rights reserved.
//

#import "BackgroundGeolocationFirebase.h"
#import "Firebase.h"

static NSString *const PERSIST_EVENT                = @"TSLocationManager:PersistEvent";
static NSString *const NAME                         = @"firebaseproxy";

static NSString *const FIELD_LOCATIONS_COLLECTION = @"locationsCollection";
static NSString *const FIELD_GEOFENCES_COLLECTION = @"geofencesCollection";
static NSString *const FIELD_UPDATE_SINGLE_DOCUMENT = @"updateSingleDocument";

static NSString *const DEFAULT_LOCATIONS_COLLECTION = @"locations";
static NSString *const DEFAULT_GEOFENCES_COLLECTION = @"geofences";

@implementation BackgroundGeolocationFirebase {
    BOOL isRegistered;
}

+ (BackgroundGeolocationFirebase *)sharedInstance
{
    static BackgroundGeolocationFirebase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        _name = NAME;
        _locationsCollection = DEFAULT_LOCATIONS_COLLECTION;
        _geofencesCollection = DEFAULT_GEOFENCES_COLLECTION;
        _updateSingleDocument = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onPersist:)
                                                     name:PERSIST_EVENT
                                                   object:nil];
    }
    return self;
}


-(void) onPersist:(NSNotification*)notification {
    NSLog(@"************ BackgroundGeolocationFirebase onPersist");
    
    NSDictionary *data = notification.object;
    NSString *collectionName = (data[@"location"][@"geofence"]) ? _geofencesCollection : _locationsCollection;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        FIRFirestore *db = [FIRFirestore firestore];
        // Add a new document with a generated ID
        if (!self.updateSingleDocument) {
            __block FIRDocumentReference *ref = [[db collectionWithPath:collectionName] addDocumentWithData:notification.object completion:^(NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error adding document: %@", error);
                } else {
                    NSLog(@"Document added with ID: %@", ref.documentID);
                }
            }];
        } else {
            [[db documentWithPath:collectionName] setData:notification.object completion:^(NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error writing document: %@", error);
                } else {
                    NSLog(@"Document successfully written");
                }
            }];
        }
    });
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

