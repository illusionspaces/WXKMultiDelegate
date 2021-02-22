//
//  WXKToken.m
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import "WXKToken.h"

@implementation WXKToken

- (void)dispose {
    if (self.onDispose) {
        self.onDispose(self.key);
    }
}

@end
