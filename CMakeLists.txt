cmake_minimum_required(VERSION 3.16)
project(scorched-earth VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

find_package(Qt6 COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

target_link_libraries(${projectName} PRIVATE Qt6::Quick)

qt_add_qml_module(${PROJECT_NAME}
    URI scorched-earth
    VERSION 1.0
    QML_FILES
        main.qml
)
