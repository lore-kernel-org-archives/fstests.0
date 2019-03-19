Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:8934 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfCSBN0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Mar 2019 21:13:26 -0400
Date: Tue, 19 Mar 2019 12:13:21 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and
 rename
Message-ID: <20190319011321.GV26298@dastard>
References: <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard>
 <CAOQ4uxgKj8pAKKra9jv+xTb9dOxG-J5fKvJ_6a_iabWR9RbgrQ@mail.gmail.com>
 <20190305223301.GD26298@dastard>
 <CAOQ4uxggon==2r2hibMvXc4_N4zod+2z0Ycw74eKRn+q1uwYsw@mail.gmail.com>
 <20190306214813.GE26298@dastard>
 <CAOQ4uxjM0-D8c3KR0ooXYhhUa5+19j_=3XUaXf6vGMbsNhShJw@mail.gmail.com>
 <CA+EzBbCuQJen9hSHf8-JSRGG3VPxo9X4ugscMdKuw_A6isHDUQ@mail.gmail.com>
 <20190308043503.GJ26298@dastard>
 <CAHWVdUWuTXw5=RuJ9eLXZnNGDq_YX0En5EHY1z=-Y6n0MxFFbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUWuTXw5=RuJ9eLXZnNGDq_YX0En5EHY1z=-Y6n0MxFFbA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Vijay Chidambaram <vijay@cs.utexas.edu>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

(Sorry, missed this email and only just noticed it...)

On Fri, Mar 08, 2019 at 09:11:19AM -0600, Vijay Chidambaram wrote:
> On Thu, Mar 7, 2019 at 10:35 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 05:19:51PM -0600, Jayashree Mohan wrote:
> > > Hi Amir,
> > >
> > > > I went back to look at similar fsync tests by Filipe:
> > > > generic/{106,107,335,336,341,342,343,348,498,501,502,509,510,512}
> > > >
> > > > I found some alleged subtle mistakes about SOMC assumptions.
> > > >
> > > > generic/336 does:
> > > > touch $SCRATCH_MNT/a/foo
> > > > ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo_link
> > > > touch $SCRATCH_MNT/b/bar
> > > > sync
> > > > unlink $SCRATCH_MNT/b/foo_link
> > > > mv $SCRATCH_MNT/b/bar $SCRATCH_MNT/c/
> > > > $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/foo
> > >
> > > This is probably what's happening in this particular test :
> > >
> > > SOMC requires:
> > >           fsync(a/foo) must ensure unlink(b/foo_link)  (because they
> > > were linked at some point)
> > >
> > > But what happens is:
> > >            fsync(a/foo)          -->  unlink(b/foo_link)
> > >            unlink(b/foo_link)  -->  fsync(b)
> > >            fsync(b)                 -->  rename goes through
> > >
> > > SOMC should only require that the unlink persists.
> >
> > That's a /fsync/ requirement, not SOMC.
> >
> > SOMC says:
> >
> > "If the rename after the fsync()d unlink is present after recovery,
> > then every metadata operation completed between the unlink and the
> > rename must also be present after recovery."
> 
> Isn't this a bit too broad? That sounds more like total ordering of
> metadata operations rather than SOMC. Shouldn't SOMC say "all
> operations dependent upon the rename should be present after recovery
> if rename is present?"

Yes. I was describing the explicit behaivour to expect in the
context of the given example, in which all the operations between
the unlink and rename were dependent operations. You've just
restated it as the general rule that I applied...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
