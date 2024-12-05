import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/features/",
        glue = {"com.cinqd.stepdefs"},
        plugin = {"pretty", "html:target/cucumber-report/report.html"}
)
public class TestRunner {
}
