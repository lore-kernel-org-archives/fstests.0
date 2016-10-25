Received: from mx1.redhat.com ([209.132.183.28]:52848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754076AbcJYHMY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Oct 2016 03:12:24 -0400
Date: Tue, 25 Oct 2016 15:11:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/054: only filter ROOT_INO at the beginning
Message-ID: <20161025071153.GS27776@eguan.usersys.redhat.com>
References: <1477114796-19019-1-git-send-email-eguan@redhat.com>
 <20161025055016.GB14023@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161025055016.GB14023@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 25, 2016 at 04:50:16PM +1100, Dave Chinner wrote:
> On Sat, Oct 22, 2016 at 01:39:56PM +0800, Eryu Guan wrote:
> > In the test ROOT_INO is filtered out or replaced, but if ROOT_INO is
> > also 32, more "32"s are filtered or replaced than expected. This
> > happens to me when testing 512B block size XFS and 1k block size CRC
> > enabled XFS.
> > 
> > Also the ROOT_INO should be the inode number of TEST_DIR not
> > SCRATCH_MNT.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  tests/xfs/054 | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/xfs/054 b/tests/xfs/054
> > index 7d08f8a..578b752 100755
> > --- a/tests/xfs/054
> > +++ b/tests/xfs/054
> > @@ -52,13 +52,13 @@ _require_test
> >  _require_xfs_io_command "inode"
> >  
> >  # We know the root inode is there
> > -ROOT_INO=`ls -id $SCRATCH_MNT | awk '{print $1}'`
> > +ROOT_INO=`ls -id $TEST_DIR | awk '{print $1}'`
> >  
> >  touch $TEST_DIR/file
> >  
> >  $XFS_IO_PROG -c "inode"       $TEST_DIR/file
> >  $XFS_IO_PROG -c "inode -v"    $TEST_DIR/file | \
> > -		grep -vw $ROOT_INO | sed -e s/.*:/LAST:/g
> > +		grep -vw "^$ROOT_INO" | sed -e s/.*:/LAST:/g
> 
> So all of these sed expressions have the modifier "/g" on
> them, which means "replace every matching occurrence on the line".
> If all we want to do is replace the first match, then we should be
> dropping the "g" modifier from the sed expressions...

I thought about this too, but it only works for "replace" in sed, not
for the "grep -vw" part. One of the problems here is that "grep -vw" is
filtering out more lines, so adding "^" is still needed for grep.

OTOH, all the "g" modifiers in this test seem not necessary to me, I'll
remove all "g"s in v2.

Thanks for the review!

Eryu
