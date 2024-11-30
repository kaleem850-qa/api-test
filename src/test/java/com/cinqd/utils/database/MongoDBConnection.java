package com.cinqd.utils.database;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.DeleteResult;
import org.bson.Document;

import java.util.List;

public class MongoDBConnection {

    private MongoClient mongoClient;
    private MongoDatabase database;
    Document filter;

    // Constructor to initialize MongoDB connection
    public MongoDBConnection(String connectionString, String databaseName) {
        mongoClient = MongoClients.create(connectionString);
        database = mongoClient.getDatabase(databaseName);
        System.out.println("Connected to MongoDB database: " + databaseName);
    }

    public MongoCollection<Document> getCollection(String collectionName) {
        return database.getCollection(collectionName);
    }

    public boolean deleteRecord(String collection, String uniqueKEY) {
        if (collection.contains("users")){
            filter = new Document("Email", uniqueKEY);
        } else if (collection.contains("businesses")){
            filter = new Document("generalInformation.businessName", uniqueKEY);
        }
        DeleteResult flag = getCollection(collection).deleteOne(filter);
        return flag.wasAcknowledged();
    }

    public List<Document> findAllDocuments(String collectionName) {
        MongoCollection<Document> collection = getCollection(collectionName);
        return collection.find().into(new java.util.ArrayList<>());
    }

    public void close() {
        if (mongoClient != null) {
            mongoClient.close();
            System.out.println("MongoDB connection closed.");
        }
    }
}
