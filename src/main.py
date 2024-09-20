import cv2

from object_detection import run

WINDOW_NAME = "opencv webcam"

def run():
    cv2.namedWindow(WINDOW_NAME)

    video_capture = cv2.VideoCapture(0)

    while video_capture.isOpened():
        ret, frame = video_capture.read()

        results, detections, annotated_frame = object_detection.run(frame)

        print(f"Predictions : {detections}")

        cv2.imshow(WINDOW_NAME, annotated_frame)
        
        if cv2.waitKey(1) == 27: 
            break  # esc to quit

    video_capture.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    run()
