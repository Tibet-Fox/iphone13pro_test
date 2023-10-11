import json
import random
import pickle
import numpy as np
from langchain.tools import BaseTool

JSON_PATH = 'sensor_response_data.json'
MODEL_PATH = 'chatbot/sentence_transformer_model.pkl'

class PlantSensor(BaseTool):
    name = "Plant_For_Sensor"
    description = """It is a good tool to use when receiving sensor values and asking the condition of the plant, and the answer is printed as it is, and an example of the question is as follows. Sanseveria, how are you now?"""

    def _run(self, query: str) -> str:
        return get_response(query)
    
    async def _arun(self, query: str) -> str:
        raise NotImplementedError("질문에 답할 수 없어요.")

with open(JSON_PATH, 'r', encoding='utf-8') as f:
    data = json.load(f)

with open(MODEL_PATH, 'rb') as f:
    model = pickle.load(f)


def get_response(query):
    
    def get_most_similar_question(query):
        query_embedding = model.encode(query)
        similarities = {}
        for plant_name in data['plants'].keys():
            plant_embedding = model.encode(plant_name)
            similarity = np.dot(query_embedding, plant_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(plant_embedding))
            similarities[plant_name] = similarity
        most_similar_plant = max(similarities, key=similarities.get)
        return most_similar_plant
        
    
    current_conditions = {"temperature": 5, "humidity": 50, "illumination": 100, "moisture": 20}
    responses = data["plants"].get(get_most_similar_question(query), {}).get("environment_responses", [])
    
    valid_responses = []
    for response in responses:
        conditions = response["conditions"]
        is_valid = all(
            conditions[condition]["low"] <= current_conditions[condition] <= conditions[condition]["high"]
            for condition in conditions
        )
        if is_valid:
            valid_responses.extend(response["response"].values())
    
    if valid_responses:
        chosen_response = random.choice(valid_responses)
        for condition, value in current_conditions.items():
            chosen_response = chosen_response.replace(f"${{{condition}}}", str(value))
        return chosen_response
    
    return "지금은 응답을 해드릴 수 없어요."

# Usage example
response = get_response('산세베리아야')
print(response)
