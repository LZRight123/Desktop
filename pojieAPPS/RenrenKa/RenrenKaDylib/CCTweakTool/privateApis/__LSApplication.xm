// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "__LSApplication.h"
#import "CCHelpTool.h"

#pragma mark -
#pragma mark - LSApplicationProxy
%hook LSApplicationProxy
+ (bool)supportsSecureCoding{
    %log;
    bool r = %orig;
    return r;
}

- (NSString *)applicationIdentifier {
    if (isCallFromOriginApp() == false) { return %orig; }

    NSString * r = %orig;
    [CCLogManager addApplicationIdentifier:r];
    return nil;
}

- (NSNumber *)itemID{
    %log;
    id  r = %orig;
    return r;
}
+ (LSApplicationProxy *)applicationProxyForIdentifier:(NSString *)arg1{
    %log;
    LSApplicationProxy *r = %orig;
    if (![arg1 isEqualToString:@"app.xianka.com"]) {
        %log;
    }
    return r;
}
+ (id)applicationProxyForIdentifier:(id)arg1 placeholder:(bool)arg2{
    %log;
    id r = %orig;
    return r;
}

- (NSString *)shortVersionString{
    %log;
    NSString *r = %orig;
    return r;
}
%end















#pragma mark -
#pragma mark - LSPlugInKitProxy
%hook LSPlugInKitProxy
+ (bool)supportsSecureCoding {
    %log;
    bool r = %orig;
    return r;

}
- (LSApplicationProxy *)containingBundle {
    %log;
    id r = %orig;
    return r;

}
- (NSString *)pluginIdentifier {
    %log;
    NSString *r = %orig;
    return r;

}
- (NSString *)pluginUUID {
    %log;
    NSString *r = %orig;
    return r;

}

- (NSString *)teamID{
    %log;
    NSString *r = %orig;
    return r;
}

- (NSDictionary *)infoPlist {
    %log;
    NSDictionary * r = %orig;
    return r;
}

+ (id)containingBundleIdentifiersForPlugInBundleIdentifiers:(id)arg1 error:(id*)arg2 { %log; id r = %orig; return r; }
+ (id)plugInKitProxyForPlugin:(unsigned int)arg1 { %log; id r = %orig; return r; }
+ (id)plugInKitProxyForUUID:(id)arg1 bundleIdentifier:(id)arg2 pluginIdentifier:(id)arg3 effectiveIdentifier:(id)arg4 version:(id)arg5 bundleURL:(id)arg6 { %log; id r = %orig; return r; }
+ (id)pluginKitProxyForIdentifier:(id)arg1 { %log; id r = %orig; return r; }
+ (id)pluginKitProxyForURL:(id)arg1 { %log; id r = %orig; return r; }
+ (id)pluginKitProxyForUUID:(id)arg1 { %log; id r = %orig; return r; }
- (bool)UPPValidated { %log; bool r = %orig; return r; }
- (id)_initWithPlugin:(unsigned int)arg1 { %log; id r = %orig; return r; }
- (id)_initWithUUID:(id)arg1 bundleIdentifier:(id)arg2 pluginIdentifier:(id)arg3 effectiveIdentifier:(id)arg4 version:(id)arg5 bundleURL:(id)arg6 { %log; id r = %orig; return r; }
- (id)_valueForEqualityTesting { %log; id r = %orig; return r; }
- (id)boundIconsDictionary { %log; id r = %orig; return r; }
- (id)iconDataForVariant:(int)arg1 { %log; id r = %orig; return r; }
- (bool)isOnSystemPartition { %log; bool r = %orig; return r; }
- (id)localizedName { %log; id r = %orig; return r; }
- (id)localizedShortName { %log; id r = %orig; return r; }
- (id)objectForInfoDictionaryKey:(id)arg1 ofClass:(Class)arg2 inScope:(unsigned long long)arg3 { %log; id r = %orig; return r; }
- (id)originalIdentifier { %log; id r = %orig; return r; }
- (bool)pluginCanProvideIcon { %log; bool r = %orig; return r; }
- (id)pluginKitDictionary { %log; id r = %orig; return r; }
- (bool)profileValidated { %log; bool r = %orig; return r; }
- (id)protocol { %log; id r = %orig; return r; }
- (id)registrationDate { %log; id r = %orig; return r; }
- (id)_un_applicationBundleURL { %log; id r = %orig; return r; }

%end













#pragma mark -
#pragma mark - LSApplicationWorkspace
%hook LSApplicationWorkspace
+ (id)defaultWorkspace {  id r = %orig; return r; }
- (NSUUID *)deviceIdentifierForVendor {
    //    <__NSConcreteUUID 0x174222ea0> AF5F24D7-D00F-4EDF-B9B3-A1A28C3031E0
    CCLog(@"检测了IDFA");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *idfa = [userDefaults stringForKey:@"com.unique.idfa"];
    if(!idfa)
    {
        idfa = [NSUUID UUID].UUIDString;
        [userDefaults setObject:idfa forKey:@"com.unique.idfa"];
        [userDefaults synchronize];
    }
    NSUUID *udid = [[NSUUID alloc] initWithUUIDString:idfa];
    return udid;
}
- (id)allInstalledApplications {
    %log;
    id r = %orig;
    return r;
}

//MARK:- ios 11
- (NSArray<LSPlugInKitProxy *> *)installedPlugins {
    %log;
    NSMutableArray *tempArr = @[].mutableCopy;
    NSArray *r = %orig;
    for (LSPlugInKitProxy *item in r){
        LSApplicationProxy *ap = [item containingBundle];
        NSString *appidentifer = [ap applicationIdentifier];
        if ([appidentifer containsString:@"com.apple."] || [appidentifer containsString:bunlderID]) {
            [tempArr addObject:item];
        }
    }
    int origCount = [r count];
    int newCout = [tempArr count];
    return tempArr;
}
//MARK:- iOS11 以下的关键函数
- (NSArray<LSApplicationProxy *> *)legacyApplicationProxiesListWithType:(unsigned long long)arg1 {
    %log;
    NSMutableArray *tempArr = @[].mutableCopy;
    NSArray *r = %orig;
    for (LSApplicationProxy *item in r){
        NSString *appidentifer = [item applicationIdentifier];
        if ([appidentifer containsString:@"com.apple."] || [appidentifer containsString:bunlderID]) {
            [tempArr addObject:item];
        }
    }
    return tempArr;
}

- (id)URLOverrideForURL:(id)arg1 {
    %log;
    id r = %orig;
    return r;
}

- (bool)openURL:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)openURL:(id)arg1 withOptions:(id)arg2 { %log; bool r = %orig; return r; }
- (bool)openURL:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }



- (void)enumerateBundlesOfType:(unsigned long long)arg1 block:(id /* block */)arg2 {
    %log;
    %orig;

}
- (void)enumerateBundlesOfType:(unsigned long long)arg1 legacySPI:(bool)arg2 block:(void(^)(LSBundleProxy *proxy, bool *status))arg3 {
    %orig;
}
- (void)enumerateBundlesOfType:(unsigned long long)arg1 usingBlock:(id /* block */)arg2 {
    %log;
    %orig;

}

- (bool)openApplicationWithBundleID:(id)arg1
{
    %log;
    bool r = %orig;
    return r;

}
// system >= 10可用
- (bool)openSensitiveURL:(id)arg1 withOptions:(id)arg2 {
    %log;
    bool r = %orig;
    return r;
}

- (bool)openSensitiveURL:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 {
    %log;
    bool r = %orig;
    return r;
}


- (NSXPCConnection *)connection { %log; NSXPCConnection * r = %orig; return r; }
- (NSMutableDictionary *)createdInstallProgresses { %log; NSMutableDictionary * r = %orig; return r; }
- (LSInstallProgressDelegate *)delegateProxy { %log; LSInstallProgressDelegate * r = %orig; return r; }
- (LSInstallProgressList *)observedInstallProgresses { %log; LSInstallProgressList * r = %orig; return r; }
- (LSApplicationWorkspaceRemoteObserver *)remoteObserver { %log; LSApplicationWorkspaceRemoteObserver * r = %orig; return r; }
+ (id)activeManagedConfigurationRestrictionUUIDs { %log; id r = %orig; return r; }
+ (id)callbackQueue { %log; id r = %orig; return r; }
- (id)URLSchemesOfType:(long long)arg1 { %log; id r = %orig; return r; }
- (void)_LSClearSchemaCaches { %log; %orig; }
- (void)_LSFailedToOpenURL:(id)arg1 withBundle:(id)arg2 { %log; %orig; }
- (bool)_LSPrivateDatabaseNeedsRebuild { %log; bool r = %orig; return r; }
- (bool)_LSPrivateRebuildApplicationDatabasesForSystemApps:(bool)arg1 internal:(bool)arg2 user:(bool)arg3 { %log; bool r = %orig; return r; }
- (void)_LSPrivateSyncWithMobileInstallation { %log; %orig; }
- (void)addObserver:(id)arg1 { %log; %orig; }
- (id)allApplications { %log; id r = %orig; return r; }
- (id)applicationForOpeningResource:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationForUserActivityDomainName:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationForUserActivityType:(id)arg1 { %log; id r = %orig; return r; }
- (bool)applicationIsInstalled:(id)arg1 { %log; bool r = %orig; return r; }
- (id)applicationProxiesWithPlistFlags:(unsigned int)arg1 bundleFlags:(unsigned long long)arg2 { %log; id r = %orig; return r; }
- (id)applicationsAvailableForHandlingURLScheme:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationsAvailableForOpeningDocument:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationsAvailableForOpeningURL:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationsAvailableForOpeningURL:(id)arg1 legacySPI:(bool)arg2 { %log; id r = %orig; return r; }
- (id)applicationsForUserActivityType:(id)arg1 { %log; id r = %orig; return r; }
- (id)applicationsForUserActivityType:(id)arg1 limit:(unsigned long long)arg2 { %log; id r = %orig; return r; }
- (id)applicationsOfType:(unsigned long long)arg1 { %log; id r = %orig; return r; }
- (id)applicationsWithAudioComponents { %log; id r = %orig; return r; }
- (id)applicationsWithUIBackgroundModes { %log; id r = %orig; return r; }
- (id)applicationsWithVPNPlugins { %log; id r = %orig; return r; }
- (id)bundleIdentifiersForMachOUUIDs:(id)arg1 error:(id*)arg2 { %log; id r = %orig; return r; }
- (void)clearAdvertisingIdentifier { %log; %orig; }
- (void)clearCreatedProgressForBundleID:(id)arg1 { %log; %orig; }
//- (id)connection { %log; id r = %orig; return r; }
//- (id)createdInstallProgresses { %log; id r = %orig; return r; }
//- (void)dealloc { %log; %orig; }
//- (id)delegateProxy { %log; id r = %orig; return r; }
- (id)deviceIdentifierForAdvertising { %log; id r = %orig; return r; }
- (id)directionsApplications { %log; id r = %orig; return r; }
- (bool)downgradeApplicationToPlaceholder:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }
- (void)enumerateApplicationsForSiriWithBlock:(id /* block */)arg1 { %log; %orig; }
- (void)enumerateApplicationsOfType:(unsigned long long)arg1 block:(id /* block */)arg2 { %log; %orig; }
- (void)enumerateApplicationsOfType:(unsigned long long)arg1 legacySPI:(bool)arg2 block:(id /* block */)arg3 { %log; %orig; }

- (void)enumeratePluginsMatchingQuery:(id)arg1 withBlock:(id /* block */)arg2 { %log; %orig; }
- (bool)establishConnection { %log; bool r = %orig; return r; }
- (bool)getClaimedActivityTypes:(id*)arg1 domains:(id*)arg2 { %log; bool r = %orig; return r; }

- (unsigned long long)getInstallTypeForOptions:(id)arg1 andApp:(id)arg2 { %log; unsigned long long r = %orig; return r; }
- (void)getKnowledgeUUID:(id*)arg1 andSequenceNumber:(id*)arg2 { %log; %orig; }
- (bool)installApplication:(id)arg1 withOptions:(id)arg2 { %log; bool r = %orig; return r; }
- (bool)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }
- (bool)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 usingBlock:(id /* block */)arg4 { %log; bool r = %orig; return r; }
- (id)installBundle:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3 forApp:(id)arg4 withError:(id*)arg5 outInstallProgress:(id*)arg6 { %log; id r = %orig; return r; }
- (bool)installPhaseFinishedForProgress:(id)arg1 { %log; bool r = %orig; return r; }
- (id)installProgressForApplication:(id)arg1 withPhase:(unsigned long long)arg2 { %log; id r = %orig; return r; }
- (id)installProgressForBundleID:(id)arg1 makeSynchronous:(unsigned char)arg2 { %log; id r = %orig; return r; }
- (bool)invalidateIconCache:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)isApplicationAvailableToOpenURL:(id)arg1 error:(id*)arg2 { %log; bool r = %orig; return r; }
- (bool)isApplicationAvailableToOpenURL:(id)arg1 includePrivateURLSchemes:(bool)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }
- (bool)isApplicationAvailableToOpenURLCommon:(id)arg1 includePrivateURLSchemes:(bool)arg2 error:(id*)arg3 { %log; bool r = %orig; return r; }
- (id)machOUUIDsForBundleIdentifiers:(id)arg1 error:(id*)arg2 { %log; id r = %orig; return r; }


- (void)openUserActivity:(id)arg1 withApplicationProxy:(id)arg2 completionHandler:(id /* block */)arg3 { %log; %orig; }
- (void)openUserActivity:(id)arg1 withApplicationProxy:(id)arg2 options:(id)arg3 completionHandler:(id /* block */)arg4 { %log; %orig; }
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 sourceIsManaged:(bool)arg4 userInfo:(id)arg5 delegate:(id)arg6 { %log; id r = %orig; return r; }
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4 { %log; id r = %orig; return r; }
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4 delegate:(id)arg5 { %log; id r = %orig; return r; }
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 userInfo:(id)arg3 { %log; id r = %orig; return r; }
- (id)placeholderApplications { %log; id r = %orig; return r; }
- (id)pluginsMatchingQuery:(id)arg1 applyFilter:(id /* block */)arg2 { %log; id r = %orig; return r; }
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3 { %log; id r = %orig; return r; }
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3 applyFilter:(id /* block */)arg4 { %log; id r = %orig; return r; }
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3 withFilter:(id /* block */)arg4 { %log; id r = %orig; return r; }
- (id)privateURLSchemes { %log; id r = %orig; return r; }
- (id)publicURLSchemes { %log; id r = %orig; return r; }
- (bool)registerApplication:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)registerApplicationDictionary:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)registerApplicationDictionary:(id)arg1 withObserverNotification:(int)arg2 { %log; bool r = %orig; return r; }
- (bool)registerBundleWithInfo:(id)arg1 options:(id)arg2 type:(unsigned long long)arg3 progress:(id)arg4 { %log; bool r = %orig; return r; }
- (bool)registerPlugin:(id)arg1 { %log; bool r = %orig; return r; }
- (void)removeInstallProgressForBundleID:(id)arg1 { %log; %orig; }
- (bool)restoreSystemApplication:(id)arg1 { %log; bool r = %orig; return r; }
- (void)scanForApplicationStateChangesFromRank:(id)arg1 toRank:(id)arg2 { %log; %orig; }
- (void)scanForApplicationStateChangesFromWhitelist:(id)arg1 to:(id)arg2 { %log; %orig; }
- (void)sendApplicationStateChangedNotificationsFor:(id)arg1 { %log; %orig; }
- (void)sendInstallNotificationForApp:(id)arg1 withPlugins:(id)arg2 { %log; %orig; }
- (void)sendUninstallNotificationForApp:(id)arg1 withPlugins:(id)arg2 { %log; %orig; }
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 { %log; bool r = %orig; return r; }
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 usingBlock:(id /* block */)arg4 { %log; bool r = %orig; return r; }
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3 { %log; bool r = %orig; return r; }
- (bool)uninstallSystemApplication:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3 { %log; bool r = %orig; return r; }
- (bool)unregisterApplication:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)unregisterPlugin:(id)arg1 { %log; bool r = %orig; return r; }
- (id)unrestrictedApplications { %log; id r = %orig; return r; }
- (bool)updateRecordForApp:(id)arg1 withSINF:(id)arg2 iTunesMetadata:(id)arg3 error:(id*)arg4 { %log; bool r = %orig; return r; }
- (bool)updateSINFWithData:(id)arg1 forApplication:(id)arg2 options:(id)arg3 error:(id*)arg4 { %log; bool r = %orig; return r; }
- (bool)updateiTunesMetadataWithData:(id)arg1 forApplication:(id)arg2 options:(id)arg3 error:(id*)arg4 { %log; bool r = %orig; return r; }
- (void)_sf_openURL:(id)arg1 withOptions:(id)arg2 completionHandler:(id /* block */)arg3 { %log; %orig; }
%end

















#pragma mark -
#pragma mark - LSApplicationRestrictionsManager
%hook LSApplicationRestrictionsManager
+ (id)sharedInstance {
    %log;
    id r = %orig;
    return r;
}

- (void)setWhitelistedBundleIDs:(id)arg1 {
    %log;
    %orig;
}

- (bool )isAdTrackingEnabled { %log; bool  r = %orig; return r; }
- (NSSet *)blacklistedBundleIDs { %log; NSSet * r = %orig; return r; }
- (NSNumber *)maximumRating { %log; NSNumber * r = %orig; return r; }
- (bool )isOpenInRestrictionInEffect { %log; bool  r = %orig; return r; }
- (NSSet *)removedSystemApplications { %log; NSSet * r = %orig; return r; }
- (NSSet *)restrictedBundleIDs { %log; NSSet * r = %orig; return r; }
- (bool )isWhitelistEnabled { %log; bool  r = %orig; return r; }
- (NSSet *)whitelistedBundleIDs { %log; NSSet * r = %orig; return r; }
+ (id)activeRestrictionIdentifiers { %log; id r = %orig; return r; }
- (id)_LSResolveIdentifiers:(id)arg1 { %log; id r = %orig; return r; }
- (void)addPendingChanges:(id)arg1 { %log; %orig; }
- (id)allowedOpenInAppBundleIDsAfterApplyingFilterToAppBundleIDs:(id)arg1 originatingAppBundleID:(id)arg2 originatingAccountIsManaged:(bool)arg3 { %log; id r = %orig; return r; }
- (void)beginListeningForChanges { %log; %orig; }
- (id)blacklistedBundleID { %log; id r = %orig; return r; }
- (id)calculateSetDifference:(id)arg1 and:(id)arg2 { %log; id r = %orig; return r; }
- (void)clearAllValues { %log; %orig; }
- (void)clearPendingChanges { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (void)handleMCEffectiveSettingsChanged { %log; %orig; }
- (void)handleMCRemovedSystemAppsChanged { %log; %orig; }
- (id)init { %log; id r = %orig; return r; }
- (bool)isAppExtensionRestricted:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)isApplicationRemoved:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)isApplicationRestricted:(id)arg1 { %log; bool r = %orig; return r; }
- (bool)isApplicationRestricted:(id)arg1 checkFeatureRestrictions:(bool)arg2 { %log; bool r = %orig; return r; }
- (bool)isFeatureAllowed:(unsigned long long)arg1 { %log; bool r = %orig; return r; }
- (bool)isRatingAllowed:(id)arg1 { %log; bool r = %orig; return r; }
- (id)pendingChanges { %log; id r = %orig; return r; }
- (bool)setApplication:(id)arg1 removed:(bool)arg2 { %log; bool r = %orig; return r; }
- (void)setBlacklistedBundleIDs:(id)arg1 { %log; %orig; }
- (void)setRemovedSystemApplications:(id)arg1 { %log; %orig; }
- (void)setRestrictedBundleIDs:(id)arg1 { %log; %orig; }
%end
