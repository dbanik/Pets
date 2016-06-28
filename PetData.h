//
//  PetData.h
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetData : NSObject

@property (strong) NSString *petID;
@property (strong) NSString *name;
@property (strong) NSNumber *price;
@property (strong) NSNumber *contactNum;

- (instancetype)initWithID:(NSString*)ID;

@end
