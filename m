Received: from mx1.redhat.com ([209.132.183.28]:56858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752259AbdLGER6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Dec 2017 23:17:58 -0500
Date: Thu, 7 Dec 2017 12:17:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/3] generic/470: Test RWF_NOWAIT
Message-ID: <20171207041756.GZ2749@eguan.usersys.redhat.com>
References: <20171129163358.19759-1-rgoldwyn@suse.de>
 <20171129163358.19759-2-rgoldwyn@suse.de>
 <20171206100551.GV2749@eguan.usersys.redhat.com>
 <0de5a92c-5718-6b09-bd8c-6b673f48662c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de5a92c-5718-6b09-bd8c-6b673f48662c@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 06, 2017 at 10:35:06AM -0600, Goldwyn Rodrigues wrote:
> 
> 
> On 12/06/2017 04:05 AM, Eryu Guan wrote:
> > On Wed, Nov 29, 2017 at 10:33:57AM -0600, Goldwyn Rodrigues wrote:
> >> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>
> >> Tests the RWF_NOWAIT flag so the I/O returns immediately with -EAGAIN
> >> on a new file since it requires block allocation.
> >>
> >> It creates a file, syncs it, and overwrites the file with RWF_NOWAIT.
> >> This should succeed.
> >>
> >> Finally, read the contents to make sure the overwrite is successful.
> >>
> >> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>
> >> Changes since v1:
> >>  - Fix testdir name
> >>  - use of $XFS_IO_PROG instead of xfs_io
> >>  - check pwrite accepts -N
> >>
> >> Changes since v2:
> >>  - corrected test description and improved documentation
> >>  - new leaner look ;)
> >>  - rw group
> >> ---
> >>  tests/generic/470     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/generic/470.out | 13 +++++++++
> >>  tests/generic/group   |  1 +
> >>  3 files changed, 88 insertions(+)
> >>  create mode 100755 tests/generic/470
> >>  create mode 100644 tests/generic/470.out
> >>
> >> diff --git a/tests/generic/470 b/tests/generic/470
> >> new file mode 100755
> >> index 00000000..5580718b
> >> --- /dev/null
> >> +++ b/tests/generic/470
> >> @@ -0,0 +1,74 @@
> >> +#! /bin/bash
> >> +# FS QA Test No. 470
> >> +#
> >> +# write a file with RWF_NOWAIT and it would fail because there are no
> >> +# blocks allocated. Create a file with direct I/O and re-write it
> >> +# using RWF_NOWAIT. I/O should finish within 50 microsecods since
> >> +# block allocations are already performed.
> >> +#
> >> +#-----------------------------------------------------------------------
> >> +# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
> >> +#
> >> +# This program is free software; you can redistribute it and/or
> >> +# modify it under the terms of the GNU General Public License as
> >> +# published by the Free Software Foundation.
> >> +#
> >> +# This program is distributed in the hope that it would be useful,
> >> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> +# GNU General Public License for more details.
> >> +#
> >> +# You should have received a copy of the GNU General Public License
> >> +# along with this program; if not, write the Free Software Foundation,
> >> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> +#-----------------------------------------------------------------------
> >> +
> >> +seq=`basename $0`
> >> +seqres=$RESULT_DIR/$seq
> >> +echo "QA output created by $seq"
> >> +
> >> +here=`pwd`
> >> +tmp=/tmp/$$
> >> +status=1    # failure is the default!
> >> +
> >> +# get standard environment, filters and checks
> >> +. ./common/rc
> >> +. ./common/populate
> >> +. ./common/filter
> >> +. ./common/attr
> >> +
> >> +# real QA test starts here
> >> +_supported_os Linux
> >> +_require_odirect
> >> +_require_test
> >> +_require_xfs_io_command pwrite -N
> >> +
> >> +# Remove reminiscence of previously run tests
> >> +testdir=$TEST_DIR/$seq
> >> +if [ -e $testdir ]; then
> >> +	rm -Rf $testdir
> >> +fi
> >> +
> >> +mkdir $testdir
> >> +
> >> +# Create a file with pwrite nowait (will fail with EAGAIN)
> >> +$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> > 
> > It's weird that I got "Operation not supported" message here and test
> > failed as
> > 
> > @@ -1,5 +1,5 @@
> >  QA output created by 470
> > -pwrite: Resource temporarily unavailable
> > +pwrite: Operation not supported
> >  wrote 8388608/8388608 bytes at offset 0
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  RWF_NOWAIT time is within limits.
> > 
> > I was using latest for-next branch of upstream xfsprogs, and a
> > pre-v4.15-rc1 kernel shipped by Fedora rawhide. A simple test showed:
> 
> What is the output of uname -a
> It should be compatible with 4.13 onward. OTOH, _require_xfs_io_command
> will catch that.

Linux localhost 4.15.0-0.rc0.git6.1.fc28.x86_64 #1 SMP Mon Nov 20 18:08:48 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

_require_xfs_io_command doesn't run "pwrite -N" with "-V 1" option, so
test there passes, it only fails with vectors specified

# rm /mnt/xfs/testfile
# xfs_io -fdc "pwrite -N 0 4k" /mnt/xfs/testfile
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0000 sec (787.402 KiB/sec and 196.8504 ops/sec)
# rm /mnt/xfs/testfile
# xfs_io -fdc "pwrite -N -V 1 0 4k" /mnt/xfs/testfile
pwrite: Operation not supported

That's why I was asking if we should include "-V 1" in
_require_xfs_io_command in patch 1.

> 
> > 
> > rm -f /mnt/xfs/testfile
> > xfs_io -fdc "pwrite -N -V 1 -b 4k 0 4k" /mnt/xfs/testfile
> > pwrite: Operation not supported
> 
> For kernels which do not support RWF_NOWAIT, it will return EOPNOTSUPP.
> 
> > 
> > But an strace run showed pwritev2 did -1 and set EAGAIN as errno, but
> > printed "Operation not supported" as error message:
> > ...
> > pwritev2(3, [{iov_base="\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., iov_len=4096}], 1, 0, RWF_NOWAIT) = -1 EAGAIN (Resource temporarily unavailable)
> > dup(2)                                  = 4
> > fcntl(4, F_GETFL)                       = 0x402 (flags O_RDWR|O_APPEND)
> > openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > fstat(4, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
> > write(4, "pwrite: Operation not supported\n", 32pwrite: Operation not supported
> > ...
> > 
> > Not sure what happened yet, did I miss anything?
> 
> Did you trim any lines in between? If you had another error in between
> before you collect -EAGAIN, it most likely overwrote the value. Not sure
> what is going on though..

No, I didn't trim any lines in between.

> 
> > 
> >> +
> >> +# Write the file without nowait
> >> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1 | _filter_xfs_io
> > 
> > I think "-w" (fdatasync) can be removed? We already use "-W" (fsync) here.
> > 
> >> +
> >> +time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
> >> +
> >> +# RWF_NOWAIT should finish within a short period of time. Anything longer
> >> +# means it is waiting for something in the kernel which would be a fail.
> >> +if (( $(echo "$time_taken < 0.05" | bc -l) )); then
> > 
> > Better to describe where does this 0.05 come from.
> > 
> 
> No significance as such, but a conservative value for the operation to
> be completed. If you want me to explicitly put 50 ms, I can.

There should be a reason for this 50ms estimation. IMHO, as simple as "a
conservative value for the operation to be completed" would be better
than nothing :)

Thanks,
Eryu
