Received: from aserp1040.oracle.com ([141.146.126.69]:37123 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S974796AbdDXQlL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2017 12:41:11 -0400
Date: Mon, 24 Apr 2017 09:40:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 1/2] ext4: check mount's handling for very large
 s_first_meta_bg
Message-ID: <20170424164057.GD5190@birch.djwong.org>
References: <1492769440-12413-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170424044717.GK26397@eguan.usersys.redhat.com>
 <58FD929A.4040008@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58FD929A.4040008@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 24, 2017 at 01:52:26PM +0800, Xiao Yang wrote:
> On 2017/04/24 12:47, Eryu Guan wrote:
> >On Fri, Apr 21, 2017 at 06:10:39PM +0800, Xiao Yang wrote:
> >>On ext4 filesystem, the kernel carshes at mount time when
> >>s_first_meta_bg's value exceeds the largest possible meta_bg
> >>number.  This kernel bug has been fixed in:
> >>
> >>3a4b77c ext4: validate s_first_meta_bg at mount time
> >>
> >>Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>---
> >>  tests/ext4/025     | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/ext4/025.out |  4 ++++
> >>  tests/ext4/group   |  1 +
> >>  3 files changed, 74 insertions(+)
> >>  create mode 100755 tests/ext4/025
> >>  create mode 100644 tests/ext4/025.out
> >>
> >>diff --git a/tests/ext4/025 b/tests/ext4/025
> >>new file mode 100755
> >>index 0000000..085c52f
> >>--- /dev/null
> >>+++ b/tests/ext4/025
> >>@@ -0,0 +1,69 @@
> >>+#! /bin/bash
> >>+# FS QA Test ext4/025
> >>+#
> >>+# Regression test for commit:
> >>+# 3a4b77c ("ext4: validate s_first_meta_bg at mount time").
> >>+#
> >>+#-----------------------------------------------------------------------
> >>+# Copyright (c) 2017 Fujitsu.  All Rights Reserved.
> >>+# Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>+#
> >>+# This program is free software; you can redistribute it and/or
> >>+# modify it under the terms of the GNU General Public License as
> >>+# published by the Free Software Foundation.
> >>+#
> >>+# This program is distributed in the hope that it would be useful,
> >>+# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>+# GNU General Public License for more details.
> >>+#
> >>+# You should have received a copy of the GNU General Public License
> >>+# along with this program; if not, write the Free Software Foundation,
> >>+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >>+#-----------------------------------------------------------------------
> >>+
> >>+
> >>+seq=`basename $0`
> >>+seqres=$RESULT_DIR/$seq
> >>+echo "QA output created by $seq"
> >>+
> >>+tmp=/tmp/$$
> >>+status=1	# failure is the default!
> >>+trap "_cleanup; exit \$status" 0 1 2 3 15
> >>+
> >>+_cleanup()
> >>+{
> >>+	rm -f $tmp.*
> >>+}
> >>+
> >>+# get standard environment and checks
> >>+. ./common/rc
> >>+. ./common/filter
> >>+
> >>+# remove previous $seqres.full before test
> >>+rm -f $seqres.full
> >>+
> >>+# real QA test starts here
> >>+_supported_fs ext4
> >>+_supported_os Linux
> >>+_require_scratch
> >>+_require_scratch_nocheck
> >_require_scratch_nocheck is sufficient, don't need _require_scratch
> >
> Hi Eryu
> 
> Agreed. :-)
> >>+_require_command "$DEBUGFS_PROG" debugfs
> >>+_require_ext4_mkfs_feature "bigalloc,meta_bg,^resize_inode"
> >>+
> >>+echo "Create ext4 fs and modify first_meta_bg's value"
> >>+$MKFS_EXT4_PROG -F -b 4096 -O bigalloc,meta_bg,^resize_inode $SCRATCH_DEV 16m>>  $seqres.full 2>&1 \
> >>+	|| _notrun "Could not create ext4 filesystem"
> >_scratch_mkfs "-O bigalloc,meta_bg,^resize_inode">>  $seqres.full 2>&1
> >
> >should be fine, if there're conflicts between MKFS_OPTIONS and these
> >extra mkfs options _scratch_mkfs will mkfs again only with test-provided
> >mkfs options.
> >
> I will use _scratch_mkfs as you said.  However, i still specify 4096 as
> block size, because debugfs can't set first_meta_bg
> to 842150400 on RHEL7 when default block size is 1024.   Please see the
> following e2fsprogs bug:
> 
> commit d36b957b345ee6e4b529be99b8fdc8d3e70ccdc1
> Author: Darrick J. Wong <darrick.wong@oracle.com>
> Date:   Sat Jan 11 13:58:15 2014 -0500
> 
>     libext2fs: don't always read backup group descriptors on a 1k-block
> meta_bg fs

That's a commit id -- are you saying that upstream e2fsprogs is broken?
Or simply that RHEL7's e2fsprogs needs to have this patch applied?

(Regardless, the test shouldn't work around fixable e2fsprogs bugs, like
Eryu said in one of the other replies to this thread.)

--D

> >>+
> >>+$DEBUGFS_PROG -w -R "ssv first_meta_bg 842150400" $SCRATCH_DEV>>  $seqres.full 2>&1
> >>+
> >>+# check whether debugfs succeeds to set first_meta_bg to 842150400 or not
> >>+$DEBUGFS_PROG -R "show_super_stats" $SCRATCH_DEV 2>&1 | grep -q "First meta block group:   842150400" \
> >>+	|| _notrun "Could not set first_meta_bg to 842150400 successfully, skip test."
> >>+
> >>+echo "Try to mount a modified ext4 fs"
> >>+_scratch_mount>>  $seqres.full 2>&1 || echo "Fail to mount ext4 fs expectedly"
> >>+
> >>+# success, all done
> >>+status=0
> >>+exit
> >>diff --git a/tests/ext4/025.out b/tests/ext4/025.out
> >>new file mode 100644
> >>index 0000000..f9a76bb
> >>--- /dev/null
> >>+++ b/tests/ext4/025.out
> >>@@ -0,0 +1,4 @@
> >>+QA output created by 025
> >>+Create ext4 fs and modify first_meta_bg's value
> >>+Try to mount a modified ext4 fs
> >>+Fail to mount ext4 fs expectedly
> >>diff --git a/tests/ext4/group b/tests/ext4/group
> >>index cac5aa5..c42a4d5 100644
> >>--- a/tests/ext4/group
> >>+++ b/tests/ext4/group
> >>@@ -27,6 +27,7 @@
> >>  022 auto quick attr dangerous
> >>  023 auto quick scrub
> >>  024 auto quick encrypt dangerous
> >>+025 auto quick dangerous
> >Can be in fuzzers group too.
> >
> I will add it. :-)
> 
> Thanks,
> Xiao Yang.
> >Thanks,
> >Eryu
> >>  271 auto rw quick
> >>  301 aio auto ioctl rw stress defrag
> >>  302 aio auto ioctl rw stress defrag
> >>-- 
> >>1.8.3.1
> >>
> >>
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe fstests" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >--
> >To unsubscribe from this list: send the line "unsubscribe fstests" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >.
> >
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
