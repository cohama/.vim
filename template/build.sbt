:if executable('scala')
:  let scala_version = substitute(system('scala -version'), '.*\(\d\+\)\.\(\d\+\)\.\(\d\+\).*', '\1.\2.\3', '')
:  %s/%SCALA_VERSION%/\=scala_version/
:elseif
:  %s/%SCALA_VERSION%/0.1.0/
:endif
:%s/%ROOT_PROJECT_NAME%/\=expand('%:p:h:t')/
:unlet scala_version
lazy val commonSettings = Seq(
  organization := "com.github.cohama",
  version := "0.1.0",
  scalaVersion := "%SCALA_VERSION%"
)

lazy val root = (project in file(".")).
  settings(commonSettings: _*).
  settings(
    name := "%ROOT_PROJECT_NAME%",
    libraryDependencies ++= Seq(
    )
  )
