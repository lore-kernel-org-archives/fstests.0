Received: from mail-yw0-f170.google.com ([209.85.161.170]:35933 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965033AbeEJPve (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 May 2018 11:51:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180510154139.4823-1-jack@suse.cz>
References: <20180510154139.4823-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 May 2018 18:51:32 +0300
Message-ID: <CAOQ4uxhD6=FrZri1a-fWaPEEOBPJE1MT+2ECiq1xseejCN0+cQ@mail.gmail.com>
Subject: Re: [PATCH] ext4/309: Add SEEK_DATA tests for offsets in the middle
 of holes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests <fstests@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 10, 2018 at 6:41 PM, Jan Kara <jack@suse.cz> wrote:
> ext4 had a bug for files with indirect extents where it wrongly reported
> a size of a hole in some cases and thus SEEK_DATA implementation could
> skip some data in a file. Test for that. The problem is fixed by patch
> "ext4: Fix hole length detection in ext4_ind_map_blocks()".
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  src/seek_sanity_test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/309         | 56 +++++++++++++++++++++++++++++++++++++++
>  tests/ext4/309.out     |  1 +
>  tests/ext4/group       |  1 +
>  4 files changed, 129 insertions(+)
>  create mode 100755 tests/ext4/309
>  create mode 100644 tests/ext4/309.out
>
> Note that I'm adding new tests to a common test program src/seek_sanity_test
> but I only use them from ext4 specific test as the offsets are pretty ext4
> specific and so I don't see any use in making this run for all other
> filesystems. If people think it should be done differently, please speak up.

I think its a very quick test and it deserves to be in generic.
Even thought the numbers are computed for ext4, the test is generic
enough to run on all fs.

>
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index e82cb1f78671..9245464400e8 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -274,6 +274,75 @@ out:
>         return ret;
>  }
>
> +/*
> + * Make sure hole size is properly reported when starting in the middle of a
> + * hole in ext? doubly indirect tree
> + */
> +static int test20(int fd, int testnum)
> +{
> +       int ret = -1;
> +       char *buf = NULL;
> +       loff_t bufsz, filsz;
> +
> +       bufsz = alloc_size;
> +       buf = do_malloc(bufsz);
> +       if (!buf)
> +               goto out;
> +       memset(buf, 'a', bufsz);
> +
> +       /* Magic size in the middle of ext[23] triple indirect tree */
> +       filsz = (12 + bufsz / 4 + 8 * bufsz / 4 * bufsz / 4 + 2 * bufsz / 4 + 5) * bufsz;
> +       ret = do_pwrite(fd, buf, bufsz, filsz - bufsz);
> +       if (ret)
> +               goto out;
> +
> +       /* Offset inside ext[23] indirect block */
> +       ret += do_lseek(testnum, 1, fd, filsz, SEEK_DATA, 14 * bufsz, filsz - bufsz);
> +       /* Offset inside ext[23] doubly indirect block */
> +       ret += do_lseek(testnum, 2, fd, filsz, SEEK_DATA, (12 + 2 * bufsz / 4) * bufsz, filsz - bufsz);
> +       /* Offsets inside ext[23] triply indirect block */
> +       ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
> +               (12 + bufsz / 4 + bufsz / 4 * bufsz / 4 + 3 * bufsz / 4 + 5) * bufsz, filsz - bufsz);
> +       ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
> +               (12 + bufsz / 4 + 7 * bufsz / 4 * bufsz / 4 + 5 * bufsz / 4) * bufsz, filsz - bufsz);
> +       ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
> +               (12 + bufsz / 4 + 8 * bufsz / 4 * bufsz / 4 + bufsz / 4 + 11) * bufsz, filsz - bufsz);
> +out:
> +       if (buf)
> +               free(buf);
> +       return ret;
> +}
> +/*
> + * Make sure hole size is properly reported when starting in the middle of a
> + * hole in ext? indirect tree
> + */
> +static int test19(int fd, int testnum)
> +{
> +       int ret = -1;
> +       char *buf = NULL;
> +       int bufsz, filsz;
> +
> +       bufsz = alloc_size;
> +       buf = do_malloc(bufsz);
> +       if (!buf)
> +               goto out;
> +       memset(buf, 'a', bufsz);
> +
> +       /* Magic size just beyond ext[23] indirect tree size */
> +       filsz = (12 + bufsz / 4 + 1) * bufsz;
> +       ret = do_pwrite(fd, buf, bufsz, filsz - bufsz);
> +       if (ret)
> +               goto out;
> +
> +       ret += do_lseek(testnum, 1, fd, filsz, SEEK_DATA, bufsz, filsz - bufsz);
> +       ret += do_lseek(testnum, 2, fd, filsz, SEEK_DATA, 12*bufsz, filsz - bufsz);
> +       ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA, (12 + bufsz / 4 - 8)*bufsz, filsz - bufsz);
> +out:
> +       if (buf)
> +               free(buf);
> +       return ret;
> +}
> +
>  /* Make sure we get ENXIO if we pass in a negative offset. */
>  static int test18(int fd, int testnum)
>  {
> @@ -982,6 +1051,8 @@ struct testrec seek_tests[] = {
>         { 16, test16, "Test file with unwritten extents, non-contiguous dirty pages" },
>         { 17, test17, "Test file with unwritten extents, data-hole-data inside page" },
>         { 18, test18, "Test file with negative SEEK_{HOLE,DATA} offsets" },
> +       { 19, test19, "Test file SEEK_DATA from middle of a large hole" },
> +       { 20, test20, "Test file SEEK_DATA from middle of a huge hole" },
>  };
>
>  static int run_test(struct testrec *tr)
> diff --git a/tests/ext4/309 b/tests/ext4/309
> new file mode 100755
> index 000000000000..ef56503db0f9
> --- /dev/null
> +++ b/tests/ext4/309
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# FS QA Test No. 309
> +#
> +# SEEK_DATA sanity tests.

Please mention this is a regression test for ext4 bug fix
with commit id.

> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 SUSE.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_test
> +_require_seek_data_hole
> +
> +BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
> +
> +_require_test_program "seek_sanity_test"
> +
> +_cleanup()
> +{
> +       eval "rm -f $BASE_TEST_FILE.*"
> +}
> +
> +$here/src/seek_sanity_test -s 19 -e 20 $BASE_TEST_FILE > $seqres.full 2>&1 ||
> +       _fail "seek sanity check failed!"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> new file mode 100644
> index 000000000000..2b6375844df5
> --- /dev/null
> +++ b/tests/ext4/309.out
> @@ -0,0 +1 @@
> +QA output created by 309
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 5bd15f82b3be..74f8273f5667 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -44,3 +44,4 @@
>  306 auto rw resize quick
>  307 auto ioctl rw defrag
>  308 auto ioctl rw prealloc quick defrag
> +309 auto quick

Maybe group 'rw' like the rest of the seek_sanity_test tests.

Thanks,
Amir.
