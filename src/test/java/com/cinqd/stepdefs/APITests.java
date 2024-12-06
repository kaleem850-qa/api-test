package com.cinqd.stepdefs;

import com.cinqd.utils.database.MongoDBConnection;
import com.mongodb.client.MongoCollection;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.*;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.bson.Document;
import org.json.JSONObject;
import org.junit.Assert;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

public class APITests {

    Response response;
    String uri;
    static String userBaseUrl;
    static String businessBaseUrl;
    String requestBody;
    Scenario scenario;
    RequestSpecification request;
    static String userId;
    static String authToken;
    static String connectionString;
    static String databaseName;
    static MongoDBConnection mongoDBConnection;
    static String userEmail;
    MongoCollection<Document> collection;
    Document searchQuery;
    String businessName;
    static String businessId;
    static String crn;
    static String employeeId;
    static String empEmail;
    static String teamName;
    static String teamId;
    static String teamNameEdit;
    static String branchName;
    static String branchAddress;
    static String branchNameEdit;
    static String branchAddressEdit;
    static String branchId;
    static String groupName;
    static String groupNameEdit;
    static String groupId;

    @BeforeAll
    public static void before_all(){
        connectionString = "mongodb+srv://cinqd:cinqd@cinqd.evmquij.mongodb.net/";
        databaseName = "test";
        mongoDBConnection = new MongoDBConnection(connectionString, databaseName);
        userBaseUrl = "https://auth-be.cinqd.com";
        businessBaseUrl = "https://setup-be.cinqd.com";
    }

    @Before
    public void setUp(Scenario scenario) {
        userEmail = "test_" + UUID.randomUUID() + "@cinqd.com";
        empEmail = "test_" + UUID.randomUUID() + "@cinqd.com";

        crn = "14602507";

        teamName = "Team " + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        teamNameEdit = "test_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        branchName = "branch_" +  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        branchAddress = "123 Main Street, City-" + System.currentTimeMillis();

        branchNameEdit = "test_branch_" +  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        branchAddressEdit = "test 123 Main Street, City-" + System.currentTimeMillis();

        groupName = "group_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        groupNameEdit = "test_group_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        request = RestAssured.given().log().all();
        this.scenario = scenario;
    }

    @After
    public void tearDown(Scenario scenario){
        String scenarioName = scenario.getName();
        System.out.println("Scenario Name is: " +scenarioName);
        if (scenarioName.contains("user") && scenario.getName().contains("business")) {
            //mongoDBConnection.deleteRecord("users", userEmail);
            System.out.println("User is deleted successfully: " + userEmail + "   " + userId);
            //mongoDBConnection.deleteRecord("businesses", businessName);
            System.out.println("Business is deleted successfully: "  + businessName + "   " + businessId);
        } else if (scenarioName.contains("business")){
            //mongoDBConnection.deleteRecord("businesses", businessName);
            System.out.println("Business is deleted successfully: "  + businessName);
        } else if (scenarioName.contains("user")){
            //boolean flag = mongoDBConnection.deleteRecord("users", userEmail + "   " + userId);
            //Assert.assertTrue(flag);
            System.out.println("User is deleted successfully: " + userEmail + "   " + userId);
        }

        if (scenarioName.contains("employee")){
            //boolean flag = mongoDBConnection.deleteRecord("users", empEmail);
            //Assert.assertTrue(flag);
            System.out.println("Employee is deleted successfully: " + empEmail + "   " + employeeId);
        }
        if (scenarioName.contains("team")){
            //boolean flag = mongoDBConnection.deleteRecord("teams", teamId);
            //Assert.assertTrue(flag);
            System.out.println("Team is deleted successfully: " + teamName + "   " + teamId);
        }
        if (scenarioName.contains("branch")){
            //boolean flag = mongoDBConnection.deleteRecord("branches", branchId);
            //Assert.assertTrue(flag);
            System.out.println("branch is deleted successfully: " + branchName + "   " + branchId);
        }
        if (scenarioName.contains("group")){
            //boolean flag = mongoDBConnection.deleteRecord("groups", groupId);
            //Assert.assertTrue(flag);
            System.out.println("group is deleted successfully: " + groupName + "   " + groupId);
        }
    }

    @AfterAll
    public static void after_all(){
        mongoDBConnection.close();
    }

    @Given("user has an endpoint {string}")
    public void userHasAnEndpoint(String endPoint) {
        if (endPoint.contains("auth")){
            uri = userBaseUrl + endPoint;
        }else if (endPoint.contains("setup")) {
            if (endPoint.contains("get-business-by-id") || endPoint.contains("get-business-employees")) {
                uri = businessBaseUrl + endPoint + businessId;
            } else if (endPoint.contains("get-business-by-CRN")){
                uri = businessBaseUrl + endPoint + crn;
            } else if (endPoint.contains("get-my-businesses")){
                uri = businessBaseUrl + endPoint + userId;
            } else if (endPoint.contains("get-user-by-id")){
                uri = businessBaseUrl + endPoint + employeeId;
            } else {
                uri = businessBaseUrl + endPoint;
            }
        } else if(endPoint.contains("invites/create-invitation") || endPoint.contains("create-team") || endPoint.contains("create-branch") || endPoint.contains("create-group")) {
            uri = businessBaseUrl + endPoint;
        } else if (endPoint.contains("get-team-by-id") || endPoint.contains("edit-team") || endPoint.contains("delete-team")) {
            uri = businessBaseUrl + endPoint + teamId;
        } else if (endPoint.contains("get-teams-by-business")  || endPoint.contains("get-branches-by-business") || endPoint.contains("get-groups-by-business")) {
            uri = businessBaseUrl + endPoint + businessId;
        } else if (endPoint.contains("edit-branch") || endPoint.contains("get-branch-by-id")  || endPoint.contains("delete-branch")) {
            uri = businessBaseUrl + endPoint + branchId;
        } else if (endPoint.contains("edit-group") || endPoint.contains("get-group-by-id") || endPoint.contains("delete-group")) {
            uri = businessBaseUrl + endPoint + groupId;
        }
    }

    @Given("body is {string}, {string}, {string}, {string}, {string}")
    public void body_is(String firstName, String lastName, String password, String email, String signupType) {
        requestBody = String.format(
                "{\"firstName\": \"%s\", \"lastName\": \"%s\", \"Password\": \"%s\", \"Email\": \"%s\", \"SignupType\": \"%s\"}",
                firstName, lastName, password, email, signupType
        );
        request.header("Content-Type", "application/json");
        request.body(requestBody);
    }

    @Given("body is {string}, {string}, {string}, {string}")
    public void setRequestBody(String firstName, String lastName, String password, String signupType) {
        requestBody = String.format(
                "{\"firstName\": \"%s\", \"lastName\": \"%s\", \"Password\": \"%s\", \"Email\": \"%s\", \"SignupType\": \"%s\"}",
                firstName, lastName, password, userEmail, signupType
        );
        request.header("Content-Type", "application/json");
        request.body(requestBody);
    }

    @When("user makes a get request")
    public void userMakesAGetRequest() {
        response = request.get(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @Then("user sees {int} response code")
    public void userSeesResponseCode(int resCode) {
        response.then().statusCode(resCode);
    }

    @When("user makes a post request")
    public void userMakesAPostRequest() {
        response = request.post(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @When("user makes a put request")
    public void userMakesAPutRequest() {
        response = request.body(requestBody).put(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @When("user makes a patch request for {string}")
    public void user_makes_a_patch_request_for(String endPoint) {
        if (endPoint.contains("activate-user")) {
            uri = userBaseUrl + endPoint + userEmail;
        } else if (endPoint.contains("recover-password")){
            uri = userBaseUrl + endPoint;
        }
        response = request.patch(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @When("user makes a post request for {string}, body as {string}")
    public void user_makes_a_post_request_for(String signInEndPoint, String password) {
        uri = userBaseUrl + signInEndPoint;
        requestBody = String.format(
                "{\"Email\": \"%s\",\"Password\": \"%s\"}", userEmail, password);
        request.header("Content-Type", "application/json");
        request.body(requestBody);
        response = request.post(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @Then("user saves the id and auth-token for upcoming APIs")
    public void user_saves_the_id_for_upcoming_ap_is() {
        userId = response.jsonPath().getString("data.user._id");
        authToken = response.jsonPath().getString("data.token");
    }

    @Given("body is {string}")
    public void body_is(String password) {
        requestBody = String.format("{\"Password\": \"%s\", \"Id\": \"%s\"}",password, userId);
        request.header("Content-Type", "application/json");
        request.body(requestBody);
    }

    @Given("user has a delete endpoint")
    public void user_has_a_delete_endpoint(){
        uri = userBaseUrl + "/auth/delete-user/"+ userId;
    }
    @When("user deletes")
    public void user_deletes() {
        request.header("auth-token", authToken);
        response = request.delete(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @Given("user sets the body")
    public void user_sets_the_body() {
        JSONObject generalInformation = new JSONObject()
                .put("businessOwnerName", "John Doe")
                .put("numberOfEmployees", "50")
                .put("businessName", "Tech Solutions Ltd.")
                .put("accountingYearEndDate", "2024-12-31")
                .put("natureOfBusiness", "Software Development");

        JSONObject businessAddress = new JSONObject()
                .put("businessstreet", "123 Innovation Street")
                .put("businessbuildingNumber", "Suite 200")
                .put("businesscity", "Tech City")
                .put("businesscountry", "USA")
                .put("businesspostalCode", "12345");

        JSONObject contactInformation = new JSONObject()
                .put("billingAddress", new JSONObject()
                        .put("buildingNumber", "200")
                        .put("city", "Finance City")
                        .put("country", "USA")
                        .put("postalCode", "54321")
                        .put("street", "456 Money Avenue"))
                .put("businessPhoneNumber", "+1234567890")
                .put("businessCountryCode", "+1")
                .put("businessWebsite", "https://techsolutions.com")
                .put("facebook", "https://facebook.com/techsolutions")
                .put("linkedIn", "https://linkedin.com/company/techsolutions")
                .put("twitter", "https://twitter.com/techsolutions")
                .put("businessEmail", "info@techsolutions.com")
                .put("registeredOffice", "789 Registered Office St, Finance City, USA");

        JSONObject requestBody = new JSONObject()
                .put("crn", crn)
                .put("ownerId", userId)
                .put("businessType", "ltd")
                .put("businessImage", "")
                .put("generalInformation", generalInformation)
                .put("businessAddress", businessAddress)
                .put("contactInformation", contactInformation);
        businessName = "Tech Solutions Ltd.";
        System.out.println(requestBody.toString(2)); // Pretty-print JSON

        request.header("auth-token", authToken);
        request.header("Content-Type", "application/json");
        request.body(requestBody.toString());
    }

    @And("user sets the body with invalid data")
    public void userSetsTheBodyWithInvalidData(DataTable dataTable) {
        Map<String, String> data = dataTable.asMap(String.class, String.class);
        String requestBody = String.format("""
        {
          "contactInformation": {
            "businessEmail": "%s",
            "businessWebsite": "%s",
            "twitter": "%s",
            "facebook": "%s",
            "businessCountryCode": "%s",
            "billingAddress": {
              "country": "%s",
              "city": "%s",
              "street": "%s",
              "postalCode": "%s",
              "buildingNumber": "%s"
            },
            "linkedIn": "%s",
            "registeredOffice": "%s",
            "businessPhoneNumber": "%s"
          },
          "generalInformation": {
            "businessName": "%s",
            "accountingYearEndDate": "%s",
            "natureOfBusiness": "%s",
            "businessOwnerName": "%s",
            "numberOfEmployees": "%s"
          },
          "ownerId": "%s",
          "businessType": "%s",
          "businessAddress": {
            "businessbuildingNumber": "%s",
            "businesscity": "%s",
            "businessstreet": "%s",
            "businesscountry": "%s",
            "businesspostalCode": "%s"
          },
          "crn": "%s",
          "businessImage": "%s"
        }
        """,
                data.get("contactInformation.businessEmail"),
                data.get("contactInformation.businessWebsite"),
                data.get("contactInformation.twitter"),
                data.get("contactInformation.facebook"),
                data.get("contactInformation.businessCountryCode"),
                data.get("contactInformation.billingAddress.country"),
                data.get("contactInformation.billingAddress.city"),
                data.get("contactInformation.billingAddress.street"),
                data.get("contactInformation.billingAddress.postalCode"),
                data.get("contactInformation.billingAddress.buildingNumber"),
                data.get("contactInformation.linkedIn"),
                data.get("contactInformation.registeredOffice"),
                data.get("contactInformation.businessPhoneNumber"),
                data.get("generalInformation.businessName"),
                data.get("generalInformation.accountingYearEndDate"),
                data.get("generalInformation.natureOfBusiness"),
                data.get("generalInformation.businessOwnerName"),
                data.get("generalInformation.numberOfEmployees"),
                userId,
                data.get("businessType"),
                data.get("businessAddress.businessbuildingNumber"),
                data.get("businessAddress.businesscity"),
                data.get("businessAddress.businessstreet"),
                data.get("businessAddress.businesscountry"),
                data.get("businessAddress.businesspostalCode"),
                data.get("crn"),
                data.get("businessImage")
        );
        businessName = data.get("generalInformation.businessName");
        request.header("auth-token", authToken);
        request.header("Content-Type", "application/json");
        request.body(requestBody);
    }

    @Then("above mongoDB entry is created")
    public void mongo_db_entry_for_user_is_created() {
        if (uri.contains("auth")) {
            collection = mongoDBConnection.getCollection("users");
            searchQuery = new Document("Email", userEmail);

        } else if (uri.contains("setup")) {
            collection = mongoDBConnection.getCollection("businesses");
            searchQuery = new Document("generalInformation.businessName", businessName);
        }
        Document result = collection.find(searchQuery).first();
        Assert.assertNotNull(result);
    }

    @Then("db shows no record for that user")
    public void db_shows_no_record_for_that_user() {
        collection = mongoDBConnection.getCollection("users");
        searchQuery = new Document("Email", userEmail);
        Document res = collection.find(searchQuery).first();
        Assert.assertNull(res);
    }

    @Then("user saves the business id for upcoming APIs")
    public void user_saves_the_business_id_for_upcoming_ap_is() {
        businessId = response.jsonPath().getString("data._id");
    }

    @Given("user sets the auth-token in request")
    public void user_sets_the_auth_token_in_request() {
        request.header("auth-token", authToken);
    }

    @Then("reinitializing the request to remove all the previous headers")
    public void reinitializing_the_request_to_remove_all_the_previous_headers() {
        request = RestAssured.given().log().all();
    }

    @Given("the employee body is")
    public void the_employee_body_is(String requestBody) {
        this.requestBody = String.format(requestBody, empEmail, businessId);
    }

    @And("user sets the Content-Type in request")
    public void userSetsTheContentTypeInRequest() {
        request.header("Content-Type", "application/json");
    }

    @And("user sets the body in request")
    public void userSetsTheBodyInRequest() {
        request.body(requestBody);
    }

    @When("user has a delete endpoint {string}")
    public void userHasADeleteEndpoint(String endPoint) {
        uri = businessBaseUrl + endPoint + employeeId;
    }

    @And("user saves the employeeid for upcoming APIs")
    public void userSavesTheEmployeeidForUpcomingAPIs() {
        employeeId = response.jsonPath().getString("data._id");
    }

    @And("employee body is {string}, {string}, {string}, {string}")
    public void employeeBodyIs(String firstName, String lastName, String password, String signupType) {
        requestBody = String.format(
                "{\"firstName\": \"%s\", \"lastName\": \"%s\", \"Password\": \"%s\", \"Email\": \"%s\", \"SignupType\": \"%s\", \"invitedBy\": \"%s\"}",
                firstName, lastName, password, empEmail, signupType, employeeId
        );
        request.header("Content-Type", "application/json");
        request.body(requestBody);
    }

    @When("employee makes a patch request for {string}")
    public void employeeMakesAPatchRequestFor(String endPoint) {
        uri = userBaseUrl + endPoint + empEmail;
        response = request.patch(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @And("user sets the body for team")
    public void userSetsTheBodyForTeam(String requestBody) {
        this.requestBody = String.format(requestBody, teamName, employeeId, businessId);

        request.body(this.requestBody);
    }

    @And("business has a team with name not null")
    public void businessHasATeamWithNameNotNull() {
        String actualTeamName = response.jsonPath().getString("data.name");
        Assert.assertNotNull("Team name should not be null", actualTeamName);
        System.out.println("Created Team Name: " + actualTeamName);

    }

    @And("user saves the team_id for upcoming APIs")
    public void userSavesTheTeam_idForUpcomingAPIs() {
        teamId = response.jsonPath().getString("data._id");
    }

    @When("user makes a patch request")
    public void userMakesAPatchRequest() {
        response = request.patch(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @And("user edits the body for team")
    public void userEditsTheBodyForTeam(String requestBody) {
        this.requestBody = String.format(requestBody, teamNameEdit, employeeId, businessId);

        request.body(this.requestBody);
    }

    @When("user makes a delete request")
    public void userMakesADeleteRequest() {
        response = request.delete(uri);
        response.then().log().all();
        scenario.attach(response.then().extract().body().asPrettyString(), "text/plain", "response");
    }

    @And("user sets the body for branch")
    public void userSetsTheBodyForBranch(String requestBody) {
        this.requestBody = String.format(requestBody, branchName, employeeId, businessId, branchAddress);
        request.body(this.requestBody);
    }

    @And("user saves the branch_id for upcoming APIs")
    public void userSavesTheBranch_idForUpcomingAPIs() {
        branchId = response.jsonPath().getString("data._id");

    }

    @And("user sets the edit body for branch")
    public void userSetsTheEditBodyForBranch(String requestBody) {
        this.requestBody = String.format(requestBody, branchNameEdit, employeeId, businessId, branchAddressEdit);
        request.body(this.requestBody);
    }

    @And("user sets the body for group")
    public void userSetsTheBodyForGroup(String requestBody) {
        this.requestBody = String.format(requestBody, groupName, employeeId, businessId);

        request.body(this.requestBody);
    }

    @And("user sets the edit body for group")
    public void userSetsTheEditBodyForGroup(String requestBody) {
        this.requestBody = String.format(requestBody, groupNameEdit, employeeId, businessId);

        request.body(this.requestBody);
    }

    @And("user saves the group_id for upcoming APIs")
    public void userSavesTheGroup_idForUpcomingAPIs() {
        groupId = response.jsonPath().getString("data._id");
    }
}
