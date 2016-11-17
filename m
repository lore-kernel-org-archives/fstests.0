Received: from mail.kernel.org ([198.145.29.136]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755034AbcKQRtC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 Nov 2016 12:49:02 -0500
Date: Thu, 17 Nov 2016 09:48:57 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] generic/392: add a testcase to check some inline
 truncation behaviors
Message-ID: <20161117174857.GA74211@jaegeuk>
References: <20161117034715.71966-1-jaegeuk@kernel.org>
 <20161117090840.GZ27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161117090840.GZ27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 05:08:40PM +0800, Eryu Guan wrote:
> On Wed, Nov 16, 2016 at 07:47:15PM -0800, Jaegeuk Kim wrote:
> > This patch introduces a new testcase to test some small truncations to check
> > inline_data and its cached data are truncated correctly at the same time.
> > 
> > The inline_data feature was introduced in ext4 and f2fs as follows.
> >  ext4 : http://lwn.net/Articles/468678/
> >  f2fs : http://lwn.net/Articles/573408/
> > 
> > The basic idea is embedding small-sized file's data into relatively large
> > inode space.
> > In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
> > In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  tests/generic/392     | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/392.out |  41 ++++++++++++++++
> >  tests/generic/group   |   1 +
> >  3 files changed, 169 insertions(+)
> >  create mode 100644 tests/generic/392
> >  create mode 100644 tests/generic/392.out
> > 
> > diff --git a/tests/generic/392 b/tests/generic/392
> > new file mode 100644
> > index 0000000..7282053
> > --- /dev/null
> > +++ b/tests/generic/392
> > @@ -0,0 +1,127 @@
> > +#! /bin/bash
> > +# FS QA Test No. generic/392
> > +#
> > +# Test some small truncations to check inline_data and its cached data are
> > +# truncated correctly at the same time.
> > +#
> > +# The inline_data feature was introduced in ext4 and f2fs as follows.
> > +#  ext4 : http://lwn.net/Articles/468678/
> > +#  f2fs : http://lwn.net/Articles/573408/
> > +#
> > +# The basic idea is embedding small-sized file's data into relatively large
> > +# inode space.
> > +# In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
> > +# In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2014 Jaegeuk Kim.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> > +# 1. make a file containing inline_data.
> > +# 2. "truncated 0"  is to check cached page #0 was truncated entirely.
> > +# 3. "truncated 50" is to check inline_data was truncated within its inode.
> > +$XFS_IO_PROG -t -f \
> > +	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +	-c "fsync"							 \
> > +	-c "truncate 0"          `# truncate |                        |` \
> > +	-c "truncate 50"         `# truncate |                        |` \
> > +$testfile | _filter_xfs_io
> > +
> > +echo "= truncate inline_data after #0 page was truncated entirely ="
> > +hexdump -C $testfile
> > +_scratch_remount
> 
> _scratch_remount without any options is a no-op. Should be
> _scratch_cycle_mount?
> 
> > +hexdump -C $testfile
> > +rm $testfile
> > +
> > +# 1. make a file containing inline_data.
> > +# 2. "truncated 0"     is to check cached page #0 was truncated entirely.
> > +# 3. "truncated 4096"  is to check inline_data was dismissed and truncated.
> > +$XFS_IO_PROG -t -f \
> > +	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +	-c "fsync"							 \
> > +	-c "truncate 0"          `# truncate |                        |` \
> > +	-c "truncate 4096"       `# truncate |                        |` \
> > +$testfile | _filter_xfs_io
> > +
> > +echo "= truncate dismissed inline_data after #0 page was truncated entirely ="
> > +hexdump -C $testfile
> > +_scratch_remount
> > +hexdump -C $testfile
> > +rm $testfile
> > +
> > +# 1. make a file containing inline_data.
> > +# 2. "truncated 4"   is to check cached page #0 was truncated partially.
> > +# 3. "truncated 50"  is to check inline_data was truncated within its inode.
> > +$XFS_IO_PROG -t -f \
> > +	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +	-c "fsync"							 \
> > +	-c "truncate 4"          `# truncate |XXXX                    |` \
> > +	-c "truncate 50"         `# truncate |XXXX                    |` \
> > +$testfile | _filter_xfs_io
> > +
> > +echo "= truncate inline_data after #0 page was truncated partially ="
> > +hexdump -C $testfile
> > +_scratch_remount
> > +hexdump -C $testfile
> > +rm $testfile
> > +
> > +# 1. make a file containing inline_data.
> > +# 2. "truncated 4"     is to check cached page #0 was truncated partially.
> > +# 3. "truncated 4096"  is to check inline_data was dismissed and truncated.
> > +$XFS_IO_PROG -t -f \
> > +	-c "pwrite -S 0x58 0 40" `# write    |XXXXXXXXXXXXXXXXXXXXXXXX|` \
> > +	-c "fsync"							 \
> > +	-c "truncate 4"          `# truncate |XXXX                    |` \
> > +	-c "truncate 4096"       `# truncate |XXXX                    |` \
> > +$testfile | _filter_xfs_io
> > +
> > +echo "= truncate dismissed inline_data after #0 page was truncated partially ="
> > +hexdump -C $testfile
> > +_scratch_remount
> > +hexdump -C $testfile
> > +rm $testfile
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/392.out b/tests/generic/392.out
> > new file mode 100644
> > index 0000000..a041628
> > --- /dev/null
> > +++ b/tests/generic/392.out
> > @@ -0,0 +1,41 @@
> > +QA output created by 392
> > +wrote 40/40 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > += truncate inline_data after #0 page was truncated entirely =
> > +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00000032
> 
> Seems the output is corrupted. Is it missing a "00000030  00 00" line?

Hmm, in my case, all the filesystems show without that line.

It seems that hexdump gives that differently. When I tested od, I could get this
from all the filesystems.

od /mnt/test/testfile
0000000 000000 000000 000000 000000 000000 000000 000000 000000
*
0000060 000000
0000062

Let me change the patch to use od.

Thanks,

> 
> [root@localhost xfstests]# truncate -s 50 testfile
> [root@localhost xfstests]# hexdump -C testfile
> 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000030  00 00                                             |..|
> 00000032
> 
> I tested with ext4 (with inline_data enabled and disabled), xfs and
> btrfs, they all fail in the same way.
> 
> The full diff:
> 
> @@ -4,9 +4,11 @@
>  = truncate inline_data after #0 page was truncated entirely =
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> +00000030  00 00                                             |..|
>  00000032
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> +00000030  00 00                                             |..|
>  00000032
>  wrote 40/40 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -23,10 +25,12 @@
>  00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
>  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> +00000030  00 00                                             |..|
>  00000032
>  00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
>  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> +00000030  00 00                                             |..|
>  00000032
>  wrote 40/40 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 
> Thanks,
> Eryu
> 
> > +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00000032
> > +wrote 40/40 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > += truncate dismissed inline_data after #0 page was truncated entirely =
> > +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00001000
> > +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00001000
> > +wrote 40/40 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > += truncate inline_data after #0 page was truncated partially =
> > +00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
> > +00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00000032
> > +00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
> > +00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00000032
> > +wrote 40/40 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > += truncate dismissed inline_data after #0 page was truncated partially =
> > +00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
> > +00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00001000
> > +00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
> > +00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > +*
> > +00001000
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 9de3415..1b19010 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -393,3 +393,4 @@
> >  388 auto log metadata
> >  389 auto quick acl
> >  391 auto quick metadata
> > +392 auto quick rw
> > -- 
> > 2.8.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
