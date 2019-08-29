// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "CCHelpTool.h"
#import "__MCMContainer.h"


#pragma mark -
#pragma mark - MCMAppContainer
%hook MCMContainer
+ (id)containerWithIdentifier:(id)arg1 error:(id*)arg2 { %log; id r = %orig; return r; }

- (long long )containerClass { %log; long long  r = %orig; return r; }
- (NSString *)identifier { %log; NSString * r = %orig; return r; }
- (NSDictionary *)info { %log; NSDictionary * r = %orig; return r; }
- (bool )isTemporary { %log; bool  r = %orig; return r; }
- (NSURL *)url { %log; NSURL * r = %orig; return r; }
- (NSUUID *)uuid { %log; NSUUID * r = %orig; return r; }
+ (id)containerWithIdentifier:(id)arg1 createIfNecessary:(bool)arg2 existed:(bool*)arg3 error:(id*)arg4 { %log; id r = %orig; return r; }
+ (id)temporaryContainerWithIdentifier:(id)arg1 existed:(bool*)arg2 error:(id*)arg3 { %log; id r = %orig; return r; }
- (void)_errorOccurred { %log; %orig; }
- (long long)_getContainerClass { %log; long long r = %orig; return r; }

- (void)dealloc { %log; %orig; }
- (id)description { %log; id r = %orig; return r; }
- (id)destroyContainerWithCompletion:(id /* block */)arg1 { %log; id r = %orig; return r; }
- (unsigned long long)diskUsageWithError:(id*)arg1 { %log; unsigned long long r = %orig; return r; }
- (unsigned long long)hash { %log; unsigned long long r = %orig; return r; }
- (id)infoValueForKey:(id)arg1 error:(id*)arg2 { %log; id r = %orig; return r; }
- (id)init { %log; id r = %orig; return r; }
- (id)initWithIdentifier:(id)arg1 createIfNecessary:(bool)arg2 existed:(bool*)arg3 temp:(bool)arg4 error:(id*)arg5 { %log; id r = %orig; return r; }
- (id)initWithIdentifier:(id)arg1 userId:(unsigned int)arg2 uuid:(id)arg3 containerClass:(long long)arg4 error:(id*)arg5 { %log; id r = %orig; return r; }
- (bool)isEqual:(id)arg1 { %log; bool r = %orig; return r; }
- (void)markDeleted { %log; %orig; }
- (bool)recreateDefaultStructureWithError:(id*)arg1 { %log; bool r = %orig; return r; }
- (bool)regenerateDirectoryUUIDWithError:(id*)arg1 { %log; bool r = %orig; return r; }
- (bool)setInfoValue:(id)arg1 forKey:(id)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }
%end


