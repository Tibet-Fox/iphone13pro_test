# from sentence_transformers import SentenceTransformer
# model = SentenceTransformer('jhgan/ko-sroberta-multitask')
from django.shortcuts import render
from django.http import JsonResponse
import pickle
import numpy as np
import json
import random

MODEL_PATH = 'chatbot/sentence_transformer_model.pkl'
JSON_PATH = 'chatbot/embedding_data.json'

with open(MODEL_PATH, 'rb') as f:
     model = pickle.load(f)

# JSON 데이터 로딩
with open(JSON_PATH, 'r') as f:
    data = json.load(f)

def get_most_similar_question(query):
    # 사용자로부터 입력 받은 질문을 임베딩
    query_embedding = model.encode(query)
    similarities = []

    # 질문에 대해 임베딩을 생성하고 쿼리와의 유사도를 계산
    for question in data.keys():
        question_embedding = model.encode(question)
        # 코사인 유사도 계산식
        similarity = np.dot(query_embedding, question_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(question_embedding))
        similarities.append(similarity)

    # 가장 유사한 질문의 인덱스를 찾음
    most_similar_idx = np.argmax(similarities)
    return list(data.keys())[most_similar_idx]

def get_response(query):
    # 고정된 센서 값
    sensor_values = {
        '${l}': 40000, # 조도 (나옴)
        '${t}': 25, # 온도 (나옴)
        '${h}': 40, # 습도 (나오면 안됨)
        '${m}': 60 # 수분 (나오면 안됨)
    }

    # 센서 값에 따른 임계값
    thresholds = {
        '${l}': 45000,
        '${t}': 30,
        '${h}': 30,
        '${m}': 50
    }

    # 가장 유사한 질문을 가져옴
    most_similar_question = get_most_similar_question(query)
    responses = data[most_similar_question]

    # 해당 질문에 대한 응답 중 하나를 무작위로 선택
    response = random.choice(responses)
    response_text = list(response.values())[0]

    # 센서 값의 임계값을 기준으로 응답을 수정하거나 다시 선택
    for literal, threshold in thresholds.items():
        if literal in response_text:
            # 센서 값으로 템플릿 리터럴 대체
            response_text = response_text.replace(literal, str(sensor_values[literal]))

            if sensor_values[literal] > threshold:
                # 다른 응답을 선택
                responses_without_literal = [resp for resp in responses if literal not in list(resp.values())[0]]
                chosen_response = random.choice(responses_without_literal)
                response_text = list(chosen_response.values())[0]
                # 이전에 대체된 템플릿 리터럴 대체를 다시 반복
                for lit, value in sensor_values.items():
                    if lit in response_text:
                        response_text = response_text.replace(lit, str(value))

    return response_text

def ask(request):
    if request.method == "GET":
        question = request.GET.get("question")
        if question:
            answer = get_response(question)
            return JsonResponse({"answer": answer})
        else:
            return render(request, "ask.html")
