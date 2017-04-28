Received: from mail-it0-f47.google.com ([209.85.214.47]:38062 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424383AbdD1KB1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Apr 2017 06:01:27 -0400
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <1493240079-812-1-git-send-email-bo.li.liu@oracle.com>
References: <1493240079-812-1-git-send-email-bo.li.liu@oracle.com>
From: Filipe Manana <fdmanana@gmail.com>
Date: Fri, 28 Apr 2017 11:01:25 +0100
Message-ID: <CAL3q7H5mJ9DO5Fqnboo3a6urvR+AbxPuC61b6DTzbxb30ijsUw@mail.gmail.com>
Subject: Re: [PATCH] fstests: regression test for nocsum dio read's repair
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 26, 2017 at 9:54 PM, Liu Bo <bo.li.liu@oracle.com> wrote:
> Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized blocks"=
)
> introduced this regression.  It'd cause 'Segmentation fault' error.
>
> The upstream fix is
>         Btrfs: fix segment fault when doing dio read

Same issue as the other tests, it fails on a patched kernel. The value
of $physical_on_scratch doesn't match the value in the golden output:

root 08:18:24 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/142
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian3 4.10.0-rc8-btrfs-next-40+
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/142 - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad)
    --- tests/btrfs/142.out 2017-04-28 08:18:22.206251115 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
2017-04-28 08:18:35.946262617 +0100
    @@ -1,39 +1,39 @@
     QA output created by 142
     wrote 131072/131072 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 244056064
    +wrote 65536/65536 bytes at offset 1103101952
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -0e8c0000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u tests/btrfs/142.out
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad'  to see
the entire diff)
Ran: btrfs/142
Failures: btrfs/142
Failed 1 of 1 tests

root 08:18:36 /home/fdmanana/git/hub/xfstests (master)>
root 08:18:38 /home/fdmanana/git/hub/xfstests (master)> diff -u
tests/btrfs/142.out
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
--- tests/btrfs/142.out 2017-04-28 08:18:22.206251115 +0100
+++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
2017-04-28 08:18:35.946262617 +0100
@@ -1,39 +1,39 @@
 QA output created by 142
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 244056064
+wrote 65536/65536 bytes at offset 1103101952
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-0e8c0000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c00f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c0190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-0e8c01f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
-read 512/512 bytes at offset 244056064
+41c00000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c000f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c00190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+41c001f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..............=
..
+read 512/512 bytes at offset 1103101952
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
root 08:18:44 /home/fdmanana/git/hub/xfstests (master)>


thanks

>
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
>  tests/btrfs/142     | 189 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/btrfs/142.out |  39 +++++++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 229 insertions(+)
>  create mode 100755 tests/btrfs/142
>  create mode 100644 tests/btrfs/142.out
>
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> new file mode 100755
> index 0000000..c5fcd22
> --- /dev/null
> +++ b/tests/btrfs/142
> @@ -0,0 +1,189 @@
> +#! /bin/bash
> +# FS QA Test 142
> +#
> +# Regression test for btrfs DIO read's repair during read without checks=
um.
> +#
> +# Commit 2dabb3248453 ("Btrfs: Direct I/O read: Work on sectorsized bloc=
ks")
> +# introduced this regression.  It'd cause 'Segmentation fault' error.
> +#
> +# The upstream fix is
> +#      Btrfs: fix segment fault when doing dio read
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
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
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +
> +_require_btrfs_command inspect-internal dump-tree
> +_require_command "$FILEFRAG_PROG" filefrag
> +
> +# helpe to convert 'file offset' to btrfs logical offset
> +FILEFRAG_FILTER=3D'
> +       if (/blocks? of (\d+) bytes/) {
> +               $blocksize =3D $1;
> +               next
> +       }
> +       ($ext, $logical, $physical, $length) =3D
> +               (/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
> +       or next;
> +       ($flags) =3D /.*:\s*(\S*)$/;
> +       print $physical * $blocksize, "#",
> +             $length * $blocksize, "#",
> +             $logical * $blocksize, "#",
> +             $flags, " "'
> +
> +# this makes filefrag output script readable by using a perl helper.
> +# output is one extent per line, with three numbers separated by '#'
> +# the numbers are: physical, length, logical (all in bytes)
> +# sample output: "1234#10#5678" -> physical 1234, length 10, logical 567=
8
> +_filter_extents()
> +{
> +       tee -a $seqres.full | $PERL_PROG -ne "$FILEFRAG_FILTER"
> +}
> +
> +_check_file_extents()
> +{
> +       cmd=3D"filefrag -v $1"
> +       echo "# $cmd" >> $seqres.full
> +       out=3D`$cmd | _filter_extents`
> +       if [ -z "$out" ]; then
> +               return 1
> +       fi
> +       echo "after filter: $out" >> $seqres.full
> +       echo $out
> +       return 0
> +}
> +
> +_check_repair()
> +{
> +       filter=3D${1:-cat}
> +       dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" |=
 tac | $filter | grep -q -e "direct IO failed"
> +       if [ $? -eq 0 ]; then
> +               echo 1
> +       else
> +               echo 0
> +       fi
> +}
> +
> +_get_physical()
> +{
> +        # $1 is logical address
> +        # print chunk tree and find devid 2 which is $SCRATCH_DEV
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | =
grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 =
}'
> +}
> +
> +
> +SYSFS_BDEV=3D`_sysfs_dev $SCRATCH_DEV`
> +
> +start_fail()
> +{
> +       echo 100 > $DEBUGFS_MNT/fail_make_request/probability
> +       echo 1 > $DEBUGFS_MNT/fail_make_request/times
> +       echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> +       echo 1 > $SYSFS_BDEV/make-it-fail
> +}
> +
> +stop_fail()
> +{
> +       echo 0 > $DEBUGFS_MNT/fail_make_request/probability
> +       echo 0 > $DEBUGFS_MNT/fail_make_request/times
> +       echo 0 > $SYSFS_BDEV/make-it-fail
> +}
> +
> +_scratch_dev_pool_get 2
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs" >>$seqres.full
> +
> +mkfs_opts=3D"-d raid1"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# -o nospace_cache makes sure data is written to the start position of t=
he data
> +# chunk
> +_scratch_mount -o nospace_cache,nodatasum
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" | _filter_xfs_io
> +
> +sync
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the=
 first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent" >>$seqres.full
> +
> +extents=3D`_check_file_extents $SCRATCH_MNT/foobar`
> +logical_in_btrfs=3D`echo ${extents} | cut -d '#' -f 1`
> +physical_on_scratch=3D`_get_physical ${logical_in_btrfs}`
> +
> +_scratch_unmount
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCR=
ATCH_DEV | _filter_xfs_io
> +
> +_scratch_mount -o nospace_cache,nodatasum
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy" >>$seqres.full
> +
> +# since raid1 consists of two copies, and the following read may read th=
e good
> +# copy directly, so lets loop 10 times here and discard output that dio =
reads
> +# give
> +for i in `seq 1 10`; do
> +       # start_fail only fails the following dio read so the repair is
> +       # supposed to work.
> +       start_fail
> +       $XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" >=
 /dev/null
> +       stop_fail
> +       repair=3D`_check_repair`
> +       if [ $repair -eq 1 ]; then
> +               break
> +       fi
> +done
> +
> +_scratch_unmount
> +
> +# check if the repair works
> +$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV =
| _filter_xfs_io
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/142.out b/tests/btrfs/142.out
> new file mode 100644
> index 0000000..ba4cbbc
> --- /dev/null
> +++ b/tests/btrfs/142.out
> @@ -0,0 +1,39 @@
> +QA output created by 142
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 244056064
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0e8c0000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c00f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c0190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +0e8c01f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ............=
....
> +read 512/512 bytes at offset 244056064
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 7b380e5..a4f97cd 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -143,3 +143,4 @@
>  139 auto qgroup
>  140 auto quick
>  141 auto quick
> +142 auto quick
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
