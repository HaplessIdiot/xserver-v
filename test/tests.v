C to V translator 0.4.1
  translating /home/haplessidiot/Documents/xserver/test/tests.c ... #include <string.h>
#include "tests.h"
#include "tests-common.h"

int verbose = 0;

int
main(int argc, char **argv)
{
    run_test(list_test);
    run_test(string_test);

#ifdef XORG_TESTS
    run_test(fixes_test);
    run_test(input_test);
    run_test(misc_test);
    run_test(signal_logging_test);
    run_test(touch_test);
    run_test(xfree86_test);
    run_test(xkb_test);
    run_test(xtest_test);

#ifdef RES_TESTS
    run_test(hashtabletest_test);
#endif

#ifdef LDWRAP_TESTS
    run_test(protocol_xchangedevicecontrol_test);

    run_test(protocol_xiqueryversion_test);
    run_test(protocol_xiquerydevice_test);
    run_test(protocol_xiselectevents_test);
    run_test(protocol_xigetselectedevents_test);
    run_test(protocol_xisetclientpointer_test);
    run_test(protocol_xigetclientpointer_test);
    run_test(protocol_xipassivegrabdevice_test);
    run_test(protocol_xiquerypointer_test);
    run_test(protocol_xiwarppointer_test);
    run_test(protocol_eventconvert_test);
    run_test(xi2_test);
#endif

#endif /* XORG_TESTS */

    return 0;
}

path=/home/haplessidiot/Documents/xserver/test/tests.c
main loop 30
1FN DECL c_name="fixes_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="hashtabletest_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="input_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="list_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="misc_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="signal_logging_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="string_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="touch_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="xfree86_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="xkb_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="xtest_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xchangedevicecontrol_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xiqueryversion_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xiquerydevice_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xiselectevents_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xigetselectedevents_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xisetclientpointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xigetclientpointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xipassivegrabdevice_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xiquerypointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_xiwarppointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="protocol_eventconvert_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="xi2_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
1FN DECL c_name="run_test_in_child" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file="/home/haplessidiot/Documents/xserver/test/tests-common.h"
1FN DECL c_name="main" cur_file="/home/haplessidiot/Documents/xserver/test/tests.c" node.location.file=""
 c2v translate_file() took    36 ms ; output .v file: test/tests.v
Translated   1 files in    36 ms.
