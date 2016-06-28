//
//  ECService.h
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECService : NSObject

+ (instancetype) sharedInstance;

/**
 *  Fetches the list of pets
 *
 *  @param completionHandler Called either on completion pet list fetch or if service call has failed.
 *                           @param petDataArray Array of Pets.
 *                           @param error The service error.
 */
- (void)getPetDataArrayWithCompletionHandler:(void (^)(NSMutableArray *petDataArray, NSError *error))completionHandler;

/**
 *  Updates the pet data
 *
 *  @param bucketId          
 *
 *  @param completionHandler Called either on completion pet list fetch or if service call has failed.
 *                           @param petDataArray Array of Pets.
 *                           @param error The service error.
 */
- (void)updatePetData:(NSDictionary*)newPetData
    completionHandler:(void(^)(NSError *error))completionHandler;


@end
