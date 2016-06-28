//
//  DetailViewController.m
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setPetDetail:(PetData *)petDetail
{
    if (_petDetail != petDetail)
    {
        _petDetail = petDetail;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.petDetail)
    {
        self.nameField.text = self.petDetail.name;
        self.priceField.text = [NSString stringWithFormat:@"$%@",self.petDetail.price];
        self.contactNumber.text = self.petDetail.contactNum.stringValue;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI Actions

- (IBAction)nameFieldEdited:(id)sender
{
    self.petDetail.name = self.nameField.text;
    self.isModified = YES;
}

- (IBAction)priceEdited:(UITextField *)sender
{
    NSCharacterSet *dollar = [NSCharacterSet characterSetWithCharactersInString:@"$"];
    NSString *priceStr = [self.priceField.text stringByTrimmingCharactersInSet:dollar];
    self.petDetail.price = [NSNumber numberWithInteger:priceStr.integerValue];
    self.priceField.text = [NSString stringWithFormat:@"$%@",self.petDetail.price];
    self.isModified = YES;
}

- (IBAction)contactNumberEdited:(UITextField *)sender
{
    self.petDetail.contactNum = [NSNumber numberWithInteger:self.contactNumber.text.integerValue];
    self.isModified = YES;
}
@end
