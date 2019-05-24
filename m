Received: from mail-pf1-f193.google.com ([209.85.210.193]:43060 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390162AbfEXJ5i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 May 2019 05:57:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so5027291pfa.10
        for <fstests@vger.kernel.org>; Fri, 24 May 2019 02:57:37 -0700 (PDT)
Date: Fri, 24 May 2019 17:57:31 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] generic/530: fix shutdown failure of generic/530 in
 overlay
Message-ID: <20190524095731.GO15846@desktop>
References: <1557727865-3745-1-git-send-email-jefflexu@linux.alibaba.com>
 <20190520162847.GA5334@magnolia>
 <CAOQ4uxjbs_YBoikMpntcPtw==n2+R8HAQk+E3BWN4gt1fXf_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjbs_YBoikMpntcPtw==n2+R8HAQk+E3BWN4gt1fXf_kg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 20, 2019 at 10:29:55PM +0300, Amir Goldstein wrote:
> On Mon, May 20, 2019 at 9:18 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > >  # Unmount to prove that we can clean it all
> > >  echo umount >> $seqres.full
> > > diff --git a/tests/xfs/501 b/tests/xfs/501
> > > index 974f341..4be9997 100755
> > > --- a/tests/xfs/501
> > > +++ b/tests/xfs/501
> > > @@ -54,7 +54,9 @@ ulimit -n $max_files
> > >
> > >  # Open a lot of unlinked files
> > >  echo create >> $seqres.full
> > > -$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
> > > +$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
> > > +_scratch_shutdown -f
> >
> > NAK.
> >
> > The whole point of both of these tests is to check the operation of
> > unlinked inode recovery after filesystem failure.  Moving the shutdown
> > call so that it happens after t_open_tmpfiles exits and releases all the
> > fds renders both tests completely broken and pointless.
> >
> > The _require_scratch_shutdown behavior overlayfs (as I was hinting
> > before I left for vacation) is not particularly intuitive, and the next
> > step ought to have been "Ok, the helpers' behavior is intentional and
> > any program that wants to test shutdown has to use a file on the lower
> > fs; how do we pass the necessary control handle to t_open_tmpfiles", not
> > ripping out the offending code without figuring out what the test
> > actually does.
> >
> > IOWS,
> >
> > _scratch_shutdown_handle() {
> >         if [ $FSTYP = "overlayfs" ]; then
> >                 echo "$OVL_BASE_SCRATCH_MNT"
> >         else
> >                 echo "$SCRATCH_MNT"
> >         fi
> > }
> >
> > $here/src/t_open_tmpfiles $SCRATCH_MNT shutdown $(_scratch_shutdown_handle)
> >
> 
> That sounds reasonable to me.
> 
> As a side note, overlayfs doesn't support O_TMPFILE.
> I am not sure if there is any filesystem that doesn't support
> O_TMPFILE which gains
> important coverage from the !try_o_tmpfile code??
> 
> If there isn't, we could just require O_TMPFILE support and be done with that,
> but I guess if we got this far...
> 
> > Oh, it's already upstream, I'll send a revert later <grumble>...
> >
> 
> Hmm, I had a bad feeling about this one.
> I should have said CC-and-wait-for-ack-by Darick.

I should have noticed this on review.. Thanks for the review anyway!

Thanks,
Eryu
