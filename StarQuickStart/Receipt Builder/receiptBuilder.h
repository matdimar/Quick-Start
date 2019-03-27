//
//  receiptBuilder.h
//  StarQuickStart
//
//  Created by Andres Aguaiza on 3/25/19.
//  Copyright © 2019 Andres Aguaiza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StarIO/SMPort.h>
#import <StarIO_Extension/StarIoExt.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface receiptBuilder : NSObject

+ (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;

+ (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8;

+ (UIImage *)create3inchRasterReceiptImage;

@end

NS_ASSUME_NONNULL_END
