cmake_minimum_required(VERSION 3.22)

project(ComponentExplorer
    VERSION 1.16.0
    HOMEPAGE_URL "https://github.com/dextercd/Noita-Component-Explorer"
    LANGUAGES
)

set(COMPONENT_EXPLORER_DEV OFF CACHE BOOL "Extra build functionality")

find_package(Python REQUIRED Interpreter)

add_custom_command(
    OUTPUT component_explorer_python_packages

    DEPENDS ${CMAKE_SOURCE_DIR}/requirements.txt

    VERBATIM
    COMMAND Python::Interpreter -m pip install -r ${CMAKE_SOURCE_DIR}/requirements.txt
    COMMAND ${CMAKE_COMMAND} -E touch component_explorer_python_packages
)

add_custom_target(install_component_explorer_python_packages
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/component_explorer_python_packages
)

function(render_jinja_template)
    set(options)
    set(one_value_args OUTPUT TEMPLATE)
    set(multi_value_args JSON)
    cmake_parse_arguments(RJINJA "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

    set(COMMAND_LIST
        ${CMAKE_COMMAND} -E env "VERSION=${PROJECT_VERSION}" "HOMEPAGE=${PROJECT_HOMEPAGE_URL}" --
        ${Python_EXECUTABLE} "${CMAKE_CURRENT_SOURCE_DIR}/codegen/gen.py" --output ${RJINJA_OUTPUT}
    )

    foreach(JSON IN LISTS RJINJA_JSON)
        list(APPEND COMMAND_LIST --json ${JSON})
    endforeach()

    cmake_path(ABSOLUTE_PATH RJINJA_TEMPLATE BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
    add_custom_command(
        OUTPUT "${RJINJA_OUTPUT}"

        DEPENDS install_component_explorer_python_packages
            "${CMAKE_CURRENT_SOURCE_DIR}/codegen/gen.py"
            ${RJINJA_JSON} ${RJINJA_TEMPLATE}

        VERBATIM
        COMMAND ${COMMAND_LIST} ${RJINJA_TEMPLATE}
    )
    message(STATUS ${COMMAND_LIST} ${RJINJA_TEMPLATE})
endfunction()


if (COMPONENT_EXPLORER_DEV)
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
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/component_documentation.json
        COMMAND ${CMAKE_COMMAND} -E copy
            component_documentation.json
            ${CMAKE_CURRENT_SOURCE_DIR}/data/component_documentation.json
    )
else()
    configure_file(data/component_documentation.json component_documentation.json
        COPYONLY
    )
endif()

render_jinja_template(OUTPUT components.lua
    TEMPLATE components.lua
    JSON
        ${CMAKE_CURRENT_BINARY_DIR}/component_documentation.json
        ${CMAKE_CURRENT_SOURCE_DIR}/data/field_infos.json
)
add_custom_target(components_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/components.lua)

render_jinja_template(OUTPUT serialise_component.lua
    TEMPLATE serialise_component.lua
    JSON ${CMAKE_CURRENT_BINARY_DIR}/component_documentation.json
)
add_custom_target(serialise_component_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/serialise_component.lua)

render_jinja_template(OUTPUT version.lua
    TEMPLATE version.lua
    JSON ${CMAKE_CURRENT_BINARY_DIR}/component_documentation.json
)
add_custom_target(version_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/version.lua)

render_jinja_template(OUTPUT configs.lua
    TEMPLATE configs.lua
    JSON
        ${CMAKE_CURRENT_SOURCE_DIR}/data/configs.json
)
add_custom_target(configs_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/configs.lua)


configure_file(mod.xml.in mod.xml @ONLY)

# Installing

install(DIRECTORY component-explorer DESTINATION "." COMPONENT ComponentExplorer)
install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/components.lua
        ${CMAKE_CURRENT_BINARY_DIR}/serialise_component.lua
        ${CMAKE_CURRENT_BINARY_DIR}/version.lua
        ${CMAKE_CURRENT_BINARY_DIR}/configs.lua
        ${CMAKE_CURRENT_BINARY_DIR}/mod.xml
    DESTINATION "component-explorer"
    COMPONENT ComponentExplorer
)

include(packaging/CMakeLists.txt)
