Received: from mail-yb1-f196.google.com ([209.85.219.196]:42049 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWI73 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Jan 2019 03:59:29 -0500
Received: by mail-yb1-f196.google.com with SMTP id l20so452205ybl.9
        for <fstests@vger.kernel.org>; Wed, 23 Jan 2019 00:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20190119024258.6864-1-zlang@redhat.com> <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard> <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
 <20190122045854.GE2255@dhcp-12-149.nay.redhat.com> <20190122222216.GN6173@dastard>
 <20190123034406.GF2255@dhcp-12-149.nay.redhat.com> <CAOQ4uxiPvUnHTYVsq6Tk1ywzR0dc8ySi0WYKKXiD5RDCjoNkAg@mail.gmail.com>
 <20190123084128.GG2255@dhcp-12-149.nay.redhat.com>
In-Reply-To: <20190123084128.GG2255@dhcp-12-149.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Jan 2019 10:59:16 +0200
Message-ID: <CAOQ4uxh=5KY2BcYo84XqVHU7eGN_vxmHMtHwt1EHO93z5RvYzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore output
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 23, 2019 at 10:37 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Jan 23, 2019 at 09:35:47AM +0200, Amir Goldstein wrote:
> > > > > 3) Either change common/dump or xfs/068.out doesn't take much time/code, so I
> > > > >    decided to change 068.out to make x/068 to do operations.
> > > >
> > > > Did you validate that the file count is actually correct?
> > > >
> > > > The file count in these dump/restore tests is how we tell we've
> > > > broken bulkstat iteration - any mismatch on the file count indicates
> > > > bulkstat didn't find something it should have or it counted things
> > > > twice. Hence I'm wary making changes to the file set size the
> > > > dump/restore tests use.
> > > >
> > > > And, really, changing the file set size somewhat invalidates the
> > > > long regression history we have with these existing tests. i.e.
> > > > don't change tests that work correctly unless it's absolutely
> > > > necessary. It only adds to the risk of introducing new bugs.
> > >
> > > Thanks so much for your detailed description :) I'll turn to change
> > > FSSTRESS_AVOID in next V4 patch.
> > >
> >
> > On the same discussion when Zorro added "insert" op, I asked
> > why not convert test to whitelist of ops instead of having to update
> > the blacklist every time fsstress is extended (which happened 3 times
> > since we had this discussion).
> >
> > To my question, Dave answered:
> > (https://marc.info/?l=fstests&m=149013211607727&w=2)
> >
> > > That means dump tests will /never/ exercise new fsstress operations
> > > which, IMO, is much worse than having to keep a test up to date with
> > > new operations.
> > >
> > > i.e. The whole point of adding new operations to fsstress and have
> > > tests run them is that we automatically get coverage of new
> > > functionality. Neutering this for all xfsdump tests by using "-z" is
> > > - philosophically speaking - the wrong thing to do.
> >
> > For the life of me, I cannot follow the logic of how this argument ends
> > up with a decision to update the blacklist. It is just me?
> >
> > Yes, if we use a whitelist we will /never/ exercise new fsstress operations for
> > xfs/068. It may be the wrong thing to do "philosophically speaking" but in
> > practice, we are doing this anyway, just manually every time an op is added.
> >
> > This is just madness.
> >
> > Eryu, can you please step in and end this ordeal once and for all.
> >
> > If we still want to exercise new fsstress ops for xfs/022 and future xfsdump
> > tests (do we?) the solution is quite simple:
> > factor out _create_dumpdir_stress_num_param and pass in whitelist
> > of ops only from xfs/068 and be done with that.
> >
> > Zorro, be the final decision as it may, blacklist or whitelist, the test 068 is
> > currently verifying that the file count is what happened to be the file count
> > after addition of "insert" and "mread/mwrite" ops, which to the best of my
> > knowledge, no one verified is the correct file count.
> >
> > So if we want to leave this test "unchanged", we'd better revert your last two
> > changes to 068.out and resort to Eric's original test output and also
> > exclude (or not include in whitelist) insert/mread/mwrite ops.
>
> :) I don't mind re-adding mread/mwrite operations into FSSTRESS_AVOID.
>
> At that time, we haven't decided either "change 068.out" or "avoid new operations"
> is better. So maybe both are fine (my personal point). But Darrick *had to* brought
> in FSSTRESS_AVOID into common/dump (commit ID: 451504891), he can't change 068.out
> directly due to dedupe/clonerange/copyrange aren't supported by all xfs
> configurations.
>
> So my original point is: change 068.out if add common&stable operations into
> fsstress, otherwise add into FSSTRESS_AVOID in common/dump. As Dave specified
> so many problems of splice(), I don't mind avoiding it. But mread/mwrite are
> common functions, as we've changed 068.out for them, how about keep the current
> code until we find something wrong in the future :)
>

Frankly, I don't care what the decision is only that we properly
document it near the
code and stop having those discussions every time fsstress gets a new op.
I personally don't think that the fact that splice() is broken in
older kernels matters
at all. The argument that different xfs configurations will produce
different output
(which is the case for dedue/clone) is the only argument that is relevant IMO.
I would very much like for Eryu to weight in on the decision.

To be fair, it you do want to keep mread/mwrite (and what about
insert?) than you
should manually check the number of files created by the fsstress configuration
and verify that it matches the number you updated in golden output.
Blindly updating the golden output to whatever the output happens to be was
wrong and we need to fix that.

Thanks,
Amir.
