C to V translator 0.4.1
  translating /home/haplessidiot/Documents/xserver/hw/xfree86/loader/symbol-test.c ... /*
 * Copyright © 2017 Broadcom
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

/* Small test program to see if we can successfully resolve all
 * symbols of a set of X.Org modules when they're loaded in order.
 */

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

int main (int argc, char**argv)
{
    void *ret;

    if (argc < 2) {
        fprintf(stderr,
                "Must pass path any modules to be loaded.\n");
        exit(1);
    }

    for (int i = 1; i < argc; i++) {
        fprintf(stderr, "opening %s\n", argv[i]);
        ret = dlopen(argv[i], RTLD_GLOBAL | RTLD_NOW);
        if (!ret) {
            fprintf(stderr, "dlopen error: %s\n", dlerror());
            exit(1);
        }
    }

    return 0;
}

path=/home/haplessidiot/Documents/xserver/hw/xfree86/loader/symbol-test.c
main loop 1
1FN DECL c_name="main" cur_file="/home/haplessidiot/Documents/xserver/hw/xfree86/loader/symbol-test.c" node.location.file="/home/haplessidiot/Documents/xserver/hw/xfree86/loader/symbol-test.c"
 c2v translate_file() took    60 ms ; output .v file: /home/haplessidiot/Documents/xserver/hw/xfree86/loader/symbol-test.v
Translated   1 files in    60 ms.
