import numpy as np


def sharpness(image):
    size = image.shape
    fft_img = abs(np.fft.fftshift(np.fft.fft2(image)))
    thres = np.amax(fft_img) * 1.5 / 10000
    count = 0

    for i in range(size[0]):
        for j in range(size[1]):
            if fft_img[i][j] >= thres:
                count += 1
    image_quality = count / (size[0] * size[1])

    return image_quality


def bright_contrast(image):
    y = np.mean(image)
    y_max = 255
    sigma = np.mean((image - y) ** 2)
    image_quality = 2 * (sigma ** 0.5) / y_max

    return image_quality


def is_sharp(image_quality, criterion):
    if image_quality >= criterion:
        result = True
    else:
        result = False

    return result


def is_contrast(image_quality, point, radius):
    if abs(image_quality - point) <= radius:
        result = True
    else:
        result = False

    return result


def analyze(image, sharpness_criterion=0.16, contrast_point=0.46, contrast_radius=0.14):
    gray_img = np.dot(image[..., :3], [0.2989, 0.5870, 0.1140])
    sharpness_measure = is_sharp(sharpness(gray_img), sharpness_criterion)
    contrast_measure = is_contrast(bright_contrast(gray_img), contrast_point, contrast_radius)
    result = sharpness_measure and contrast_measure

    return result
