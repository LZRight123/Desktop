// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>


%hook MMClientCacheManager
- (NSString *)getInfoPath {
    %log;
    NSString *r = %orig;
    NSString *result1 = [[NSString alloc] initWithContentsOfFile:r];
    NSData *data1 = [NSData dataWithContentsOfFile:r];
    if ( result1 || data1 ){
//        /var/mobile/Containers/Data/Application/9AB836D3-EA8F-4ED3-ADD4-707C94853774/Library/WechatPrivate/0b725bcd6d2554e2e4e171b7f5bf3045/Moss/sae/sae.dat
        NSLog(@"");
    }
    return r;
}
- (id)getBasicData { %log; id r = %orig; return r; }



- (void)updateKey:(id)arg1 { %log; %orig; }
- (void)doSSReport:(unsigned long long)arg1 { %log; %orig; }
- (void)doDReport { %log; %orig; }
- (void)reportExtInfo:(id)arg1 { %log; %orig; }
- (void)OnCdnDownload:(id)arg1 { %log; %orig; }
- (void)onNewRegOK { %log; %orig; }
- (void)onManulLoginOK { %log; %orig; }
- (void)OnGetNewXmlMsg:(id)arg1 Type:(id)arg2 MsgWrap:(id)arg3 { %log; %orig; }
- (void)onAuthOK { %log; %orig; }
- (void)onServiceTerminate { %log; %orig; }
- (void)onServiceEnterForeground { %log; %orig; }
- (void)onServiceEnterBackground { %log; %orig; }

- (void)dealloc { %log; %orig; }
- (id)init { %log; id r = %orig; return r; }
- (NSString *)_curDownloadUrl{
    %log; id r = %orig; return r;
}
- (NSString *)curDownloadUrl{
    %log; id r = %orig; return r;
}
- (BOOL)m_isServicePersistent{
    %log; BOOL r = %orig; return r;
}
- (BOOL)m_isServiceRemoved{
    %log; BOOL r = %orig; return r;
}
%end





%hook CUtility
+ (NSString *)GetPathOfCacheLocalUsrDir {
    NSString *r = %orig;
    if (![r containsString:@"0000000000000000"]){
        NSLog(@"");
    }
    return r;
}


//+ (id)GetPathTranslateImgForKey:(id)arg1 { %log; id r = %orig; return r; }
//+ (id)GetPathOfTranslateImgDir { %log; id r = %orig; return r; }
+ (_Bool)isBeingDebugged { %log; _Bool r = %orig; return r; }
+ (int)getGeneralNetworkType { %log; int r = %orig; return r; }
+ (int)getWebpNetworkType { %log; int r = %orig; return r; }
+ (id)getMatchFullPinYinText:(id)arg1 searchText:(id)arg2 dicPinYin:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getMatchShortPinYinText:(id)arg1 searchText:(id)arg2 dicPinYin:(id)arg3 { %log; id r = %orig; return r; }
+ (_Bool)hasPinYinPrefix:(id)arg1 searchText:(id)arg2 options:(unsigned long long)arg3 { %log; _Bool r = %orig; return r; }
+ (_Bool)isEnglishLetter:(unsigned short)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isTrailSurrogates:(unsigned short)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isLeadSurrogates:(unsigned short)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isValidWeChatID:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)containOnlyLetterOrDigit:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isNumber:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isEnglishWord:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (id)GetTelephonyNetWorkCountryCode { %log; id r = %orig; return r; }
+ (id)GetEmoticonLinkPid:(id)arg1 { %log; id r = %orig; return r; }
+ (id)imageBorderFromColor:(id)arg1 size:(struct CGSize)arg2 conerSize:(double)arg3 { %log; id r = %orig; return r; }
+ (id)imageFromColor:(id)arg1 size:(struct CGSize)arg2 { %log; id r = %orig; return r; }
+ (id)ellipseImageFromColor:(id)arg1 size:(struct CGSize)arg2 { %log; id r = %orig; return r; }
+ (id)snapshotForUIView:(id)arg1 { %log; id r = %orig; return r; }
+ (id)dumpSqlString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)filterAllWhiteSpaceAndNewLineString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)filterWhiteSpaceAndNewLineString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)filterString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)trimString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetExcutablePath { %log; id r = %orig; return r; }
+ (void)UpdateUserAgent { %log; %orig; }
+ (id)GetMMUserAgent { %log; id r = %orig; return r; }
+ (id)GetUserAgentSuffix { %log; id r = %orig; return r; }
+ (int)imageTypeForImageData:(id)arg1 { %log; int r = %orig; return r; }
+ (void)ReportFailIPToNewDNS:(id)arg1 { %log; %orig; }
+ (id)DoNewDns:(id)arg1 { %log; id r = %orig; return r; }
+ (id)DoNewDnsForSns:(id)arg1 DnsType:(unsigned int *)arg2 IsOldData:(_Bool)arg3 { %log; id r = %orig; return r; }
+ (id)DoNewDns:(id)arg1 DnsType:(unsigned int *)arg2 { %log; id r = %orig; return r; }
+ (id)DoDns:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetDNSServers { %log; id r = %orig; return r; }
+ (id)md5OfString:(id)arg1 { %log; id r = %orig; return r; }
+ (_Bool)isGIFFile:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (id)SafeUnarchiveFromData:(id)arg1 { %log; id r = %orig; return r; }
+ (id)SafeUnarchive:(id)arg1 hasError:(_Bool *)arg2 { %log; id r = %orig; return r; }
+ (id)SafeUnarchive:(id)arg1 { %log; id r = %orig; return r; }
+ (id)getStringFromUrl:(id)arg1 needle:(id)arg2 { %log; id r = %orig; return r; }
+ (id)getDomainName:(id)arg1 { %log; id r = %orig; return r; }
+ (id)ReplaceClientVersion:(id)arg1 { %log; id r = %orig; return r; }
+ (id)UTF8HexToNSString:(id)arg1 { %log; id r = %orig; return r; }
+ (_Bool)IsFacebookAuthName:(id)arg1 { %log; _Bool r = %orig; return r; }
//+ (id)SafeUtf8WithCString:(const char *)arg1 { %log; id r = %orig; return r; }
+ (id)componentsSeparated:(id)arg1 byString:(id)arg2 { %log; id r = %orig; return r; }
+ (_Bool)IsCurLanguageChineseTraditional { %log; _Bool r = %orig; return r; }
+ (id)getCurSystemLanguage { %log; id r = %orig; return r; }
+ (id)getSystemTimeZoneString { %log; id r = %orig; return r; }
+ (_Bool)IsURLFromAppStore:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (unsigned int)getRegSrcVersionNum { %log; unsigned int r = %orig; return r; }
+ (id)stringOfFriendlySizeForApple:(double)arg1 maxFractionDigits:(unsigned long long)arg2 { %log; id r = %orig; return r; }
+ (id)stringOfFriendlySize:(double)arg1 maxFractionDigits:(unsigned long long)arg2 { %log; id r = %orig; return r; }
+ (id)SyncBufferToString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)MergeSyncBuffer:(id)arg1 NewBuffer:(id)arg2 { %log; id r = %orig; return r; }
+ (id)IntToIPString:(unsigned int)arg1 { %log; id r = %orig; return r; }
+ (id)SockAddrToIPV4String:(struct sockaddr_in *)arg1 { %log; id r = %orig; return r; }
+ (unsigned int)IPStringToInt:(id)arg1 { %log; unsigned int r = %orig; return r; }
+ (_Bool)NeedNewSync:(unsigned int)arg1 { %log; _Bool r = %orig; return r; }
+ (double)getCurrentClock { %log; double r = %orig; return r; }
+ (unsigned long long)genCurrentTimeInMsFrom1970 { %log; unsigned long long r = %orig; return r; }
+ (unsigned long long)genCurrentTimeInMs { %log; unsigned long long r = %orig; return r; }
+ (unsigned int)genCurrentTime { %log; unsigned int r = %orig; return r; }
+ (unsigned int)genServerCurrentTime { %log; unsigned int r = %orig; return r; }
+ (unsigned int)genServerCurrentTimeNotABTest { %log; unsigned int r = %orig; return r; }
+ (_Bool)isStartPhoneTimeChanged { %log; _Bool r = %orig; return r; }
+ (_Bool)isEnterpriseSingleUsrName:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)isEnterpriseUsrName:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (id)ReplaceSingleQuote:(id)arg1 { %log; id r = %orig; return r; }
+ (id)ReplaceInvalidChar:(id)arg1 { %log; id r = %orig; return r; }
+ (_Bool)is64BitEnvironment { %log; _Bool r = %orig; return r; }
+ (void)PrintClientInfo { %log; %orig; }
+ (id)ParseFullVersionString:(unsigned int)arg1 { %log; id r = %orig; return r; }
+ (id)ParseVersionString:(unsigned int)arg1 { %log; id r = %orig; return r; }
+ (void)ParseVersion:(unsigned int)arg1 Major:(unsigned int *)arg2 Minor:(unsigned int *)arg3 Minorex:(unsigned int *)arg4 { %log; %orig; }
+ (void)SetNewVersion:(unsigned int)arg1 { %log; %orig; }
//+ (unsigned int)GetVersionFromPList { %log; unsigned int r = %orig; return r; }
//+ (unsigned int)GetVersion { %log; unsigned int r = %orig; return r; }
+ (id)DecodeWithBase64:(id)arg1 { %log; id r = %orig; return r; }
+ (id)EncodeWithBase64:(id)arg1 { %log; id r = %orig; return r; }
+ (id)DecodeBase64:(id)arg1 { %log; id r = %orig; return r; }
+ (id)NsDataEncodeBase64:(id)arg1 { %log; id r = %orig; return r; }
+ (id)EncodeBase64:(id)arg1 { %log; id r = %orig; return r; }
//+ (id)GetSystemCachePath { %log; id r = %orig; return r; }
//+ (id)GetLibraryCachePath { %log; id r = %orig; return r; }
//+ (id)GetTmpPath { %log; id r = %orig; return r; }
//+ (id)GetDocPath { %log; id r = %orig; return r; }
//+ (id)GetPathOfLocationCache { %log; id r = %orig; return r; }
//+ (id)GetPathOfURLCache { %log; id r = %orig; return r; }
+ (id)GetDownloadPathOfEmoticonPackage:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfTempPackage:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetThumbPathOfPackage:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfPackage:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfMassShortVideoDir:(id)arg1 andVideoName:(id)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getPathOfMsgVcodec2NormalImg:(id)arg1 localID:(unsigned int)arg2 docPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getPathOfMsgVcodec2HDImg:(id)arg1 localID:(unsigned int)arg2 docPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getPathOfMsgVcodec2Img:(id)arg1 localID:(unsigned int)arg2 docPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getPathOfMsgVcodec2ImgThumb:(id)arg1 localID:(unsigned int)arg2 docPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)getPathOfVcodec2ImageDir:(id)arg1 docPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)getPathOfVcodec2ImageDir:(id)arg1 { %log; id r = %orig; return r; }
+ (id)getPathOfVcodec2ToJpgTmpDir:(id)arg1 docPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetTempPathOfDocVideoPath:(id)arg1 ensureCreate:(_Bool)arg2 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesOpenDataDir:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesOpenDataDir:(id)arg1 DocPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetPathOfTempCacheVideo { %log; id r = %orig; return r; }
+ (unsigned int)getCrc32ClientIDOfMsg:(id)arg1 LocalID:(unsigned int)arg2 Time:(unsigned int)arg3 { %log; unsigned int r = %orig; return r; }
+ (id)GetClientIDOfMsg:(id)arg1 LocalID:(unsigned int)arg2 Time:(unsigned int)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesVideoDir:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesVideoThumb:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetTempPathOfMesVideo:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesVideo:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesVideoDir:(id)arg1 DocPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetPathOfWebMesAudioTrans:(id)arg1 LocalID:(id)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesAudioTrans:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesAudioDir:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfOriAudioMesForSend:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesAudio:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesAudioDir:(id)arg1 DocPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesSettingDir { %log; id r = %orig; return r; }
+ (id)GetPathOfMesImgDir:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfDraftUsrDir { %log; id r = %orig; return r; }
+ (id)GetPathOfMesHDImgTemp:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesImgTemp:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfSquareMesImgThumb:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMaskedMesVideoThumb:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMaskedMesImgThumb:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesImgThumb:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesHDImg:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMiddleImgForSender:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesImg:(id)arg1 LocalID:(unsigned int)arg2 DocPath:(id)arg3 { %log; id r = %orig; return r; }
+ (id)GetPathOfMesImgDir:(id)arg1 DocPath:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetPathOfProductItem:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfProductDetail { %log; id r = %orig; return r; }
+ (id)GetPathOfAlbumCoverRootPath { %log; id r = %orig; return r; }
+ (id)GetPathOfLyricsRootPath { %log; id r = %orig; return r; }
+ (id)GetPathOfSnsMusicStoragePB { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeBkgUp { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeBeaconStorage { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeBeaconStoragePB { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeTvMsgStorage { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeTvStorage { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeTvStoragePB { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeMusicStorage { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeMusicStoragePB { %log; id r = %orig; return r; }
+ (id)GetPathOfSHakePeopleStorage { %log; id r = %orig; return r; }
+ (id)GetPathOfShakePeopleStoragePB { %log; id r = %orig; return r; }
+ (id)GetUserAlbumRootDir { %log; id r = %orig; return r; }
+ (id)GetRandomPathOfTrash { %log; id r = %orig; return r; }
+ (id)GetRootPathOfTrash { %log; id r = %orig; return r; }
+ (id)GetPathOfWCRedEnvelopesBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfJSApiLocalDataBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfWCPayTempDir { %log; id r = %orig; return r; }
+ (id)GetPathOfKindaFileCacheBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfKindaBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfWCPayBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfWCMallBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfWCAddressBaseFile { %log; id r = %orig; return r; }
+ (id)GetPathOfSystemAuthorization { %log; id r = %orig; return r; }
+ (id)GetVoiceInputTypeDicPath { %log; id r = %orig; return r; }
+ (id)GetPathOfWeSport { %log; id r = %orig; return r; }
+ (id)GetPathOfBakChat { %log; id r = %orig; return r; }
+ (id)GetPathOfFileTempPath { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeBgImg { %log; id r = %orig; return r; }
+ (id)GetPathOfShakeBgImgTmp:(unsigned int)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfUsrShakeImg:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfLocalUsrDir { %log; id r = %orig; return r; }
+ (void)SetPathOfLocalUsrDir { %log; %orig; }
+ (id)GetPathOfLocalUsrDirAsync { %log; id r = %orig; return r; }
+ (id)GetPathOfUsrWCBKSetting { %log; id r = %orig; return r; }
+ (id)GetPathOfUsrChatBKSetting { %log; id r = %orig; return r; }
//+ (basic_string_90719d97)GetMd5StrOfUsr:(id)arg1 { %log; basic_string_90719d97 r = %orig; return r; }
+ (id)GetMd5StrsOfOtherUsrs { %log; id r = %orig; return r; }
//+ (basic_string_90719d97)GetMd5StrOfLocalUsr { %log; basic_string_90719d97 r = %orig; return r; }
+ (void)SetLocalUsrNameMD5:(id)arg1 { %log; %orig; }
+ (id)GetHttpEndData { %log; id r = %orig; return r; }
+ (char *)NewStrFromNSStr:(id)arg1 { %log; char * r = %orig; return r; }
+ (id)getMd5:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetRandomMD5 { %log; id r = %orig; return r; }
+ (const void *)computeKey:(id)arg1 fromString:(id)arg2 { %log; const void * r = %orig; return r; }
+ (unsigned int)GenSeq { %log; unsigned int r = %orig; return r; }
+ (unsigned int)GenID { %log; unsigned int r = %orig; return r; }
+ (long long)GetNetWorkReachable { %log; long long r = %orig; return r; }
+ (id)GetRandomKeyWithSalt:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetRandomKey { %log; id r = %orig; return r; }
+ (id)GetRandomUUID { %log; id r = %orig; return r; }
+ (void)Initial { %log; %orig; }
+ (id)obfuscate:(id)arg1 withKey:(id)arg2 { %log; id r = %orig; return r; }
+ (id)GetUUIDNew { %log; id r = %orig; return r; }
+ (_Bool)checkIsHttpUrl:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)IsNotBackupPath:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (_Bool)SetDoNotBackupForPath:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (id)hashForString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)hashPathForString:(id)arg1 { %log; id r = %orig; return r; }
+ (id)GetPathOfJSApiLocalDataFile:(id)arg1 CurrentUrl:(id)arg2 { %log; id r = %orig; return r; }
+ (id)NSStringToUTF8Hex:(id)arg1 { %log; id r = %orig; return r; }
+ (id)genWebpUrlWithOriUrl:(id)arg1 { %log; id r = %orig; return r; }
+ (_Bool)isNeedUseWebpFormatUrl:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (id)GetKeyValueFromPB:(id)arg1 { %log; id r = %orig; return r; }
+ (void)ClearAllWebViewCookiesWithTryDelay:(_Bool)arg1 { %log; %orig; }
+ (int)DecodePack:(id)arg1 Output:(id)arg2 DESKey:(char *)arg3 KeyLen:(unsigned int)arg4 { %log; int r = %orig; return r; }
+ (id)GetMimeTypeByFileExt:(id)arg1 { %log; id r = %orig; return r; }
+ (id)getMinimizeIconNameByFileType:(int)arg1 { %log; id r = %orig; return r; }
+ (id)getIconNameByFileType:(int)arg1 iconSize:(int)arg2 { %log; id r = %orig; return r; }
+ (id)getIconNameByFileExt:(id)arg1 iconSize:(int)arg2 { %log; id r = %orig; return r; }
+ (id)getFavIconNameByFileExt:(id)arg1 { %log; id r = %orig; return r; }
+ (id)getFavIconImageByFileExt:(id)arg1 { %log; id r = %orig; return r; }
+ (int)getFileTypeByFileExt:(id)arg1 { %log; int r = %orig; return r; }
+ (id)getIconImageByFileExt:(id)arg1 iconSize:(int)arg2 { %log; id r = %orig; return r; }
+ (_Bool)CheckSyncMediaNote:(id)arg1 { %log; _Bool r = %orig; return r; }
+ (unsigned int)ChatNotifyC2S:(unsigned int)arg1 { %log; unsigned int r = %orig; return r; }
+ (unsigned int)ChatNotifyS2C:(unsigned int)arg1 { %log; unsigned int r = %orig; return r; }
+ (unsigned int)CheckUsrNameType:(id)arg1 { %log; unsigned int r = %orig; return r; }
+ (id)TransformPath:(id)arg1 { %log; id r = %orig; return r; }
%end

//
//%hook NSFileManager
//- (BOOL)isReadableFileAtPath:(NSString *)path{
//    return %orig;
//}
//- (BOOL)isWritableFileAtPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//- (BOOL)isExecutableFileAtPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//- (BOOL)isDeletableFileAtPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//
//- (BOOL)isUbiquitousItemAtURL:(NSURL *)url{
//    if (isJailbreakPath(url.absoluteString)) {
//        CCLog(@"检测了:%@", url.absoluteString);
//        return false;
//    }
//    return %orig;
//}
//
//- (BOOL)fileExistsAtPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        if (strstr(path.UTF8String, "/private/var/lib/apt/")) {
//            CCLog(@"检测了:%@", path);
//        }
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//
//- (BOOL)getFileSystemRepresentation:(void *)arg1 maxLength:(long long)arg2 withPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return false;
//    }
//    return %orig;
//}
//
//- (NSData *)contentsAtPath:(NSString *)path{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return nil;
//    }
//    return %orig;
//}
//
//- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
//    if (isJailbreakPath(path)) {
//        CCLog(@"检测了:%@", path);
//        return nil;
//    }
//    return %orig;
//}
//
//- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error{
//    if ([path hasPrefix:@"/private"]){
//        if (error != nil) {
//            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:513 userInfo:@{}];
//        }
//        CCLog(@"检测了文件权限 removeItemAtPath: %@", path);
//        
//        return false;
//    }
//    if (![path hasPrefix:@"/var/mobile/Containers/Data/Application"]){
//        [CCLogManager addLog:[NSString stringWithFormat:@"[文件名:CCObject-C.xm][类名:NSFileManager][方法名:removeItemAtPath:%@]检测了 文件权限", path]];
//        [CCLogManager addWriteFilePath:path];
//    }
//    return %orig;
//}
//
//%end



%hook ExptService
- (void)setHadLoadedExpt:(_Bool )hadLoadedExpt { %log; %orig; }
- (_Bool )hadLoadedExpt { %log; _Bool  r = %orig; return r; }
- (void)setExptKeyMap:(NSMutableDictionary *)exptKeyMap { %log; %orig; }
- (NSMutableDictionary *)exptKeyMap { %log; NSMutableDictionary * r = %orig; return r; }
- (void)setExptItemMap:(NSMutableDictionary *)exptItemMap { %log; %orig; }
- (NSMutableDictionary *)exptItemMap { %log; NSMutableDictionary * r = %orig; return r; }
- (id)mmExptPath:(id)arg1 { %log; id r = %orig; return r; }
- (_Bool)checkNeedDelAllExpt:(unsigned int)arg1 { %log; _Bool r = %orig; return r; }
- (void)onGotSvrExptList:(id)arg1 deleteExptIds:(id)arg2 andExptFlag:(unsigned int)arg3 andAppIdList:(id)arg4 { %log; %orig; }
- (void)getLocalExptList:(id)arg1 { %log; %orig; }
- (void)tryToSaveExpt { %log; %orig; }
- (void)tryToLoadExpt { %log; %orig; }
- (void)OnGetNewXmlMsg:(id)arg1 Type:(id)arg2 MsgWrap:(id)arg3 { %log; %orig; }
- (void)willEnterForeground { %log; %orig; }
- (void)getSvrExptByManulLogin { %log; %orig; }
- (void)onManulLoginOK { %log; %orig; }
- (void)onAuthOK { %log; %orig; }
- (void)onAuthOKWithVersionChangeFrom:(unsigned int)arg1 to:(unsigned int)arg2 { %log; %orig; }
- (void)getSvrExpt { %log; %orig; }
- (void)dealloc { %log; %orig; }
- (void)onServiceReloadData { %log; %orig; }
- (void)onServiceInit { %log; %orig; }
- (id)getAllExpt { %log; id r = %orig; return r; }
- (id)getExpt:(id)arg1 withDef:(id)arg2 { %log; id r = %orig; return r; }
- (_Bool)getExpt:(id)arg1 withBoolDef:(_Bool)arg2 { %log; _Bool r = %orig; return r; }
%end
