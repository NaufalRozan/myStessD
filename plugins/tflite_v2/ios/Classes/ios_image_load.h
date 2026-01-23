#ifndef IOS_IMAGE_LOAD_H
#define IOS_IMAGE_LOAD_H

#ifdef __cplusplus
#include <vector>

std::vector<uint8_t> LoadImageFromFile(const char* file_name,
						 int* out_width,
						 int* out_height,
						 int* out_channels);
#endif

#import <Foundation/Foundation.h>

NSData *CompressImage(NSMutableData*,
						 int width,
						 int height,
             int bytesPerPixel);

#endif // IOS_IMAGE_LOAD_H