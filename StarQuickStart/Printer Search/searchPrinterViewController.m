//
//  searchPrinterViewController.m
//  StarQuickStart
//
//  Created by Andres Aguaiza on 3/25/19.
//  Copyright © 2019 Andres Aguaiza. All rights reserved.
//

#import "searchPrinterViewController.h"
#import <StarIO/SMPort.h>
#import <StarIO_Extension/StarIoExt.h>
#import <StarIO_Extension/StarIoExtManager.h>
#import "ViewController.h"


@interface searchPrinterViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *portNameArray;
    NSMutableArray *modelNameArray;
}
    
@property (weak, nonatomic) IBOutlet UITableView *table;

@end



@implementation searchPrinterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self arraySetup];
    
    [self searchPrinter];
    
}

#pragma mark - Navigation


//Prepare neccesary port info for main view controller
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)cell{
 
     ViewController *nextViewController = segue.destinationViewController;
     NSIndexPath *path = [self.table indexPathForCell:cell];
     NSString *portSetting = [portNameArray objectAtIndex:path.row];
     NSString *modelType = [modelNameArray objectAtIndex:path.row];
     nextViewController.selectedPortName = portSetting;
     nextViewController.selectedModel = modelType;
     
     
 }


#pragma mark - Search Printer Methods


-(void)arraySetup{
    portNameArray = [NSMutableArray arrayWithArray:@[@""]];
    
    modelNameArray = [NSMutableArray arrayWithArray:@[@""]];
    
    
}


-(void)searchPrinter{
    
    [portNameArray removeAllObjects];
    [modelNameArray removeAllObjects];
    
    NSString *portName;
    NSString *macAdd;
    NSString *modelName;
    NSArray *portInfo;
    NSArray *usbInfo;
    NSArray *searchResults;
    
    
    portInfo = [SMPort searchPrinter];
    
    usbInfo = [SMPort searchPrinter:@"USB:"];
    
    if(usbInfo.count>0){
        
        searchResults  = [portInfo arrayByAddingObjectsFromArray:usbInfo];
        
    }
    
    
    if(searchResults.count>0){
        for (PortInfo *portI in searchResults) {
            
            portName = portI.portName;
            macAdd = portI.macAddress;
            modelName = portI.modelName;
            
            [portNameArray addObject:portName];
            [modelNameArray addObject:modelName];
        }
    }
    
    
    else{
        NSLog(@"No Printers");
    }

    [_table reloadData];
}



#pragma mark - UITableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return portNameArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = portNameArray[indexPath.row];
    cell.detailTextLabel.text = modelNameArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
