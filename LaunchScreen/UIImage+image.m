//
//  UIImage+image.m
//  LaunchScreen
//
//  Created by Fei Cao on 16/1/28.
//  Copyright © 2016年 wxiao. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (instancetype) imageWithOriginalName:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end


