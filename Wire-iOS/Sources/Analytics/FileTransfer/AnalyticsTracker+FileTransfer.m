// 
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
// 


#import "AnalyticsTracker+FileTransfer.h"
#import "DefaultIntegerClusterizer.h"

NSString * const AnalyticsFileSizeBytesKey = @"size_bytes";
NSString * const AnalyticsFileSizeMegabytesey = @"size_mb";


FOUNDATION_EXPORT NSString *FileTransferContextToNSString(FileTransferContext context);

FOUNDATION_EXPORT NSString *FileTransferContextToNSString(FileTransferContext context)
{
    switch (context) {
        case FileTransferContextApp:
            return @"app";
            break;
        case FileTransferContextShareExtension:
            return @"share_extension";
            break;
    }
    
    return @"";
}

@implementation AnalyticsTracker (FileTransfer)

- (void)tagCannotUploadFileSizeExceedsWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.attempted_too_big_file_upload"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

- (void)tagInitiatedFileUploadWithSize:(unsigned long long)size fileExtension:(NSString *)extension context:(FileTransferContext)context
{
    [self tagEvent:@"file.initiated_file_upload"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension,
                     @"context": FileTransferContextToNSString(context)}];
}

- (void)tagCancelledFileUploadWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.cancelled_file_upload"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

- (void)tagSucceededFileUploadWithSize:(unsigned long long)size fileExtension:(NSString *)extension duration:(NSTimeInterval)duration
{
    [self tagEvent:@"file.successfully_uploaded_file"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension,
                     @"time": [NSString stringWithFormat:@"%.02f", duration]}];
}

- (void)tagFailedFileUploadWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.failed_file_upload"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

- (void)tagInitiatedFileDownloadWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.initiated_file_download"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

- (void)tagSuccededFileDownloadWithSize:(unsigned long long)size fileExtension:(NSString *)extension duration:(NSTimeInterval)duration
{
    [self tagEvent:@"file.failed_file_download"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension,
                     @"time": [NSString stringWithFormat:@"%.02f", duration]}];
}

- (void)tagFailedFileDownloadWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.successfully_downloaded_file"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

- (void)tagOpenedFileWithSize:(unsigned long long)size fileExtension:(NSString *)extension
{
    [self tagEvent:@"file.opened_preview"
        attributes:@{AnalyticsFileSizeBytesKey: [NSString stringWithFormat:@"%llu", size],
                     AnalyticsFileSizeMegabytesey: [[DefaultIntegerClusterizer fileSizeClusterizer] clusterizeInteger:(int)roundf(((float)size) / (1024.0 * 1024.0))],
                     @"type": extension}];
}

@end
