C to V translator 0.4.1
  translating /home/haplessidiot/Documents/xserver/test/tests-common.c ... #include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "tests-common.h"

void
run_test_in_child(const testfunc_t* (*suite)(void), const char *funcname)
{
    int cpid;
    int csts;
    int exit_code = -1;
    const testfunc_t *func = suite();

    printf("\n---------------------\n%s...\n", funcname);

    while (*func)
    {
        cpid = fork();
        if (cpid) {
            waitpid(cpid, &csts, 0);
            if (!WIFEXITED(csts))
                goto child_failed;
            exit_code = WEXITSTATUS(csts);
            if (exit_code != 0) {
    child_failed:
                printf(" FAIL\n");
                exit(exit_code);
            }
        } else {
            testfunc_t f = *func;
            f();
            exit(0);
        }
        func++;
    }
    printf(" Pass\n");
}

path=/home/haplessidiot/Documents/xserver/test/tests-common.c
main loop 29
1FN DECL c_name="fixes_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="hashtabletest_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="input_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="list_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="misc_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="signal_logging_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="string_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="touch_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="xfree86_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="xkb_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="xtest_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xchangedevicecontrol_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xiqueryversion_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xiquerydevice_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xiselectevents_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xigetselectedevents_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xisetclientpointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xigetclientpointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xipassivegrabdevice_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xiquerypointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_xiwarppointer_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="protocol_eventconvert_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="xi2_test" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file=""
1FN DECL c_name="run_test_in_child" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file="/home/haplessidiot/Documents/xserver/test/tests-common.h"
1FN DECL c_name="run_test_in_child" cur_file="/home/haplessidiot/Documents/xserver/test/tests-common.c" node.location.file="/home/haplessidiot/Documents/xserver/test/tests-common.c"
 c2v translate_file() took    97 ms ; output .v file: test/tests-common.v
Translated   1 files in    97 ms.
