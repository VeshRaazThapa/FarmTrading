import pymongo
from flask import Flask, request, jsonify


def connect_to_mongodb(uri):
    try:
        client = pymongo.MongoClient(uri)
        return client
    except pymongo.errors.ConnectionFailure as e:
        print("Could not connect to MongoDB: ", e)
        return None


def get_carts_data_with_user_id_filter(client, database_name, collection_name, user_id):
    if not client:
        return None

    db = client[database_name]
    collection = db[collection_name]

    filter_query = {"userId": user_id}

    try:
        carts_data = collection.find(filter_query)
        return list(carts_data)
    except pymongo.errors.PyMongoError as e:
        print("Error while querying MongoDB: ", e)
        return None


import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Read the data
movies = pd.read_csv('products.csv', sep=',', encoding='latin-1',
                     usecols=['product_name', 'category', 'quantity', 'farmer_id'])

# Convert category to a string with space-separated values
movies['category'] = movies['category'].str.split('|')
movies['category'] = movies['category'].fillna("").astype('str')

# Define the TF-IDF vectorizer for category similarity
tf_category = TfidfVectorizer(analyzer='word', ngram_range=(1, 2), min_df=0, stop_words='english')
tfidf_matrix_category = tf_category.fit_transform(movies['category'])

# Create a dictionary to map farmer_id to the corresponding category vector
farmer_category_dict = {}
for _, row in movies.iterrows():
    farmer_id = row['farmer_id']
    if farmer_id not in farmer_category_dict:
        farmer_category_dict[farmer_id] = row['category']


# Function to compute the farmer similarity for a given product's category
def compute_farmer_similarity(product_category):
    tfidf_matrix_farmer = tf_category.transform([product_category])
    return cosine_similarity(tfidf_matrix_category, tfidf_matrix_farmer).flatten()


# Function to compute the category similarity between products
def compute_category_similarity():
    return cosine_similarity(tfidf_matrix_category, tfidf_matrix_category)


# Combine the similarity matrices (category and farmer) with weightage to prioritize farmer similarity
alpha = 0.7  # You can adjust this weightage as per your preference

cosine_sim_category = compute_category_similarity()
cosine_sim_combined = np.zeros(cosine_sim_category.shape)

for i in range(cosine_sim_category.shape[0]):
    product_category = movies['category'][i]
    farmer_similarity = compute_farmer_similarity(product_category)
    cosine_sim_combined[i] = (alpha * cosine_sim_category[i]) + ((1 - alpha) * farmer_similarity)


# Function to get product recommendations based on category and farmer similarity
def product_recommendations(product_name):
    idx = movies.index[movies['product_name'] == product_name].tolist()[0]
    sim_scores = list(enumerate(cosine_sim_combined[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:21]
    movie_indices = [i[0] for i in sim_scores]
    return movies.iloc[movie_indices]


# Example usage: Get product recommendations for 'Potato'
# recs = product_recommendations('Potato')
# print(recs[['product_name', 'category', 'farmer_id']])

# Rest of the code remains the same...
# Set up the Flask app
app = Flask(__name__)


# Define the API endpoint
@app.route('/recommend_products', methods=['GET'])
def recommend_products():
    product_title = request.args.get('product_title')
    if not product_title:
        return jsonify({"error": "Product title not provided."}), 400

    recommended_ids = product_recommendations(product_title)
    print(recommended_ids)
    print('------')
    # Convert the DataFrame to a JSON serializable format (list of dictionaries)
    # recommended_products = movies.loc[movies['farmer_id'].isin(recommended_ids)][['product_name', 'farmer_id']].to_dict(orient='records')

    return jsonify({"recommended_products": recommended_ids.to_dict()})
    # return jsonify({"recommended_product_ids": recommended_ids})


# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)

if __name__ == "__main__":
    # Replace 'YOUR_MONGODB_URI' with your actual MongoDB URI/link
    # mongodb_uri = "YOUR_MONGODB_URI"
    # var
    mongodb_uri = "mongodb+srv://thapahimal777:xpF.8!2_D7jJUUc@cluster0.irrztq5.mongodb.net/?retryWrites=true&w=majority"

    database_name = "test"
    collection_name = "carts"
    user_id_to_filter = "6452246a16a29bf876fb22b6"

    # Connect to MongoDB
    mongo_client = connect_to_mongodb(mongodb_uri)

    if mongo_client:
        # Fetch carts table data with the user id filter
        carts_data = get_carts_data_with_user_id_filter(mongo_client, database_name, collection_name, user_id_to_filter)

        if carts_data:
            print("Carts data with user ID filter:")
            for cart in carts_data:
                print(cart)
        else:
            print("No carts data found with the given user ID.")

        # Close the connection to MongoDB
        mongo_client.close()
