Received: from mail-pf0-f196.google.com ([209.85.192.196]:43065 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeGEFtu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Jul 2018 01:49:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so4411564pfm.10
        for <fstests@vger.kernel.org>; Wed, 04 Jul 2018 22:49:50 -0700 (PDT)
Date: Thu, 5 Jul 2018 13:49:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH ] xfs/262: remove -y parameter
Message-ID: <20180705054945.GB2780@desktop>
References: <1530754623-2694-1-git-send-email-liuyd.fnst@cn.fujitsu.com>
 <20180705040212.GC5703@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705040212.GC5703@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Liu Yiding <liuyd.fnst@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 04, 2018 at 09:02:12PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 05, 2018 at 09:37:03AM +0800, Liu Yiding wrote:
> > Since commit 66f7b4c2ce14 ("xfs_scrub: remove -y parameter") has removed parameter -y, -y is an invalid option.

But I couldn't find this commit in xfsprogs repo
git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git

Is it already upstream?

> > 
> > Signed-off-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> 
> Good catch!
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for the review!

Eryu

> 
> --D
> 
> > ---
> >  tests/xfs/262 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/262 b/tests/xfs/262
> > index 6c39268..b109f93 100755
> > --- a/tests/xfs/262
> > +++ b/tests/xfs/262
> > @@ -48,7 +48,7 @@ done
> >  LD_LIBRARY_PATH=$SCRATCH_MNT $LDD_PROG $SCRATCH_MNT/xfs_scrub >> $seqres.full
> >  
> >  echo "Force online repairs"
> > -XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTvy $SCRATCH_MNT >> $seqres.full
> > +XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTv $SCRATCH_MNT >> $seqres.full
> >  
> >  # success, all done
> >  status=0
> > -- 
> > 2.7.4
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
