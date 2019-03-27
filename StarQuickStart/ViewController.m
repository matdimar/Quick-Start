//
//  ViewController.m
//  StarQuickStart
//
//  Created by Andres Aguaiza on 3/25/19.
//  Copyright © 2019 Andres Aguaiza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController


#pragma mark Printer Setting Check and Display

-(void)printerModelCheck{
    
    NSLog(@"%@", _selectedModel);
    
    if([_selectedModel containsString:@"MCP3"]){
        NSLog(@"this is an MC3");
        
        _modelLabel.text = @"mC-Print3";
        _emulationLabel.text = @"StarPRNT";
        _portSettingLabel.text = @"Empty Quotes";
        _widthLabel.text = @"576";
    }
    
    else if ([_selectedModel containsString:@"TSP143"]) {
        NSLog(@"This is a 100");
        
        _modelLabel.text = @"TSP100";
        _emulationLabel.text = @"StarGraphi";
        _portSettingLabel.text = @"Empty Quotes";
        _widthLabel.text = @"576";
    }
    
    else if([_selectedModel containsString:@"TSP650"]){
        NSLog(@"This is a 650");
        
        _modelLabel.text = @"TSP650ii";
        _emulationLabel.text = @"StarPRNT";
        _portSettingLabel.text = @"Empty Quotes";
        _widthLabel.text = @"576";
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self printerModelCheck];
    
    _commentLabel.text = @"";
    
    _commentLabel.adjustsFontSizeToFitWidth = YES;
    
    _starIoExtManager = [[StarIoExtManager alloc] initWithType:StarIoExtManagerTypeWithBarcodeReader
                                               portName:_selectedPortName
                                               portSettings:@""
                                               ioTimeoutMillis:10000];
    
    _starIoExtManager.delegate = self;
    
    [self refreshPrinter];
    
}


- (IBAction)printButton:(id)sender {
    
    
    //Instanciate the builder object
    ISCBBuilder *documentBuilder;
    
    
    //Catch exception in case we're using a Raster printer - note the document creation procedure in this case
    if([_selectedModel containsString:@"TSP100"]){
        
        documentBuilder = [StarIoExt createCommandBuilder:StarIoExtEmulationStarGraphic];
        UIImage *img =  [receiptBuilder create3inchRasterReceiptImage];
        [documentBuilder beginDocument];
        [documentBuilder appendBitmap:img diffusion:false];
        [documentBuilder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        [documentBuilder endDocument];
        
    }
    
    else {
        
        documentBuilder = [StarIoExt createCommandBuilder:StarIoExtEmulationStarPRNT];
        
        [receiptBuilder append3inchTextReceiptData:documentBuilder utf8:TRUE];
        
    }
    
    

  
    
    [_starIoExtManager.lock lock];
    
    dispatch_async(GlobalQueueManager.sharedManager.serialQueue, ^{
        
        [Communication sendCommands:documentBuilder.commands
                               port:self->_starIoExtManager.port
                  completionHandler:NULL];
        
        [self->_starIoExtManager.lock unlock];
      
    });
    
}







- (void)refreshPrinter {
    
    [_starIoExtManager disconnect];
    
    if ([_starIoExtManager connect] == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Fail to Open Port."
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    self->_commentLabel.text = @"Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button.";
                                                    
                                                    self->_commentLabel.textColor = [UIColor redColor];
                                                    
                                                    [self beginAnimationCommantLabel];
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}



#pragma mark StarIOExtManager Delegate Methods

- (void)didPrinterImpossible:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Impossible.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterOnline:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Online.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterOffline:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //  _commentLabel.text = @"Printer Offline.";
    //
    //  _commentLabel.textColor = [UIColor redColor];
    //
    //  [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperReady:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //  _commentLabel.text = @"Printer Paper Ready.";
    //
    //  _commentLabel.textColor = [UIColor blueColor];
    //
    //  [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperNearEmpty:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Paper Near Empty.";
    
    _commentLabel.textColor = [UIColor orangeColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterPaperEmpty:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Paper Empty.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterCoverOpen:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Printer Cover Open.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
}

- (void)didPrinterCoverClose:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //  _commentLabel.text = @"Printer Cover Close.";
    //
    //  _commentLabel.textColor = [UIColor blueColor];
    //
    //  [self beginAnimationCommantLabel];
}

- (void)didAccessoryConnectSuccess:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Success.";
    
    _commentLabel.textColor = [UIColor blueColor];
    
    [self beginAnimationCommantLabel];
    
}

- (void)didAccessoryConnectFailure:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Connect Failure.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];
    
}

- (void)didAccessoryDisconnect:(StarIoExtManager *)manager {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Accessory Disconnect.";
    
    _commentLabel.textColor = [UIColor redColor];
    
    [self beginAnimationCommantLabel];

}

- (void)didStatusUpdate:(StarIoExtManager *)manager status:(NSString *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //  _commentLabel.text = status;
    //
    //  _commentLabel.textColor = [UIColor greenColor];
    //
    //  [self beginAnimationCommantLabel];
}

- (void)beginAnimationCommantLabel {
    [UIView beginAnimations:nil context:nil];
    
    _commentLabel.alpha = 0.0;
    
    [UIView setAnimationDelay             :0.0];                            // 0mS!!!
    [UIView setAnimationDuration          :0.6];                            // 600mS!!!
    [UIView setAnimationRepeatCount       :UINT32_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve             :UIViewAnimationCurveEaseIn];
    
    _commentLabel.alpha = 1.0;
    
    [UIView commitAnimations];
}


#pragma mark Barcode Reader Method

- (void)didBarcodeDataReceive:(StarIoExtManager *)manager data:(NSData *)data {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _commentLabel.text = @"Hello World";
    
    _commentLabel.textColor = [UIColor purpleColor];
    
    [self beginAnimationCommantLabel];

}



@end
