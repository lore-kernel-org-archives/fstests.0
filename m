Received: from mx1.redhat.com ([209.132.183.28]:15517 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfAVEzH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 23:55:07 -0500
Date: Tue, 22 Jan 2019 12:58:54 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore
 output
Message-ID: <20190122045854.GE2255@dhcp-12-149.nay.redhat.com>
References: <20190119024258.6864-1-zlang@redhat.com>
 <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard>
 <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 22, 2019 at 05:33:19AM +0200, Amir Goldstein wrote:
> On Tue, Jan 22, 2019 at 12:44 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sat, Jan 19, 2019 at 10:42:58AM +0800, Zorro Lang wrote:
> > > After fsstress has new operation, xfs/068 has different dump output,
> > > so change the expected number of files and directories.
> > >
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/xfs/068.out | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/xfs/068.out b/tests/xfs/068.out
> > > index fa3a5523..f9ec37b8 100644
> > > --- a/tests/xfs/068.out
> > > +++ b/tests/xfs/068.out
> > > @@ -22,7 +22,7 @@ xfsrestore: session id: ID
> > >  xfsrestore: media ID: ID
> > >  xfsrestore: searching media for directory dump
> > >  xfsrestore: reading directories
> > > -xfsrestore: 383 directories and 1335 entries processed
> > > +xfsrestore: 416 directories and 1373 entries processed
> >
> > Shouldn't you tell fsstress to avoid this new operation so none of
> > the tests that rely on the number of files created by a specific
> > fstress seed break?
> >
> > i.e. changing FSSTRESS_AVOID in common/dump as is done already to
> > turn off dedupe/clone/copy_file_range for xfsdump/restore tests?
> >
> 
> IIRC, dedupe/clone/copy_file_range were blacklisted not for not
> changing golden output, but because they make the golden output
> dependent on xfs reflink feature (i.e. on mkfs options).
> 
> This is not the case with the newly added SPLICE operation and
> updating the golden output rather than blacklisting the new operation
> is what was decided and done two times in recent history (also patches
> by Zorro).

Yes, I saw that FSSTRESS_AVOID in common/dump. But I thought (if I'm wrong
please feel free to correct me):
1) dedupe/clone/copyrange might not be compiled in fsstress, they depend
   on "#ifndef ... #endif". That will make different xfsdump/restore output
   when a fs with or without these operations. Then there's not a fixed 068.out.
   So they must be avoided.
2) splice syscall is an old common function, which is first appeared in Linux
   2.6.17. So I think it's safe to be added.
3) Either change common/dump or xfs/068.out doesn't take much time/code, so I
   decided to change 068.out to make x/068 to do operations.

Thanks,
Zorro

> 
> Thanks,
> Amir.
