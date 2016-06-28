//
//  PetData.m
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import "PetData.h"

@implementation PetData

- (instancetype)initWithID:(NSString*)ID
{
    self = [super init];
    if (self)
    {
        self.petID = ID;
    }
    return self;
}

@end
