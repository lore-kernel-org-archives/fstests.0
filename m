Received: from mail-pf1-f196.google.com ([209.85.210.196]:43987 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfIONNl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Sep 2019 09:13:41 -0400
Date: Sun, 15 Sep 2019 21:13:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Verify falloc on multiple holes won't
 cause qgroup reserved data space leak
Message-ID: <20190915131319.GM2622@desktop>
References: <20190915072230.25732-1-wqu@suse.com>
 <CAL3q7H5w03tHwMa2-yv3A3zXdavhF=Ej0xEM++VReoSxX+NaEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5w03tHwMa2-yv3A3zXdavhF=Ej0xEM++VReoSxX+NaEA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 15, 2019 at 10:21:14AM +0100, Filipe Manana wrote:
> On Sun, Sep 15, 2019 at 8:32 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > Add a test case where falloc is called on multiple holes with qgroup
> > enabled.
> >
> > This can cause qgroup reserved data space leak and false EDQUOT error
> > even we're not reaching the limit.
> >
> > The fix is titled:
> > "btrfs: qgroup: Fix the wrong target io_tree when freeing
> >  reserved data space"
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > changelog:
> > v2:
> > - Remove the unnecessary loop
> >   The loop itself is just to ensure we leak as much space as possible.
> >   However even one loop is already enough to fail the final
> >   verification write, so remove the loop and modify the golden output.
> > ---
> >  tests/btrfs/192     | 70 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/192.out |  8 ++++++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 79 insertions(+)
> >  create mode 100755 tests/btrfs/192
> >  create mode 100644 tests/btrfs/192.out
> >
> > diff --git a/tests/btrfs/192 b/tests/btrfs/192
> > new file mode 100755
> > index 00000000..1abd7838
> > --- /dev/null
> > +++ b/tests/btrfs/192
> > @@ -0,0 +1,70 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 192
> > +#
> > +# Test if btrfs is going to leak qgroup reserved data space when
> > +# falloc on multiple holes fails.
> > +# The fix is titled:
> > +# "btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space"
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_xfs_io_command falloc
> > +
> > +_scratch_mkfs > /dev/null
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> > +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> > +$BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
> > +
> > +# Create a file with the following layout:
> > +# 0         128M      256M      384M
> > +# |  Hole   |4K| Hole |4K| Hole |
> > +# The total hole size will be 384M - 8k
> > +truncate -s 384m "$SCRATCH_MNT/file"
> > +$XFS_IO_PROG -c "pwrite 128m 4k" -c "pwrite 256m 4k" \
> > +       "$SCRATCH_MNT/file" | _filter_xfs_io
> > +
> > +# Falloc 0~384M range, it's going to fail due to the qgroup limit
> > +$XFS_IO_PROG -c "falloc 0 384m" "$SCRATCH_MNT/file" |\
> > +       _filter_xfs_io_error
> 
> This can be in a single line, as it doesn't go beyond 80 characters.
> It doesn't hurt, but the use of the error filter isn't necessary here
> at the moment.
> 
> > +rm "$SCRATCH_MNT/file"
> 
> rm -f, in case one has  " alias rm='rm -i' " in its environment.
> 
> > +
> > +# Ensure above delete reaches disk and free some space
> > +sync
> > +
> > +# We should be able to write at least 3/4 of the limit
> > +$XFS_IO_PROG -f -c "pwrite 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
> > new file mode 100644
> > index 00000000..654adf48
> > --- /dev/null
> > +++ b/tests/btrfs/192.out
> > @@ -0,0 +1,8 @@
> > +QA output created by 192
> > +wrote 4096/4096 bytes at offset 134217728
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 4096/4096 bytes at offset 268435456
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +fallocate: Disk quota exceeded
> > +wrote 201326592/201326592 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 2474d43e..160fe927 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -194,3 +194,4 @@
> >  189 auto quick send clone
> >  190 auto quick replay balance qgroup
> >  191 auto quick send dedupe
> > +192 auto qgroup fast enospc limit
> 
> fast -> quick?
> (we don't have a group named "fast" yet)

Yeah, I've changed it to 'quick' on commit. And I can fix your other
comments on commit as well.

> 
> Anyway, small things that can be fixed at commit time.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for the review!

Eryu
