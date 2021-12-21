#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "EpubViewerPlugin.h"

FOUNDATION_EXPORT double epub_viewerVersionNumber;
FOUNDATION_EXPORT const unsigned char epub_viewerVersionString[];

