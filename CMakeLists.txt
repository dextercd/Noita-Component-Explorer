cmake_minimum_required(VERSION 3.22)

project(ComponentExplorer
    VERSION 1.44.1
    HOMEPAGE_URL "https://github.com/dextercd/Noita-Component-Explorer"
    LANGUAGES
)
set(PROJECT_WIKI "https://noita.wiki.gg/wiki/Mod:Component_Explorer")

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
        ${CMAKE_COMMAND} -E env
            "VERSION=${PROJECT_VERSION}"
            "HOMEPAGE=${PROJECT_HOMEPAGE_URL}"
            "WIKI=${PROJECT_WIKI}" --
        ${Python_EXECUTABLE} "${CMAKE_CURRENT_SOURCE_DIR}/codegen/gen.py" --output ${RJINJA_OUTPUT}
    )

    # Aliases are in the form of <path>@<alias>
    # To setup dependencies properly we collect the paths in here
    set(JSON_PATHS)

    foreach(JSON IN LISTS RJINJA_JSON)
        list(APPEND COMMAND_LIST --json ${JSON})

        if (JSON MATCHES "(.*)@")
            list(APPEND JSON_PATHS ${CMAKE_MATCH_1})
        else()
            list(APPEND JSON_PATHS ${JSON})
        endif()
    endforeach()

    cmake_path(ABSOLUTE_PATH RJINJA_TEMPLATE BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
    add_custom_command(
        OUTPUT "${RJINJA_OUTPUT}"

        DEPENDS install_component_explorer_python_packages
            "${CMAKE_CURRENT_SOURCE_DIR}/codegen/gen.py"
            ${JSON_PATHS} ${RJINJA_TEMPLATE}

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

    foreach(FILE_VERSION main beta)
        add_custom_target(update_${FILE_VERSION}_repo_components_file
            DEPENDS
                ${CMAKE_CURRENT_SOURCE_DIR}/component_parser/parse.py
                ${NOITA_COMPONENT_DOC}

            VERBATIM
            COMMAND Python::Interpreter ${CMAKE_CURRENT_SOURCE_DIR}/component_parser/parse.py
                --output ${CMAKE_CURRENT_SOURCE_DIR}/data/component_${FILE_VERSION}_documentation.json
                ${NOITA_COMPONENT_DOC}
        )
    endforeach()
endif()

foreach(FILE_VERSION main beta)
    render_jinja_template(OUTPUT components_${FILE_VERSION}.lua
        TEMPLATE components.lua
        JSON
            ${CMAKE_CURRENT_SOURCE_DIR}/data/component_${FILE_VERSION}_documentation.json@component_documentation
            ${CMAKE_CURRENT_SOURCE_DIR}/data/field_infos.json
    )

    render_jinja_template(OUTPUT serialise_component_${FILE_VERSION}.lua
        TEMPLATE serialise_component.lua
        JSON ${CMAKE_CURRENT_SOURCE_DIR}/data/component_${FILE_VERSION}_documentation.json@component_documentation
    )

    render_jinja_template(OUTPUT configs_${FILE_VERSION}.lua
        TEMPLATE configs.lua
        JSON
            ${CMAKE_CURRENT_SOURCE_DIR}/data/configs_${FILE_VERSION}.json@configs
    )

    add_custom_target(components_${FILE_VERSION}_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/components_${FILE_VERSION}.lua)
    add_custom_target(serialise_component_${FILE_VERSION}_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/serialise_component_${FILE_VERSION}.lua)
    add_custom_target(configs_${FILE_VERSION}_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/configs_${FILE_VERSION}.lua)

    install(
        FILES
            ${CMAKE_CURRENT_BINARY_DIR}/serialise_component_${FILE_VERSION}.lua
            ${CMAKE_CURRENT_BINARY_DIR}/components_${FILE_VERSION}.lua
            ${CMAKE_CURRENT_BINARY_DIR}/configs_${FILE_VERSION}.lua
        DESTINATION "component-explorer"
        COMPONENT ComponentExplorer
    )
endforeach()

render_jinja_template(OUTPUT version.lua
    TEMPLATE version.lua
)
add_custom_target(version_lua ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/version.lua)


configure_file(mod.xml.in mod.xml @ONLY)

# Installing

install(DIRECTORY component-explorer DESTINATION "." COMPONENT ComponentExplorer)
install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/version.lua
        ${CMAKE_CURRENT_BINARY_DIR}/mod.xml
    DESTINATION "component-explorer"
    COMPONENT ComponentExplorer
)

install(DIRECTORY unsafe-explorer DESTINATION "." COMPONENT ComponentExplorer-Unsafe)

include(packaging/CMakeLists.txt)
