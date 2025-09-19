cmake_minimum_required(VERSION 3.23)
project(scorched-earth VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_PREFIX_PATH "/home/aleksander/Felgo/Felgo/gcc_64/lib/cmake/Felgo")

find_package(Felgo REQUIRED)

qt_standard_project_setup()

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE Felgo)

qt_add_qml_module(${PROJECT_NAME}
    URI scorched-earth
    VERSION 1.0
    QML_FILES
        main.qml
)
