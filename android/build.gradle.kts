allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Injects missing namespaces safely regardless of project evaluation timing
subprojects {
    fun applyNamespaceFallback() {
        val androidExt = extensions.findByName("android")
        if (androidExt != null) {
            try {
                val getNamespace = androidExt.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(androidExt) as? String

                if (currentNamespace.isNullOrEmpty()) {
                    val setNamespace = androidExt.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(androidExt, "com.example.${name.replace('-', '_')}")
                }
            } catch (_: Exception) {
                // Ignore subprojects without Android extension
            }
        }
    }

    if (state.executed) {
        applyNamespaceFallback()
    } else {
        afterEvaluate {
            applyNamespaceFallback()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}