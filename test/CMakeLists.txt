enable_testing ()

function(PCAL_CREATE_TEST _generated_target_name _input_file_name)
    add_executable (${_generated_target_name}
        ${_input_file_name}
    )
    add_test (NAME ${_generated_target_name} COMMAND ${_generated_target_name} )
    target_link_libraries (${_generated_target_name} libpcal Qt5::Test)
endfunction() 

pcal_create_test (tst_lunarcalendar tst_lunarcalendar.cpp)
