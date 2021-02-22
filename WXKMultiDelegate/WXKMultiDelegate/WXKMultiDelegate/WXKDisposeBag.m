//
//  DisposeBag.m
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import "WXKDisposeBag.h"

@interface WXKDisposeBag ()

@property (nonatomic, strong) NSMutableArray *tokens;

@end

@implementation WXKDisposeBag

- (instancetype)init {
    if (self = [super init]) {
        self.tokens = [NSMutableArray array];
    }
    return self;
}

- (void)addToken:(WXKToken *)token {
    [self.tokens addObject:token];
}

- (void)dealloc {
    for(id token in self.tokens) {
        [token dispose];
    }
}

@end
