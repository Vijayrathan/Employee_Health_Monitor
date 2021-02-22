from flask import Flask, request, json, Response
from pymongo import MongoClient
import logging as log

app = Flask(__name__)


class MongoAPI:
    def __init__(self, data):
        log.basicConfig(level=log.DEBUG, format='%(asctime)s %(levelname)s:\n%(message)s\n')
        self.client = MongoClient("mongodb://localhost:27017/")
        database = data['database']
        collection = data['collection']
        cursor = self.client[database]
        self.collection = cursor[collection]
        self.data = data

    def read(self):
        log.info('Reading All Data')
        documents = self.collection.find()
        output = [{item: data[item] for item in data if item != '_id'} for data in documents]
        return output

    def write(self, data):
        log.info('Writing Data')
        new_document = data['Document']
        response = self.collection.insert_one(new_document)
        output = {'Status': 'Successfully Inserted',
                  'Document_ID': str(response.inserted_id)}
        return output

    def update(self):
        log.info('Updating Data')
        filt = self.data['Filter']
        updated_data = {"$set": self.data['DataToBeUpdated']}
        response = self.collection.update_one(filt, updated_data)
        output = {'Status': 'Successfully Updated' if response.modified_count > 0 else "Nothing was updated."}
        return output

    def delete(self, data):
        log.info('Deleting Data')
        filt = data['Filter']
        response = self.collection.delete_one(filt)
        output = {'Status': 'Successfully Deleted' if response.deleted_count > 0 else "Document not found."}
        return output


@app.route('/')
def base():
    return Response(response=json.dumps({"Status": "UP"}),
                    status=200,
                    mimetype='application/json')


@app.route('/post/<int:emp_id>', methods=['GET'])
def get_employee_data(emp_id):
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_health"
                          })

    documents = obj1.collection.find({"emp_id": emp_id})
    output = [{item: data[item] for item in data if item != '_id'} for data in documents]

    return Response(response=json.dumps(output),
                    status=200,
                    mimetype='application/json')


@app.route('/post/<int:emp_id>/latest', methods=['GET'])
def get_employee_data_latest(emp_id):
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_health"
                          })

    documents = obj1.collection.find({"emp_id": emp_id}).sort([("_id", -1)]).limit(1)
    output = [{item: data[item] for item in data if item != '_id'} for data in documents]

    return Response(response=json.dumps(output),
                    status=200,
                    mimetype='application/json')


@app.route('/mongodb/sorted', methods=['GET'])
def mongo_read_sorted():
    # data = request.json
    # if data is None or data == {}:
    # return Response(response=json.dumps({"Error": "Please provide connection information"}),
    # status=400,
    # mimetype='application/json')
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_health"
                          })
    response = obj1.collection.find().sort([("_id", -1)]).limit(100)
    output = [{item: data[item] for item in data if item != '_id'} for data in response]
    return Response(response=json.dumps(output),
                    status=200,
                    mimetype='application/json')


@app.route('/mongodb', methods=['GET'])
def mongo_read():
    # data = request.json
    # if data is None or data == {}:
    # return Response(response=json.dumps({"Error": "Please provide connection information"}),
    # status=400,
    # mimetype='application/json')
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_health"
                          })
    response = obj1.read()
    return Response(response=json.dumps(response),
                    status=200,
                    mimetype='application/json')


@app.route('/post/login', methods=['GET'])
def get_login_check():
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_ids"
                          })

    documents = obj1.collection.find()
    output = [{item: data[item] for item in data if item != '_id'} for data in documents]

    return Response(response=json.dumps(output),
                    status=200,
                    mimetype='application/json')


@app.route('/mongodb/write', methods=['POST'])
def mongo_write():
    data = request.json
    if data is None or data == {} or 'Document' not in data:
        return Response(response=json.dumps({"Error": "Please provide connection information"}),
                        status=400,
                        mimetype='application/json')
    obj1 = MongoAPI(data={"database": "database",
                          "collection": "employee_health"
                          })
    response = obj1.write()
    return Response(response=json.dumps(response),
                    status=200,
                    mimetype='application/json')


if __name__ == '__main__':
    app.run(debug=True, port=5001, host='localhost')
