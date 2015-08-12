//
//  PeopleController.m
//  6WeekChallenge
//
//  Created by Robert Shepperd on 8/12/15.
//  Copyright (c) 2015 Robert Shepperd. All rights reserved.
//

#import "PartnerController.h"
#import "Partner.h"

static NSString * const partnerListKey = @"partnerList";

@interface PartnerController ()

@property (nonatomic, strong) NSArray *partnerList;


@end

@implementation PartnerController


+ (PartnerController *)sharedInstance {
    static PartnerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance= [PartnerController new];
        
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadPersonListFromDisk];
    }
    return self;
}

-(void)addPartner:(Partner *)partner {
    if (!partner) {
        return;
        
    }
    NSMutableArray *mutablePartnerList = [[NSMutableArray alloc]initWithArray:self.partnerList];
    [mutablePartnerList addObject:partner];
    
    
}

-(void)removePartner:(Partner *)partner {
    if (!partner){
        return;
        
    }
    NSMutableArray *mutablePartnerList = [[NSMutableArray alloc]initWithArray:self.partnerList];
    [mutablePartnerList removeObject:partner];
    
}

//-(void)randomizePartners:(Partner *)partner {
//  
//    
//}

+ (NSURL *)saveFileURL {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *result = [[fm URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    result = [result URLByAppendingPathComponent:bundleID];
    
    if (![fm fileExistsAtPath:[result path]]) {
        [fm createDirectoryAtURL:result withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    result = [result URLByAppendingPathComponent:@"people"];
    return result;
}

- (void)save
{
    NSURL *fileURL = [[self class] saveFileURL];
    [NSKeyedArchiver archiveRootObject:self.partnerList toFile:[fileURL path]];
}

- (void)loadPersonListFromDisk
{
    NSURL *fileURL = [[self class] saveFileURL];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) { // File doesn't exist
        self.partnerList = [[NSArray alloc] init];
        return;
    }
    
    self.partnerList = [[NSKeyedUnarchiver unarchiveObjectWithFile:[fileURL path]] mutableCopy];
    
}




@end
