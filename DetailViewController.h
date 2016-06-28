//
//  DetailViewController.h
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetData.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) PetData *petDetail;
@property (assign) BOOL isModified;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;


- (IBAction)nameFieldEdited:(UITextField *)sender;
- (IBAction)priceEdited:(UITextField *)sender;
- (IBAction)contactNumberEdited:(UITextField *)sender;


@end

