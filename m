Received: from mx1.redhat.com ([209.132.183.28]:46794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165047AbdDXFcp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Apr 2017 01:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FCC0C04B942
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2017 05:32:44 +0000 (UTC)
Date: Mon, 24 Apr 2017 13:32:42 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic: test eofblocks race with file extending aio dio
 writes
Message-ID: <20170424053242.GN5081@dhcp12-143.nay.redhat.com>
References: <1492701663-9209-1-git-send-email-zlang@redhat.com>
 <20170420182228.GA47198@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420182228.GA47198@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 20, 2017 at 02:22:30PM -0400, Brian Foster wrote:
> On Thu, Apr 20, 2017 at 11:21:03PM +0800, Zorro Lang wrote:
> > It's possible for post-eof blocks to end up being used for direct I/O
> > writes. dio write performs an upfront unwritten extent allocation, sends
> > the dio and then updates the inode size (if necessary) on write
> > completion. If a file release occurs while a file extending dio write is
> > in flight, it is possible to mistake the post-eof blocks for speculative
> > preallocation and incorrectly truncate them from the inode. This means
> > that the resulting dio write completion can discover a hole and allocate
> > new blocks rather than perform unwritten extent conversion.
> > 
> > A kernel warning can be reproduced by generic/299 on XFS:
> >   XFS: Assertion failed: tp->t_blk_res_used <= tp->t_blk_res, \
> >        file: fs/xfs//xfs_trans.c, line: 309
> > 
> 
> It might be important to point out that this test also exposes file
> corruption and/or stale data exposure. E.g., the verification of written
> data is an important distinction between this test and generic/299.

Sure, I'll add that. Hah, Sorry I pasted your commit log at here directly :)

> 
> > The root cause is that xfs_free_eofblocks() uses i_size to truncate
> > post-eof blocks from the inode, but async, file extending direct writes
> > do not update i_size until write completion, long after inode locks are
> > dropped. Therefore, xfs_free_eofblocks() effectively truncates the inode
> > to the incorrect size.
> > 
> > For cover this filesystem corruption testing, write this new case to
> > check data integrality manually, not only depend on a kernel warning.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > This case is similar with generic/114 which use same aio-dio-eof-race.c
> > program. I was planning to write an aio writer, but I found there's
> > already a good program written by Eric, so I turn to use it directly :)
> > 
> 
> Well, that is convenient. ;) A few quick notes...

Yeah, but I've written one, then I found this one T_T..

> 
> > This case is different with g/114, this case runs aio-dio-eof-race
> > with an "open & close" process together. This multi-processes
> > maybe trigger a free_eofblocks race with file extending dio write.
> > 
> > Thanks,
> > Zorro
> > 
> > 
> >  tests/generic/426     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/426.out |  2 ++
> >  tests/generic/group   |  1 +
> >  3 files changed, 90 insertions(+)
> >  create mode 100755 tests/generic/426
> >  create mode 100644 tests/generic/426.out
> > 
> > diff --git a/tests/generic/426 b/tests/generic/426
> > new file mode 100755
> > index 0000000..ff022ad
> > --- /dev/null
> > +++ b/tests/generic/426
> > @@ -0,0 +1,87 @@
> > +#! /bin/bash
> > +# FS QA Test 426
> > +#
> > +# Try to trigger a race of free eofblocks and file extending dio writes.
> > +# A known bug of XFS has been fixed by "e4229d6 xfs: fix eofblocks race
> > +# with file extending async dio writes"
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
> > +	cd /
> > +	rm -f $tmp.*
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
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_aiodio aio-dio-eof-race
> > +
> 
> It looks like this tool doesn't do a ton of writing... up to 8MB. Has
> that proven to be a reliable reproducer in your testing so far? I'm kind
> of wondering if we should update that tool with a flag to accept a
> configurable file size, but that's not a big deal if the reproducer is
> reliable.

Yes, compare with the original reproducer of this bug, aio-dio-eof-race
do leass writing. For reproduce this bug, I increase the frequence of
open & close (no sleep 1), then the bug still can be reproduced as my
testing with very high reproducible.

I was thinking if I should change aio-dio-eof-race.c, because I don't know
if it always can be 100% reproduced on high performance machine.

> 
> > +# limit the filesystem size, to save the time of filling filesystem
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> 
> That's 1G... I wonder if we can get away with smaller (a couple hundred
> MB perhaps?), since we have to fill the whole thing first.

Sure, how about 512MB or 256MB? What's the minimum hint size of XFS?

> 
> > +# try to write more bytes than filesystem size to fill the filesystem
> > +$XFS_IO_PROG -f -c "pwrite -S 0x55 0 $((1024 * 1024 * 1024 * 2))" \
> > +	     $SCRATCH_MNT/fillfs-$seq 2>/dev/null
> > +rm -f $SCRATCH_MNT/fillfs-$seq
> > +
> > +# start a background aio writer, which does several extending loops
> > +# internally and check data integrality
> > +$AIO_TEST $SCRATCH_MNT/tst-aio-dio-eof-race.$seq &
> > +aio_pid=$!
> > +
> > +# open & close the file frequently, to trigger xfs_free_eofblocks
> > +while true; do
> > +	cat $SCRATCH_MNT/tst-aio-dio-eof-race.$seq >/dev/null 2>&1
> > +done &
> > +open_close_pid=$!
> > +
> 
> We probably want to start the open/close loop before the writer to
> reduce the chances of the writer doing much work before the open/close
> loop actually starts.
> 
> I also wonder if something like the following would be better than using
> cat:
> 
> while true; do
> 	exec 3<>$SCRATCH_MNT/tst-aio-dio-eof-race.$seq
> 	exec 3<>-
> done
> 
> ... because we can skip useless reads of the file. Something like
> '$XFS_IO -c open <file>' may be another option as well.

Sure, that's better !

> 
> Brian
> 
> > +wait $aio_pid
> > +status=$?
> > +kill $open_close_pid
> > +wait $open_close_pid
> > +if [ $status -ne 0 ]; then
> > +	od -t x1 $SCRATCH_MNT/tst-aio-dio-eof-race.$seq >> $seqres.full
> > +	exit
> > +fi
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/426.out b/tests/generic/426.out
> > new file mode 100644
> > index 0000000..ad7a01a
> > --- /dev/null
> > +++ b/tests/generic/426.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 426
> > +Success, all done.
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 6d6e4f6..70c36f9 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -428,3 +428,4 @@
> >  423 auto quick
> >  424 auto quick
> >  425 auto quick attr
> > +426 auto aio rw
> > -- 
> > 2.7.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
