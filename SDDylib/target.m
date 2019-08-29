#import <Foundation/Foundation.h>

static __attribute__((constructor)) void entry(void) {
    NSLog(@"动态库加载成功");
}