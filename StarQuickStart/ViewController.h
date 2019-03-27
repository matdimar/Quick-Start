//
//  ViewController.h
//  StarQuickStart
//
//  Created by Andres Aguaiza on 3/25/19.
//  Copyright © 2019 Andres Aguaiza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StarIO_Extension/StarIoExtManager.h>
#import <StarIO/SMPort.h>
#import <StarIO_Extension/StarIoExt.h>
#import "Communication.h"
#import "receiptBuilder.h"



@interface ViewController : UIViewController <StarIoExtManagerDelegate>

//Passed from searchPrinterViewController
@property(strong,nonatomic) NSString *selectedPortName;
@property(strong,nonatomic) NSString *selectedModel;


//Used to display printer status
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

//
@property (nonatomic) StarIoExtManager *starIoExtManager;




//Printer Setting Labels
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *emulationLabel;
@property (weak, nonatomic) IBOutlet UILabel *portSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;




@end

