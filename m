Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbbC3NbN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 30 Mar 2015 09:31:13 -0400
Date: Mon, 30 Mar 2015 09:31:08 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] xfstests/xfs: xfs_repair secondary sb verification
 regression test
Message-ID: <20150330133108.GA61426@bfoster.bfoster>
References: <1421854627-30558-1-git-send-email-bfoster@redhat.com>
 <5518E19C.2070202@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5518E19C.2070202@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 30, 2015 at 01:39:40PM +0800, gux.fnst wrote:
> Hi,
> 
> This test case always fail like this:
> xfs/070	 - output mismatch (see /var/lib/xfstests/results//xfs/070.out.bad)
>     --- tests/xfs/070.out	2015-03-17 14:30:45.671000000 +0800
>     +++ /var/lib/xfstests/results//xfs/070.out.bad	2015-03-30 13:33:44.450000000 +0800
>     @@ -7,6 +7,7 @@
>      bad on-disk superblock AGNO - bad magic number
>      primary/secondary superblock AGNO conflict - AG superblock geometry info conflicts with filesystem geometry
>      zeroing unused portion of secondary superblock (AG #AGNO)
>     +non-null project quota inode field in superblock AGNO
>      reset bad sb for ag AGNO
>              - found root inode chunk
>      Phase 3 - for each AG...
>     ...
>     (Run 'diff -u tests/xfs/070.out /var/lib/xfstests/results//xfs/070.out.bad'  to see the entire diff)
> Is this failure caused by message loss in the golden output? Thanks!
> 

Hmm, no this is a bit strange. I suspect you're testing on a v4 fs
(e.g., crc=0), because that is where I can reproduce this as well.

What appears to be going on here is that repair zeroes the region of the
secondary superblock beyond the last valid field, depending on the sb
version (see secondary_sb_wack()). This xfstest overwrites the entire
sector, so clearly triggers this zeroing mechanism.

The confusing bit is that sb->sb_pquotino is actually already set to the
expected value of NULLFSINO at the onset of this function. This occurs
because the caller (verify_set_agheader()) copies from the primary
superblock if a sb mismatch has occurred. Therefore, secondary_sb_wack()
basically intentionally zeroes an invalid sb field, complains that said
field is zero further down in the same function, and then takes the
restorative action of setting the field to zero. ;/

This doesn't occur with a crc=1 filesystem because sb_pquotino falls
within the range of valid fields, and thus the already restored value is
not zeroed. I suspect the right thing to do here is not parse the
sb_pquotino field unless the fs feature mechanism indicates it is a
valid field. I'll send a patch shortly.

Brian

> Regards,
> Xing Gu
> 
> On 01/21/2015 11:37 PM, Brian Foster wrote:
> >The secondary superblock verification in xfs_repair was subject to a bug
> >that unnecessarily leads to a brute force superblock scan if the last
> >superblock in the fs happens to be corrupt. Normally, xfs_repair handles
> >one-off superblock corruption gracefully using a heuristic that finds
> >the most consistent superblock content across the set of secondary
> >superblocks.
> >
> >Create a regression test for xfs_repair that corrupts the last
> >superblock in the fs. Verify the superblock is updated from the
> >previously verified sb content and a brute force scan is not initiated.
> >In the event of failure, detect that a brute force scan has started and
> >abort the repair in order to fail the test quickly.
> >
> >To support the test, extend the xfs_repair filter to handle corrupted
> >superblock repair output and provide generic test output for arbitrary
> >AG counts.
> >
> >Signed-off-by: Brian Foster <bfoster@redhat.com>
> >---
> >
> >v2:
> >- Use pgrep instead of ps to monitor xfs_repair process.
> >- Use mkfs filter instead of xfs_db to obtain agcount of scratch fs.
> >v1: http://oss.sgi.com/archives/xfs/2015-01/msg00321.html
> >
> >  common/repair     |   4 ++
> >  tests/xfs/069     | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/069.out |  27 ++++++++++++++
> >  tests/xfs/group   |   1 +
> >  4 files changed, 142 insertions(+)
> >  create mode 100755 tests/xfs/069
> >  create mode 100644 tests/xfs/069.out
> >
> >diff --git a/common/repair b/common/repair
> >index a157580..7a99546 100644
> >--- a/common/repair
> >+++ b/common/repair
> >@@ -88,6 +88,10 @@ s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
> >  # sunit/swidth reset messages
> >  s/^(Note - .*) were copied.*/\1 fields have been reset./;
> >  s/^(Please) reset (with .*) if necessary/\1 set \2/;
> >+# corrupt sb messages
> >+s/(superblock) (\d+)/\1 AGNO/;
> >+s/(AG \#)(\d+)/\1AGNO/;
> >+s/(reset bad sb for ag) (\d+)/\1 AGNO/;
> >  	print;'
> >  }
> >
> >diff --git a/tests/xfs/069 b/tests/xfs/069
> >new file mode 100755
> >index 0000000..1432761
> >--- /dev/null
> >+++ b/tests/xfs/069
> >@@ -0,0 +1,110 @@
> >+#! /bin/bash
> >+# FS QA Test No. 069
> >+#
> >+# As part of superblock verification, xfs_repair checks the primary sb and
> >+# verifies all secondary sb's against the primary. In the event of geometry
> >+# inconsistency, repair uses a heuristic that tracks the most frequently
> >+# occurring settings across the set of N (agcount) superblocks.
> >+#
> >+# xfs_repair was subject to a bug that disregards this heuristic in the event
> >+# that the last secondary superblock in the fs is corrupt. The side effect is an
> >+# unnecessary and potentially time consuming brute force superblock scan.
> >+#
> >+# This is a regression test for the aforementioned xfs_repair bug. We
> >+# intentionally corrupt the last superblock in the fs, run xfs_repair and
> >+# verify it repairs the fs correctly. We explicitly detect a brute force scan
> >+# and abort the repair to save time in the failure case.
> >+#
> >+#-----------------------------------------------------------------------
> >+# Copyright (c) 2015 Red Hat, Inc. All Rights Reserved.
> >+#
> >+# This program is free software; you can redistribute it and/or
> >+# modify it under the terms of the GNU General Public License as
> >+# published by the Free Software Foundation.
> >+#
> >+# This program is distributed in the hope that it would be useful,
> >+# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+# GNU General Public License for more details.
> >+#
> >+# You should have received a copy of the GNU General Public License
> >+# along with this program; if not, write the Free Software Foundation,
> >+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >+#-----------------------------------------------------------------------
> >+#
> >+
> >+seq=`basename $0`
> >+seqres=$RESULT_DIR/$seq
> >+echo "QA output created by $seq"
> >+
> >+here=`pwd`
> >+tmp=/tmp/$$
> >+status=1	# failure is the default!
> >+trap "_cleanup; exit \$status" 0 1 2 3 15
> >+
> >+_cleanup()
> >+{
> >+	cd /
> >+	rm -f $tmp.*
> >+	killall -9 $XFS_REPAIR_PROG > /dev/null 2>&1
> >+	wait > /dev/null 2>&1
> >+}
> >+
> >+# Start and monitor an xfs_repair of the scratch device. This test can induce a
> >+# time consuming brute force superblock scan. Since a brute force scan means
> >+# test failure, detect it and end the repair.
> >+_xfs_repair_noscan()
> >+{
> >+	# invoke repair directly so we can kill the process if need be
> >+	$XFS_REPAIR_PROG $SCRATCH_DEV 2>&1 | tee -a $seqres.full > $tmp.repair &
> >+	repair_pid=$!
> >+
> >+	# monitor progress for as long as it is running
> >+	while [ `pgrep xfs_repair` ]; do
> >+		grep "couldn't verify primary superblock" $tmp.repair \
> >+			> /dev/null 2>&1
> >+		if [ $? == 0 ]; then
> >+			# we've started a brute force scan. kill repair and
> >+			# fail the test
> >+			kill -9 $repair_pid >> $seqres.full 2>&1
> >+			wait >> $seqres.full 2>&1
> >+
> >+			_fail "xfs_repair resorted to brute force scan"
> >+		fi
> >+
> >+		sleep 1
> >+	done
> >+
> >+	wait
> >+
> >+	cat $tmp.repair | _filter_repair
> >+}
> >+
> >+rm -f $seqres.full
> >+
> >+# get standard environment, filters and checks
> >+. ./common/rc
> >+. ./common/filter
> >+. ./common/repair
> >+
> >+# real QA test starts here
> >+
> >+# Modify as appropriate.
> >+_supported_fs xfs
> >+_supported_os Linux
> >+_require_scratch_nocheck
> >+
> >+_scratch_mkfs | _filter_mkfs > /dev/null 2> $tmp.mkfs || _fail "mkfs failed"
> >+
> >+. $tmp.mkfs # import agcount
> >+
> >+# corrupt the last secondary sb in the fs
> >+$XFS_DB_PROG -x -c "sb $((agcount - 1))" -c "type data" \
> >+	-c "write fill 0xff 0 512" $SCRATCH_DEV
> >+
> >+# attempt to repair
> >+_xfs_repair_noscan
> >+
> >+# success, all done
> >+status=0
> >+exit
> >diff --git a/tests/xfs/069.out b/tests/xfs/069.out
> >new file mode 100644
> >index 0000000..c6b11d1
> >--- /dev/null
> >+++ b/tests/xfs/069.out
> >@@ -0,0 +1,27 @@
> >+QA output created by 069
> >+Phase 1 - find and verify superblock...
> >+Phase 2 - using <TYPEOF> log
> >+        - zero log...
> >+        - scan filesystem freespace and inode maps...
> >+bad magic number
> >+bad on-disk superblock AGNO - bad magic number
> >+primary/secondary superblock AGNO conflict - AG superblock geometry info conflicts with filesystem geometry
> >+zeroing unused portion of secondary superblock (AG #AGNO)
> >+reset bad sb for ag AGNO
> >+        - found root inode chunk
> >+Phase 3 - for each AG...
> >+        - scan and clear agi unlinked lists...
> >+        - process known inodes and perform inode discovery...
> >+        - process newly discovered inodes...
> >+Phase 4 - check for duplicate blocks...
> >+        - setting up duplicate extent list...
> >+        - check for inodes claiming duplicate blocks...
> >+Phase 5 - rebuild AG headers and trees...
> >+        - reset superblock...
> >+Phase 6 - check inode connectivity...
> >+        - resetting contents of realtime bitmap and summary inodes
> >+        - traversing filesystem ...
> >+        - traversal finished ...
> >+        - moving disconnected inodes to lost+found ...
> >+Phase 7 - verify and correct link counts...
> >+done
> >diff --git a/tests/xfs/group b/tests/xfs/group
> >index 496630d..9394703 100644
> >--- a/tests/xfs/group
> >+++ b/tests/xfs/group
> >@@ -66,6 +66,7 @@
> >  066 dump ioctl auto quick
> >  067 acl attr auto quick
> >  068 auto stress dump
> >+069 auto quick repair
> >  071 rw auto
> >  072 rw auto prealloc quick
> >  073 copy auto
> >
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
