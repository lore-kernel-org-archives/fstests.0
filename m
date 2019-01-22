Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:49419 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfAVWWT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 17:22:19 -0500
Date: Wed, 23 Jan 2019 09:22:16 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore
 output
Message-ID: <20190122222216.GN6173@dastard>
References: <20190119024258.6864-1-zlang@redhat.com>
 <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard>
 <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
 <20190122045854.GE2255@dhcp-12-149.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122045854.GE2255@dhcp-12-149.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 22, 2019 at 12:58:54PM +0800, Zorro Lang wrote:
> On Tue, Jan 22, 2019 at 05:33:19AM +0200, Amir Goldstein wrote:
> > On Tue, Jan 22, 2019 at 12:44 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Sat, Jan 19, 2019 at 10:42:58AM +0800, Zorro Lang wrote:
> > > > After fsstress has new operation, xfs/068 has different dump output,
> > > > so change the expected number of files and directories.
> > > >
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > >  tests/xfs/068.out | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tests/xfs/068.out b/tests/xfs/068.out
> > > > index fa3a5523..f9ec37b8 100644
> > > > --- a/tests/xfs/068.out
> > > > +++ b/tests/xfs/068.out
> > > > @@ -22,7 +22,7 @@ xfsrestore: session id: ID
> > > >  xfsrestore: media ID: ID
> > > >  xfsrestore: searching media for directory dump
> > > >  xfsrestore: reading directories
> > > > -xfsrestore: 383 directories and 1335 entries processed
> > > > +xfsrestore: 416 directories and 1373 entries processed
> > >
> > > Shouldn't you tell fsstress to avoid this new operation so none of
> > > the tests that rely on the number of files created by a specific
> > > fstress seed break?
> > >
> > > i.e. changing FSSTRESS_AVOID in common/dump as is done already to
> > > turn off dedupe/clone/copy_file_range for xfsdump/restore tests?
> > >
> > 
> > IIRC, dedupe/clone/copy_file_range were blacklisted not for not
> > changing golden output, but because they make the golden output
> > dependent on xfs reflink feature (i.e. on mkfs options).
> > 
> > This is not the case with the newly added SPLICE operation and
> > updating the golden output rather than blacklisting the new operation
> > is what was decided and done two times in recent history (also patches
> > by Zorro).
> 
> Yes, I saw that FSSTRESS_AVOID in common/dump. But I thought (if I'm wrong
> please feel free to correct me):
> 1) dedupe/clone/copyrange might not be compiled in fsstress, they depend
>    on "#ifndef ... #endif". That will make different xfsdump/restore output
>    when a fs with or without these operations. Then there's not a fixed 068.out.
>    So they must be avoided.

> 2) splice syscall is an old common function, which is first appeared in Linux
>    2.6.17. So I think it's safe to be added.

What makes you think it worked in 2.6.17? I mean:

commit 0ff28d9f4674d781e492bcff6f32f0fe48cf0fed
Author: Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Wed May 6 17:26:47 2015 +0200

    splice: sendfile() at once fails for big files
    
    Using sendfile with below small program to get MD5 sums of some files,
    it appear that big files (over 64kbytes with 4k pages system) get a
    wrong MD5 sum while small files get the correct sum.
    This program uses sendfile() to send a file to an AF_ALG socket
    for hashing.
.....

i.e. using sendfile to copy large files resulted in corrupt copies
up until 2015.

Basically, sendfile is a legacy interface that has spend a very
large amount of it's time broken, full of deadlocks (i.e. unusable)
and not used by anyone. It's not something we really want to enable
in xfstests because it will cause all sorts of failures on older
distros...

> 3) Either change common/dump or xfs/068.out doesn't take much time/code, so I
>    decided to change 068.out to make x/068 to do operations.

Did you validate that the file count is actually correct?

The file count in these dump/restore tests is how we tell we've
broken bulkstat iteration - any mismatch on the file count indicates
bulkstat didn't find something it should have or it counted things
twice. Hence I'm wary making changes to the file set size the
dump/restore tests use.

And, really, changing the file set size somewhat invalidates the
long regression history we have with these existing tests. i.e.
don't change tests that work correctly unless it's absolutely
necessary. It only adds to the risk of introducing new bugs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
