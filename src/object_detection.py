import os

from dotenv import load_dotenv
import supervision as sv
from inference import get_model

# setup
load_dotenv()
api_key = os.getenv('ROBOFLOW_API_KEY')
model_id = os.getenv('ROBOFLOW_MODEL_ID')

# get the inference model
model = get_model(model_id, api_key)

# create supervision annotators
box_annotator = sv.BoxAnnotator()
label_annotator = sv.LabelAnnotator()

def draw_annotations(frame, results):
    # extract detections
    detections = sv.Detections.from_inference(results)

    annotated_frame = box_annotator.annotate(scene=frame, detections=detections)
    annotated_frame = label_annotator.annotate(scene=annotated_frame, detections=detections)

    return annotated_frame

def run(img):
    # object detection
    results = model.infer(image=img)[0]
    predictions = results.predictions
    annotated_frame = draw_annotations(img, results)

    return results, predictions, annotated_frame
