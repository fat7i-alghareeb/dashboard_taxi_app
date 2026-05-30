import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("stage") {
            dimension = "flavor-type"
            applicationId = "dev.fat7i.dashboardtaxi"
            resValue(type = "string", name = "app_name", value = "dashboardtaxi Stage")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "dev.fat7i.dashboardtaxi"
            resValue(type = "string", name = "app_name", value = "dashboardtaxi")
        }
    }
}
