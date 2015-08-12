//
//  PeopleController.h
//  6WeekChallenge
//
//  Created by Robert Shepperd on 8/12/15.
//  Copyright (c) 2015 Robert Shepperd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Partner.h"
@interface PartnerController : NSObject

@property (strong, nonatomic, readonly) NSArray *partnerList;

+ (PartnerController *)sharedInstance;

- (void)addPartner:(Partner *)partner;
- (void)removePartner:(Partner *)partner;



//- (void)randomizePartners:(Partner *)partner;




@end
