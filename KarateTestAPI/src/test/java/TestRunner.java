import com.intuit.karate.junit5.Karate;
// NOTE: We no longer use @RunWith or @KarateOptions for JUnit 5

class TestRunner {

    // IMPORTANT: The JUnit 5 runner uses the @Karate.Test annotation instead of @RunWith
    @Karate.Test
    // The features property specifies the classpath location of your feature files
    Karate runHappyPath() {
        // The path starts after src/test/resources/
        return Karate.run("demobooks/test/demobook_happypath_successfully_search_books.feature").relativeTo(getClass());
    }

}