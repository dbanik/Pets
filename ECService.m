//
//  ECService.m
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import "ECService.h"

@interface ECService ()

@property (strong) NSMutableArray *petDataArray;
@property (strong) dispatch_queue_t queue;

@end

@implementation ECService

+(instancetype) sharedInstance
{
    static ECService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ECService alloc] init];
        _sharedInstance.queue = dispatch_queue_create("com.ebay.serviceQueue", DISPATCH_QUEUE_SERIAL);
        _sharedInstance.petDataArray = [NSMutableArray array];
    });
    
    return _sharedInstance;
}

- (void)getPetDataArrayWithCompletionHandler:(void (^)(NSMutableArray *petDataArray, NSError *error))completionHandler
{
    dispatch_async([ECService sharedInstance].queue, ^{
        
        sleep(3);   //Mocking DB lookup.
        
        if ([ECService sharedInstance].petDataArray.count == 0)
        {
            for (NSUInteger i=1; i<=250; i++)
            {
                NSMutableDictionary *pet = [NSMutableDictionary dictionary];
                pet[@"ID"] = [NSString stringWithFormat:@"%ld", i];
                if (i%2 == 0)
                {
                    pet[@"name"] = @"Maltese Puppy";
                    pet[@"price"] = @1200;
                    pet[@"contactNum"] = @6693451010;
                }
                else if (i%3 == 0)
                {
                    pet[@"name"] = @"English Bulldog";
                    pet[@"price"] = @550;
                    pet[@"contactNum"] = @6695551010;
                }
                else if (i%5 == 0)
                {
                    pet[@"name"] = @"Adorable Yorkie Puppy";
                    pet[@"price"] = @800;
                    pet[@"contactNum"] = @6693499909;
                }
                else if (i%11 == 0)
                {
                    pet[@"name"] = @"French Bulldog";
                    pet[@"price"] = @525;
                    pet[@"contactNum"] = @2463451010;
                }
                else
                {
                    pet[@"name"] = @"Pit Bull";
                    pet[@"price"] = @600;
                    pet[@"contactNum"] = @2469951010;
                }
                [[ECService sharedInstance].petDataArray addObject:pet];
            }
        }
        
        completionHandler([ECService sharedInstance].petDataArray, nil);
    });
}

- (void)updatePetData:(NSDictionary*)newPetData
    completionHandler:(void(^)(NSError *error))completionHandler
{
    dispatch_async([ECService sharedInstance].queue, ^{
        
        sleep(2);      //Mocking DB update.
        NSString *petIDToUpdate = newPetData[@"ID"];
        if ([ECService sharedInstance].petDataArray.count >= petIDToUpdate.integerValue)
        {
            [[ECService sharedInstance].petDataArray replaceObjectAtIndex:petIDToUpdate.integerValue-1
                                                               withObject:newPetData];
            completionHandler(nil);
        }
        else
        {
            completionHandler([NSError new]);
        }
    });
}


@end
