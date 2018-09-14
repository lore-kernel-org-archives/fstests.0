Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:44694 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbeIODSd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Sep 2018 23:18:33 -0400
Date: Sat, 15 Sep 2018 08:01:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] shared/010: avoid dedupe testing blocked on large fs
Message-ID: <20180914220152.GC16550@dastard>
References: <20180912101547.28835-1-zlang@redhat.com>
 <20180913230121.GB16550@dastard>
 <20180914011345.GJ8382@dhcp-12-152.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914011345.GJ8382@dhcp-12-152.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 14, 2018 at 09:13:45AM +0800, Zorro Lang wrote:
> On Fri, Sep 14, 2018 at 09:01:21AM +1000, Dave Chinner wrote:
> > On Wed, Sep 12, 2018 at 06:15:47PM +0800, Zorro Lang wrote:
> > > When test on large fs (--large-fs), xfstests preallocates a large
> > > file in SCRATCH_MNT/ at first. Duperemove will take too long time
> > > to deal with that large file (many days on 500T XFS). So move
> > > working directory to a sub-dir underlying $SCRATCH_MNT/.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > Besides fix this issue, this patch fix another issue passingly. I left
> > > a bad variable named "testdir" in this case. This patch can fix it.
> > > 
> > > If maintainer feels I should fix it in another patch, please tell me:-P
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  tests/shared/010 | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/shared/010 b/tests/shared/010
> > > index 1817081b..04f55890 100755
> > > --- a/tests/shared/010
> > > +++ b/tests/shared/010
> > > @@ -65,15 +65,17 @@ function end_test()
> > >  sleep_time=$((50 * TIME_FACTOR))
> > >  
> > >  # Start fsstress
> > > +testdir="$SCRATCH_MNT/dir"
> > 
> > Can we not call a temporary on the scratch device "testdir"?
> > 
> > Because the "test dir" name specifically refers to the test device
> > mount point, and using it for anything else (even though it's a
> > different variable) is just confusing.
> > 
> > Call it something like "local_dir" or "work_dir" or "stress_dir".
> > But not "testdir".
> 
> Hmm... by running:
> # grep -rsn testdir xfstests/tests
> 
> I found there're lots of "testdir"... do you need I change them all, or
> just begin to notice this issue from this patch?

Just this test for now, but it would be good to clean up all the
other tests at some point.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
