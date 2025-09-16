cmake_minimum_required(VERSION 3.23)
project(scorched-earth VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

find_package(Qt6 REQUIRED COMPONENTS Quick Gui)

qt_standard_project_setup()

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Quick Qt6::Gui)

qt_add_qml_module(${PROJECT_NAME}
    URI scorched-earth
    VERSION 1.0
    QML_FILES
        main.qml
        gameStage.qml
)
