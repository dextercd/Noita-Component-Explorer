cmake_minimum_required(VERSION 3.22)

project(modders-delight
    VERSION 0.0.1
    LANGUAGES
)

set(MODDERS_DELIGHT_DEV OFF CACHE BOOL "Extra build functionality")

find_package(Python REQUIRED Interpreter)

add_custom_command(
    OUTPUT modders_delight_python_packages

    APPDEND
    DEPENDS ${CMAKE_SOURCE_DIR}/requirements.txt

    VERBATIM
    COMMAND Python::Interpreter -m pip install -r
    COMMAND ${CMAKE_COMMAND} -E touch modders_delight_python_packages
)

add_custom_target(install_modders_delight_python_packages
    DEPENDS modders_delight_python_packages
)

if (MODDERS_DELIGHT_DEV)
    find_path(NOITA_INSTALL_DIR
        NAMES noita.exe
        PATHS
            "C:/Program Files (x86)/Steam/steamapps/common/Noita"
            "$ENV{HOME}/.steam/steam/steamapps/common/Noita"
    )

    set(NOITA_COMPONENT_DOC ${NOITA_INSTALL_DIR}/tools_modding/component_documentation.txt)

    add_custom_command(
        OUTPUT component_documentation.json
        DEPENDS
            ${CMAKE_CURRENT_SOURCE_DIR}/component_parser/parse.py
            ${NOITA_COMPONENT_DOC}

        VERBATIM
        COMMAND Python::Interpreter ${CMAKE_CURRENT_SOURCE_DIR}/component_parser/parse.py
            --output component_documentation.json
            ${NOITA_COMPONENT_DOC}
    )

    add_custom_target(update_repo_components_file
        COMMAND ${CMAKE_COMMAND} -E copy
            component_documentation.json
            ${CMAKE_CURRENT_SOURCE_DIR}/data/component_documentation.json
    )
else()
    configure_file(data/component_documentation.json component_documentation.json
        COPYONLY
    )
endif()
