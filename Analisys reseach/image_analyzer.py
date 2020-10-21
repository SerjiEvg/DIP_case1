import numpy as np
import cv2 as cv
import os
import json


def sharpness(image):
    gray_img = np.dot(image[..., :3], [0.2989, 0.5870, 0.1140])
    size = gray_img.shape
    fft_img = abs(np.fft.fftshift(np.fft.fft2(gray_img)))
    thres = np.amax(fft_img) / 10000
    count = 0

    for i in range(size[0]):
        for j in range(size[1]):
            if fft_img[i][j] >= thres:
                count += 1
    image_quality = count / (size[0] * size[1])

    return image_quality


def is_sharp(image_quality, criterion):
    if image_quality >= criterion:
        result = True
    else:
        result = False

    return result


def get_metrics(func_name, measure, result):
    metrics = {"type of rating": switch(func_name), "image quality": measure, "result": result}

    return metrics


def switch(x):
   return {
      "is_sharp": "image sharpness rating"
   }.get(x, "")


if __name__ == "__main__":
    folder = "C:/Users/lenovo/Documents/GitHub/DIP_case1/DataSet/Blurred"
    d = {}
    for filename in os.listdir(folder):
        img = cv.imread(os.path.join(folder, filename))[:, :, ::-1]
        img_quality = sharpness(img)
        res = is_sharp(img_quality, 0.2)
        d[filename] = get_metrics(is_sharp.__name__, img_quality, res)

    with open('data.json', 'w') as outfile:
        json.dump(d, outfile, indent=4)


