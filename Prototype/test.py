import numpy as np
import os
import cv2 as cv
import json
import image_analyzer as im


def get_metrics(func_name, measure, result):
    metrics = [switch(func_name), {"image quality": measure, "result": result}]

    return metrics


def switch(x):
    return {
        "is_sharp": "image sharpness rating",
        "is_contrast": "image bright contrast rating"
    }.get(x, "")


if __name__ == "__main__":
    path = "path/to/your/folder"
    d = {}
    ratings = []
    for filename in os.listdir(path):
        if filename.endswith((".jpg", ".png", ".jpeg")):
            img = cv.imread(os.path.join(path, filename))[:, :, ::-1]
            gr_img = np.dot(img[..., :3], [0.2989, 0.5870, 0.1140])

            img_quality1 = im.sharpness(gr_img)
            res1 = im.is_sharp(img_quality1, 0.16)
            ratings.append(get_metrics(im.is_sharp.__name__, img_quality1, res1))

            img_quality2 = im.bright_contrast(gr_img)
            res2 = im.is_contrast(img_quality2, 0.46, 0.14)
            ratings.append(get_metrics(im.is_contrast.__name__, img_quality2, res2))

            res = res1 and res2
            ratings.append(["final result", res])
            d[filename] = dict(ratings)
            ratings.clear()

    with open(os.path.join(path, 'data.json'), 'w') as outfile:
        json.dump(d, outfile, indent=4)
