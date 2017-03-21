Received: from aserp1040.oracle.com ([141.146.126.69]:37166 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932619AbdCUOZR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 10:25:17 -0400
Date: Tue, 21 Mar 2017 10:23:52 -0400
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 3/4] reflink: test adjacency of reflinked blocks
Message-ID: <20170321142352.GA5722@birch.djwong.org>
References: <148798515933.25833.2842247083803775089.stgit@birch.djwong.org>
 <148798517790.25833.2585159479268361866.stgit@birch.djwong.org>
 <6511f176-ee8e-09d8-d955-8aed36abaa29@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6511f176-ee8e-09d8-d955-8aed36abaa29@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: eguan@redhat.com, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@djwong.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 03:14:36PM +0800, Qu Wenruo wrote:
> Hi Darrick
>=20
> At 02/25/2017 09:12 AM, Darrick J. Wong wrote:
> >From: Darrick J. Wong <darrick.wong@oracle.com>
> >
> >If we reflink a file with N blocks to another file one block at a time,
> >does the destination file end up with the same number of extents as the
> >source file?  In other words, does the filesystem succeed at combining
> >adjacent mappings into a maximal extents?
>=20
> Btrfs can't pass the test since it doesn't merge such mapping, not only t=
he
> fiemap result, but also on-disk extents.

Weirdly, I observed that if you unmount and remount the btrfs it
actually /will/ merge the extents.

> IIRC ocfs also merges it, so I wonder if this is a documented behavior to
> merge any extent maps that are adjacent.

Generally, yes you'd expect that two logically and physically contiguous
extents to be merged together.  That might change a bit for compressed
or encrypted extents.

> Further more, if a fs has a limit on extent size on disk, e.g 128M.
> But 2 file extents are also adjacent on disk, then should fiemap return a
> large 256M map or just 2 adjacent 128M maps?

It's up to the fs, really... XFS will merge the extent records (up to
maximum extent size) and then unmerge the shared/not-shared FIEMAP
records for accurate shared extent reporting.

--D

>=20
> Thanks,
> Qu
> >
> >Signed-off-by: Darrick J. Wong <djwong@djwong.org>
> >---
> > tests/generic/930     |  106 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
> > tests/generic/930.out |   11 +++++
> > tests/generic/group   |    1
> > 3 files changed, 118 insertions(+)
> > create mode 100755 tests/generic/930
> > create mode 100644 tests/generic/930.out
> >
> >
> >diff --git a/tests/generic/930 b/tests/generic/930
> >new file mode 100755
> >index 0000000..15d8cbf
> >--- /dev/null
> >+++ b/tests/generic/930
> >@@ -0,0 +1,106 @@
> >+#! /bin/bash
> >+# FS QA Test No. 930
> >+#
> >+# Check that reflinking adjacent blocks in a file produces a single
> >+# block mapping extent.
> >+#
> >+#-----------------------------------------------------------------------
> >+# Copyright (c) 2017 Oracle, Inc.  All Rights Reserved.
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
> >+seq=3D`basename $0`
> >+seqres=3D$RESULT_DIR/$seq
> >+echo "QA output created by $seq"
> >+
> >+here=3D`pwd`
> >+tmp=3D/tmp/$$
> >+status=3D1	# failure is the default!
> >+trap "_cleanup; exit \$status" 0 1 2 3 7 15
> >+
> >+_cleanup()
> >+{
> >+	cd /
> >+	rm -rf $tmp.*
> >+	wait
> >+}
> >+
> >+# get standard environment, filters and checks
> >+. ./common/rc
> >+. ./common/filter
> >+. ./common/reflink
> >+
> >+# real QA test starts here
> >+_supported_os Linux
> >+_supported_fs generic
> >+_require_scratch_reflink
> >+_require_fiemap
> >+
> >+echo "Format and mount"
> >+_scratch_mkfs > $seqres.full 2>&1
> >+_scratch_mount >> $seqres.full 2>&1
> >+
> >+testdir=3D$SCRATCH_MNT/test-$seq
> >+mkdir $testdir
> >+
> >+blocks=3D32
> >+blksz=3D65536
> >+sz=3D$((blocks * blksz))
> >+
> >+echo "Create the original files"
> >+$XFS_IO_PROG -f -c "falloc 0 $sz" $testdir/file1 >> $seqres.full
> >+_pwrite_byte 0x61 0 $sz $testdir/file1 >> $seqres.full
> >+seq 0 $blksz $((sz - blksz)) | while read offset; do
> >+	_reflink_range $testdir/file1 $offset $testdir/file2 $offset $blksz >>=
 $seqres.full
> >+done
> >+
> >+echo "Compare files"
> >+md5sum $testdir/file1 | _filter_scratch
> >+md5sum $testdir/file2 | _filter_scratch
> >+
> >+echo "Check extent counts"
> >+f1=3D$(_count_extents $testdir/file1)
> >+f2=3D$(_count_extents $testdir/file2)
> >+s1=3D$($XFS_IO_PROG -c 'fiemap -v' $testdir/file1 | awk '{print $5}' | =
grep -c '0x.*[2367aAbBfF]...$')
> >+s2=3D$($XFS_IO_PROG -c 'fiemap -v' $testdir/file2 | awk '{print $5}' | =
grep -c '0x.*[2367aAbBfF]...$')
> >+
> >+# Did the fs combine the extent mappings when we made f2?
> >+test $f1 -eq $f2 || echo "f1 ($f1) !=3D f2 ($f2)"
> >+test $s1 -eq $s2 || echo "s1 ($s1) !=3D s2 ($s2)"
> >+test $f1 -eq $s1 || echo "f1 ($f1) !=3D s1 ($f1)"
> >+test $f2 -eq $s2 || echo "f2 ($f2) !=3D s2 ($f2)"
> >+
> >+_scratch_cycle_mount
> >+
> >+echo "Compare files after remounting"
> >+md5sum $testdir/file1 | _filter_scratch
> >+md5sum $testdir/file2 | _filter_scratch
> >+
> >+echo "Check extent counts"
> >+f1=3D$(_count_extents $testdir/file1)
> >+f2=3D$(_count_extents $testdir/file2)
> >+s1=3D$($XFS_IO_PROG -c 'fiemap -v' $testdir/file1 | awk '{print $5}' | =
grep -c '0x.*[2367aAbBfF]...$')
> >+s2=3D$($XFS_IO_PROG -c 'fiemap -v' $testdir/file2 | awk '{print $5}' | =
grep -c '0x.*[2367aAbBfF]...$')
> >+
> >+# Are the mappings still combined?
> >+test $f1 -eq $f2 || echo "f1 ($f1) !=3D f2 ($f2)"
> >+test $s1 -eq $s2 || echo "s1 ($s1) !=3D s2 ($s2)"
> >+test $f1 -eq $s1 || echo "f1 ($f1) !=3D s1 ($f1)"
> >+test $f2 -eq $s2 || echo "f2 ($f2) !=3D s2 ($f2)"
> >+
> >+# success, all done
> >+status=3D0
> >+exit
> >diff --git a/tests/generic/930.out b/tests/generic/930.out
> >new file mode 100644
> >index 0000000..556108a
> >--- /dev/null
> >+++ b/tests/generic/930.out
> >@@ -0,0 +1,11 @@
> >+QA output created by 930
> >+Format and mount
> >+Create the original files
> >+Compare files
> >+de89461b64701958984c95d1bfb0065a  SCRATCH_MNT/test-930/file1
> >+de89461b64701958984c95d1bfb0065a  SCRATCH_MNT/test-930/file2
> >+Check extent counts
> >+Compare files after remounting
> >+de89461b64701958984c95d1bfb0065a  SCRATCH_MNT/test-930/file1
> >+de89461b64701958984c95d1bfb0065a  SCRATCH_MNT/test-930/file2
> >+Check extent counts
> >diff --git a/tests/generic/group b/tests/generic/group
> >index d0bc47d..4b4df66 100644
> >--- a/tests/generic/group
> >+++ b/tests/generic/group
> >@@ -411,3 +411,4 @@
> > 406 auto quick dangerous
> > 407 auto quick clone metadata
> > 408 auto quick clone dedupe metadata
> >+930 auto quick clone
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhtt=
p-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvl=
ZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE=
&m=3Dji4pI6Gjs_DSzSPcr-Q-vhH1VbaXdHyL5tPzJN-yBpM&s=3DTJXD12aledcnxTXpOf-WLJ=
3bxvj-aDDTXUm7mpaUs1U&e=3D=20
> >
> >
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZ=
YR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&=
m=3Dji4pI6Gjs_DSzSPcr-Q-vhH1VbaXdHyL5tPzJN-yBpM&s=3DTJXD12aledcnxTXpOf-WLJ3=
bxvj-aDDTXUm7mpaUs1U&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3Dji4pI6Gjs_DSzSPcr-Q-vhH1VbaXdHyL5tPzJN-yBpM&s=3DTJXD12aledcnxTXpOf-WLJ3b=
xvj-aDDTXUm7mpaUs1U&e=3D=20
