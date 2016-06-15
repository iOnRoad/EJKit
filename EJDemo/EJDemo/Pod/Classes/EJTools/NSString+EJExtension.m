//
//  NSString+EJExtension.m
//  EJDemo
//
//  Created by iOnRoad on 15-4-21.
//  Copyright (c) 2015年 iOnRoad. All rights reserved.
//

#import "NSString+EJExtension.h"

@implementation NSString (EJExtension)

//解密URL
- (NSString*)ej_urlDecode
{
    NSMutableString* output = [NSMutableString string];
    const unsigned char* source = (const unsigned char*)[self UTF8String];
    NSUInteger sourceLen = strlen((const char*)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ') {
            [output appendString:@"+"];
        }
        else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || (thisChar >= 'a' && thisChar <= 'z') || (thisChar >= 'A' && thisChar <= 'Z') || (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        }
        else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

//加密URL
- (NSString*)ej_urlEncode
{
    NSString* result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    if (result) {
        return result;
    }
    return @"";
}


- (UIViewController *)ej_controller{
    UIViewController *controller = nil;
    if(self && self.length>0){
        Class c = NSClassFromString(self);
        if(c){
            controller = [[c alloc] init];
        }
    }
    return controller;
}

- (UIView *)ej_view{
    UIView *view = nil;
    if(self && self.length > 0){
        Class c = NSClassFromString(self);
        if(c){
            view = [[c alloc] init];
        }
    }
    return view;
}

- (UIView *)ej_xibViewWithOwner:(id)owner{
    UIView *xibView = [[NSBundle mainBundle] loadNibNamed:self owner:owner options:nil].firstObject;
    if([xibView isKindOfClass:[UITableViewCell class]]){
        //所有的Cell默认统一设置为15左间距，以防止6s上的cell线边距不同问题
        ((UITableViewCell *)xibView).separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return xibView;
}


@end
