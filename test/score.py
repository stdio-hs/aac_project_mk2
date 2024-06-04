from sklearn.metrics import f1_score
# from back_end.category_ai import *
import json
from sklearn.model_selection import train_test_split
import tensorflow as tf
import pandas as pd
import numpy as np
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.preprocessing.text import Tokenizer



import sys
import os

# 현재 파일의 디렉터리 경로를 sys.path에 추가
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)
sys.path.append(parent_dir)

from back_end.category_ai import Classifier

FILE_PATH = './'
# FILE_NAME = 'new_korean_intence.json'
FILE_NAME = 'test_data.json'
MODEL_FILE = 'C:/Users/yangs/aac_project_mk2/back_end/model/'

with open(FILE_PATH + FILE_NAME, 'r', encoding='UTF-8') as f:
    json_data = json.load(f)

# 데이터 준비
test_sentences = []
test_labels = []

# 데이터와 라벨 추출
for intent in json_data['intence']:
    for pattern in intent['patterns']:
        test_sentences.append(pattern)
        test_labels.append(intent['tag'])

# model = tf.keras.models.load_model(MODEL_FILE)

classifier = Classifier()
# test_texts = ['테스트 문장1', '테스트 문장2', ...]
# test_labels = ['label1', 'label2', ...]
f1 = classifier.evaluate_model(test_sentences, test_labels)
print(f'F1 Score: {f1}')

