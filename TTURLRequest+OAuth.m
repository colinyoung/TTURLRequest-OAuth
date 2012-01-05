#import "TTURLRequest+OAuth.h"
#import "RandomString.h"

#define kDefaultNonceLength 20

@implementation TTURLRequest (OAuth)

-(void)oauthifyWithConsumerKey:(NSString *)consumerKey
                         token:(NSString *)token
               signatureMethod:(TTURLRequestOAuthSignatureMethod)signatureMethod
                       version:(NSString *)version {
    
    [self.headers setObject:consumerKey forKey:@"oauth_consumer_key"];
    if (token) [self.headers setObject:token forKey:@"oauth_token"];
    [self.headers setObject:[[self class] stringForSignatureMethod:signatureMethod] forKey:@"oauth_signature_method"];
    [self.headers setObject:[NSString stringWithFormat:@"%d", [[NSDate date] timeIntervalSince1970]] forKey:@"oauth_timestamp"];
    [self.headers setObject:[[self class] nonce:kDefaultNonceLength] forKey:@"oauth_nonce"];
    if (version) [self.headers setObject:version forKey:@"oauth_version"];
}

#pragma mark - Private
+(NSString *)stringForSignatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod {
    switch (_signatureMethod) {
        case TTURLRequestOAuthSignatureMethodHMAC:
            return @"HMAC-SHA1";
            break;
            
        case TTURLRequestOAuthSignatureMethodRSA:
            return @"RSA-SHA1";
            break;
            
        case TTURLRequestOAuthSignatureMethodPlaintext:
        default:
            return @"PLAINTEXT";
    }
    return @"Plaintext";
}
     
+(NSString *)nonce:(int)length {
    NSString *nonce = [[[NSString alloc] initWithCString:randomStringOfLength(length) encoding:NSUTF8StringEncoding] autorelease];
    return nonce;
}

@end
