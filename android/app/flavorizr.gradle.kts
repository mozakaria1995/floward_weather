import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.example.floward_weather.dev"
            resValue(type = "string", name = "app_name", value = "Floward Weather Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.example.floward_weather"
            resValue(type = "string", name = "app_name", value = "Floward Weather")
        }
    }
}