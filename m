Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39569 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbfAWWG2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Jan 2019 17:06:28 -0500
Date: Thu, 24 Jan 2019 09:06:22 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore
 output
Message-ID: <20190123220622.GR6173@dastard>
References: <20190119024258.6864-1-zlang@redhat.com>
 <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard>
 <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
 <20190122045854.GE2255@dhcp-12-149.nay.redhat.com>
 <20190122222216.GN6173@dastard>
 <20190123034406.GF2255@dhcp-12-149.nay.redhat.com>
 <CAOQ4uxiPvUnHTYVsq6Tk1ywzR0dc8ySi0WYKKXiD5RDCjoNkAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiPvUnHTYVsq6Tk1ywzR0dc8ySi0WYKKXiD5RDCjoNkAg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 23, 2019 at 09:35:47AM +0200, Amir Goldstein wrote:
> > > > 3) Either change common/dump or xfs/068.out doesn't take much time/code, so I
> > > >    decided to change 068.out to make x/068 to do operations.
> > >
> > > Did you validate that the file count is actually correct?
> > >
> > > The file count in these dump/restore tests is how we tell we've
> > > broken bulkstat iteration - any mismatch on the file count indicates
> > > bulkstat didn't find something it should have or it counted things
> > > twice. Hence I'm wary making changes to the file set size the
> > > dump/restore tests use.
> > >
> > > And, really, changing the file set size somewhat invalidates the
> > > long regression history we have with these existing tests. i.e.
> > > don't change tests that work correctly unless it's absolutely
> > > necessary. It only adds to the risk of introducing new bugs.
> >
> > Thanks so much for your detailed description :) I'll turn to change
> > FSSTRESS_AVOID in next V4 patch.
> >
> 
> On the same discussion when Zorro added "insert" op, I asked
> why not convert test to whitelist of ops instead of having to update
> the blacklist every time fsstress is extended (which happened 3 times
> since we had this discussion).
> 
> To my question, Dave answered:
> (https://marc.info/?l=fstests&m=149013211607727&w=2)
> 
> > That means dump tests will /never/ exercise new fsstress operations
> > which, IMO, is much worse than having to keep a test up to date with
> > new operations.
> >
> > i.e. The whole point of adding new operations to fsstress and have
> > tests run them is that we automatically get coverage of new
> > functionality. Neutering this for all xfsdump tests by using "-z" is
> > - philosophically speaking - the wrong thing to do.
> 
> For the life of me, I cannot follow the logic of how this argument ends
> up with a decision to update the blacklist. It is just me?

I'm not sure why you are so worked up over this

I was saying that that turning off everything (i.e. -z) and using a
whitelist is the wrong thing to do because it means nobody will ever
consider that xfsdump might need to be tested against that new
fsstress functionality/.

i.e. out of sight, out of mind.

The current blacklist method means that whenever something is added
to fsstress, tests will fail and the person making the modification
will have to consider if that operation should be used in the test
that fails.

That's the whole point - if the test doesn't fail, it nobody ever
considers if the new operation is relevant for xfsdump tests and so
it will never get added. That's bad if we actually need test
coverage of that functionality. However, if the test fails on new
additions, then people will consider whether it should be added or
not, and we discuss it appropriately for *that specific addtion*.

IOWs, using "-z" and a whitelist is philosophically the wrong thing
to do because it means that nobody will ever consider whether tests
using fstress should have new fsstress functionality enabled or
disabled.

> Yes, if we use a whitelist we will /never/ exercise new fsstress operations for
> xfs/068. It may be the wrong thing to do "philosophically speaking" but in
> practice, we are doing this anyway, just manually every time an op is added.

Because all the recent additions are the same. i.e.  fsstress is
just creating regular files differently. It has no impact on xfsdump
does except to change the number of files created and the directory
layout.

If this new functionality were creating a new type of file that
xfsdump has to handle, or adding new attributes or changing the
metadata of the existing files, then we want to make sure xfsdump is
tested against that, and so we'd be changing the golden output after
careful checking that both xfsdump and xfs_restore are working
correctly and the file count is correct.

But when all we are doing is creating normal, regular files just
with a different syscall, it makes no sense to perturb the existing
test then we have to go and validate that the new set of files being
tested is actually scanned correctly, is complete and correct. Using
a blacklist to avoid unnecessary perturbation such as in cases like
this is the right thing to do because we've had to determine if the
new functionality is a useful addition to xfsdump/restore test
coverage or not.

> If we still want to exercise new fsstress ops for xfs/022 and future xfsdump
> tests (do we?) the solution is quite simple:
> factor out _create_dumpdir_stress_num_param and pass in whitelist
> of ops only from xfs/068 and be done with that.
> 
> Zorro, be the final decision as it may, blacklist or whitelist, the test 068 is
> currently verifying that the file count is what happened to be the file count
> after addition of "insert" and "mread/mwrite" ops, which to the best of my
> knowledge, no one verified is the correct file count.

I suspect that it's just commit 5d36d8585afc ("xfs/068: update golden
output due to new operations in fsstress)" that you are ranting
about - the insert operation was added back in 2015 and xfs/068 had
this added to it:

+# need to ensure new fsstress operations don't perturb expected output
+FSSTRESS_AVOID="-f insert=0 $FSSTRESS_AVOID"

Which followed the rules of "don't perturb if unnecessary". This was
removed by the above commit, which didn't follow that rule. And that
happened while I was on sabbatical and so nobody was there to say
"don't do that" or "how did you validate that the count of files is
correct".  It's probably correct given that we haven't seen any
issues for the past 18 months anywhere and we've since added a bunch
of new and reviewed fsstress avoids for xfs/068, so I think this
commit is the anomaly rather than the rule....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
