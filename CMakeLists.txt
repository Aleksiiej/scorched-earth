cmake_minimum_required(VERSION 3.23)
project(scorched-earth VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

find_package(Felgo REQUIRED)

qt_add_executable(${PROJECT_NAME}
    main.cpp
    resources.qrc
)

felgo_configure_executable(${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME} PRIVATE Felgo)

qt_add_qml_module(${PROJECT_NAME}
    URI scorched-earth
    VERSION 1.0
    QML_FILES qml/main.qml
              qml/common/MenuButton.qml
              qml/common/GameButton.qml
              qml/common/SceneBase.qml
              qml/common/StatusBar.qml
              qml/common/Sky.qml
              qml/scenes/GameScene.qml
              qml/scenes/MenuScene.qml
              qml/entities/Player.qml
              qml/entities/Ground.qml
              qml/entities/Wall.qml
              qml/entities/Bullet.qml
)
