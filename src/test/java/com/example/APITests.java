package com.example;

import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;

public class APITests {

    Response response;
    String uri;
    String baseUrl;
    String body;
    Scenario scenario;

    @Before
    public void setUp(Scenario scenario){
        baseUrl = "https://reqres.in";
        this.scenario = scenario;
    }

    @Given("user has an endpoint {string}")
    public void userHasAnEndpoint(String endPoint) {
        uri = baseUrl + endPoint;
    }

    @When("user makes a get request")
    public void userMakesAGetRequest() {
        response = RestAssured.given().get(uri);
    }

    @Then("user sees {int} response code")
    public void userSeesResponseCode(int resCode) {
        response.then().statusCode(resCode);
    }

    @And("body is {string}")
    public void bodyIsNameMorpheusJobLeader(String body) {
        this.body = body;
    }

    @When("user makes a post request")
    public void userMakesAPostRequest() {
        response = RestAssured.given().body(body).post(uri);
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @When("user makes a put request")
    public void userMakesAPutRequest() {
        response = RestAssured.given().body(body).put(uri);
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }
}
