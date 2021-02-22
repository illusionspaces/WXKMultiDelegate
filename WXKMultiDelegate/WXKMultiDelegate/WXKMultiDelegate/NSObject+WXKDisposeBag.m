//
//  NSObject+DisposeBag.m
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import "NSObject+WXKDisposeBag.h"
#import <objc/runtime.h>

@implementation NSObject (WXKDisposeBag)

- (WXKDisposeBag *)wxk_disposeBag {
    WXKDisposeBag *disposeBag = objc_getAssociatedObject(self, @selector(wxk_disposeBag));
    if (!disposeBag) {
        disposeBag = [[WXKDisposeBag alloc] init];
        objc_setAssociatedObject(self, @selector(wxk_disposeBag), disposeBag, OBJC_ASSOCIATION_RETAIN);
    }
    return disposeBag;
}

@end
