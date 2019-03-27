//
//  receiptBuilder.m
//  StarQuickStart
//
//  Created by Andres Aguaiza on 3/25/19.
//  Copyright © 2019 Andres Aguaiza. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "receiptBuilder.h"
#import "AppDelegate.h"


@implementation receiptBuilder

+ (void)append3inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                         "123 Star Road\n"
                         "City, State 12345\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY                    Time:HH:MM PM\n"
                         "------------------------------------------------\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE \n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU               Description              Total\n"
                         "300678566         PLAIN T-SHIRT            10.99\n"
                         "300692003         BLACK DENIM              29.99\n"
                         "300651148         BLUE DENIM               29.99\n"
                         "300642980         STRIPED DRESS            49.99\n"
                         "300638471         BLACK BOOTS              35.99\n"
                         "\n"
                         "Subtotal                                  156.95\n"
                         "Tax                                         0.00\n"
                         "------------------------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total                       " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"------------------------------------------------\n"
                         "\n"
                         "Charge\n"
                         "159.95\n"
                         "Visa XXXX-XXXX-XXXX-0123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
    
    [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
}

+ (void)append2inchTextReceiptData:(ISCBBuilder *)builder utf8:(BOOL)utf8 {
    NSStringEncoding encoding;
    
    if (utf8 == YES) {
        encoding = NSUTF8StringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeUTF8];
    }
    else {
        encoding = NSASCIIStringEncoding;
        
        [builder appendCodePage:SCBCodePageTypeCP998];
    }
    
    [builder appendInternational:SCBInternationalTypeUSA];
    
    [builder appendCharacterSpace:0];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendData:[@"Star Clothing Boutique\n"
                         "123 Star Road\n"
                         "City, State 12345\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionLeft];
    
    [builder appendData:[@"Date:MM/DD/YYYY    Time:HH:MM PM\n"
                         "--------------------------------\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithEmphasis:[@"SALE\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"SKU         Description    Total\n"
                         "300678566   PLAIN T-SHIRT  10.99\n"
                         "300692003   BLACK DENIM    29.99\n"
                         "300651148   BLUE DENIM     29.99\n"
                         "300642980   STRIPED DRESS  49.99\n"
                         "300638471   BLACK BOOTS    35.99\n"
                         "\n"
                         "Subtotal                  156.95\n"
                         "Tax                         0.00\n"
                         "--------------------------------\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Total     " dataUsingEncoding:encoding]];
    
    [builder appendDataWithMultiple:[@"   $156.95\n" dataUsingEncoding:encoding] width:2 height:2];
    
    [builder appendData:[@"--------------------------------\n"
                         "\n"
                         "Charge\n"
                         "159.95\n"
                         "Visa XXXX-XXXX-XXXX-0123\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendDataWithInvert:[@"Refunds and Exchanges\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"Within " dataUsingEncoding:encoding]];
    
    [builder appendDataWithUnderLine:[@"30 days" dataUsingEncoding:encoding]];
    
    [builder appendData:[@" with receipt\n" dataUsingEncoding:encoding]];
    
    [builder appendData:[@"And tags attached\n"
                         "\n" dataUsingEncoding:encoding]];
    
    [builder appendAlignment:SCBAlignmentPositionCenter];
    
    [builder appendBarcodeData:[@"{BStar." dataUsingEncoding:NSASCIIStringEncoding] symbology:SCBBarcodeSymbologyCode128 width:SCBBarcodeWidthMode2 height:40 hri:YES];
}


+ (UIImage *)create3inchRasterReceiptImage {
    NSString *textToPrint =
    @"        Star Clothing Boutique\n"
    "             123 Star Road\n"
    "           City, State 12345\n"
    "\n"
    "Date:MM/DD/YYYY          Time:HH:MM PM\n"
    "--------------------------------------\n"
    "SALE\n"
    "SKU            Description       Total\n"
    "300678566      PLAIN T-SHIRT     10.99\n"
    "300692003      BLACK DENIM       29.99\n"
    "300651148      BLUE DENIM        29.99\n"
    "300642980      STRIPED DRESS     49.99\n"
    "30063847       BLACK BOOTS       35.99\n"
    "\n"
    "Subtotal                        156.95\n"
    "Tax                               0.00\n"
    "--------------------------------------\n"
    "Total                          $156.95\n"
    "--------------------------------------\n"
    "\n"
    "Charge\n"
    "159.95\n"
    "Visa XXXX-XXXX-XXXX-0123\n"
    "Refunds and Exchanges\n"
    "Within 30 days with receipt\n"
    "And tags attached\n";
    
    UIFont *font = [UIFont fontWithName:@"Menlo" size:12 * 2];
    
    return [self imageWithString:textToPrint font:font width:576];// 3inch(576dots)
}



+ (UIImage *)imageWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributeDic
                                       context:nil].size;
    
    if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]) {
        if (UIScreen.mainScreen.scale == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] set];
    
    CGRect rect = CGRectMake(0, 0, size.width + 1, size.height + 1);
    
    CGContextFillRect(context, rect);
    
    NSDictionary *attributes = @ {
    NSForegroundColorAttributeName:[UIColor blackColor],
    NSFontAttributeName:font
    };
    
    [string drawInRect:rect withAttributes:attributes];
    
    UIImage *imageToPrint = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageToPrint;
}

@end
