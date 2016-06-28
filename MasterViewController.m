//
//  MasterViewController.m
//  Pets
//
//  Created by Debaprio Banik on 4/25/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PetData.h"
#import "ECService.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface MasterViewController ()

@property (strong) ECService *serviceContext;
@property (strong) NSMutableArray *petList;
@property (strong) UIBarButtonItem *refreshBtn;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                    target:self
                                                                    action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = self.refreshBtn;
    
    self.serviceContext = [ECService sharedInstance];
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.petList = nil;
        [self.tableView reloadData];
    });
}

#pragma mark - Service Calls

- (void)refresh
{
    self.refreshBtn.enabled = NO;
    self.tableView.userInteractionEnabled = NO;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color = [UIColor blackColor];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.3);
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    [self.serviceContext getPetDataArrayWithCompletionHandler:^(NSMutableArray *petDataArray, NSError *error) {
        NSMutableArray *pets = [NSMutableArray array];
        if (!error)
        {
            for (NSDictionary *petDict in petDataArray)
            {
                PetData *pet = [[PetData alloc] initWithID:petDict[@"ID"]];
                pet.price = petDict[@"price"];
                pet.name = petDict[@"name"];
                pet.contactNum = petDict[@"contactNum"];
                [pets addObject:pet];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.petList = pets;
            self.refreshBtn.enabled = YES;
            self.tableView.userInteractionEnabled = YES;
            [self.tableView reloadData];
            [spinner removeFromSuperview];
        });
    }];
}

- (void)update
{
    self.refreshBtn.enabled = NO;
    self.tableView.userInteractionEnabled = NO;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color = [UIColor blackColor];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.3);
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    NSMutableDictionary *updateDict = [NSMutableDictionary dictionary];
    updateDict[@"ID"] = self.detailViewController.petDetail.petID;
    updateDict[@"name"] = self.detailViewController.petDetail.name;
    updateDict[@"price"] = self.detailViewController.petDetail.price;
    updateDict[@"contactNum"] = self.detailViewController.petDetail.contactNum;
    
    [self.serviceContext updatePetData:updateDict completionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                NSLog(@"Save failed");
            }
        
            self.refreshBtn.enabled = YES;
            self.tableView.userInteractionEnabled = YES;
            [self.tableView reloadData];
            [spinner removeFromSuperview];
        });
    }];
}

#pragma mark - Segues

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    if (YES == self.detailViewController.isModified)
    {
        [self update];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PetData *pet = self.petList[indexPath.row];
        self.detailViewController = (DetailViewController *)[[segue destinationViewController] topViewController];
        [self.detailViewController setPetDetail:pet];
        self.detailViewController.isModified = NO;
        self.detailViewController.navigationItem.leftBarButtonItem = 
        self.splitViewController.displayModeButtonItem;
        self.detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.petList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBasicCell" forIndexPath:indexPath];

    PetData *pet = self.petList[indexPath.row];
    cell.textLabel.text = pet.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [self.petList removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}

@end
