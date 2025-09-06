from flask import Flask, request, jsonify
import pandas as pd
import joblib
import json
import warnings

warnings.filterwarnings("ignore", category=UserWarning)

# Load models
bernoulli_model = joblib.load('bernoulli_nb.pkl')
multinomial_model = joblib.load('multinomial_nb.pkl')

# Load features
with open('features.json', 'r') as f:
    features = json.load(f)

# Init app
app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    input_df = pd.DataFrame(0, index=[0], columns=features)
    for symptom in data:
        if symptom in input_df.columns:
            input_df.at[0, symptom] = 1

    bern_pred = bernoulli_model.predict(input_df)[0]
    multi_pred = multinomial_model.predict(input_df)[0]

    bern_conf = bernoulli_model.predict_proba(input_df).max()
    multi_conf = multinomial_model.predict_proba(input_df).max()

    return jsonify({
        "bernoulli_nb": {"prediction": bern_pred, "confidence": round(float(bern_conf), 3)},
        "multinomial_nb": {"prediction": multi_pred, "confidence": round(float(multi_conf), 3)}
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
