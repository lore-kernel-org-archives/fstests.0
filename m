Received: from mail-wm0-f67.google.com ([74.125.82.67]:37149 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeGEGFt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Jul 2018 02:05:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so8788854wmh.2
        for <fstests@vger.kernel.org>; Wed, 04 Jul 2018 23:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <1530754623-2694-1-git-send-email-liuyd.fnst@cn.fujitsu.com>
 <20180705040212.GC5703@magnolia> <20180705054945.GB2780@desktop>
In-Reply-To: <20180705054945.GB2780@desktop>
From: Lu Fengqi <curiouslfq@gmail.com>
Date: Thu, 5 Jul 2018 14:05:36 +0800
Message-ID: <CALS+E5DjYB0JKX98gfZZpYfLpKVV0RBsbr065JtuBParJjaQvw@mail.gmail.com>
Subject: Re: [PATCH ] xfs/262: remove -y parameter
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: darrick.wong@oracle.com, liuyd.fnst@cn.fujitsu.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu Guan <guaneryu@gmail.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=885=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 04, 2018 at 09:02:12PM -0700, Darrick J. Wong wrote:
> > On Thu, Jul 05, 2018 at 09:37:03AM +0800, Liu Yiding wrote:
> > > Since commit 66f7b4c2ce14 ("xfs_scrub: remove -y parameter") has remo=
ved parameter -y, -y is an invalid option.
>
> But I couldn't find this commit in xfsprogs repo
> git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
>
> Is it already upstream?

This commit seems in xfstest-dev.

-------------------------------------------------------------
Thanks,
Lu

>
> > >
> > > Signed-off-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> >
> > Good catch!
> >
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>
> Thanks for the review!
>
> Eryu
>
> >
> > --D
> >
> > > ---
> > >  tests/xfs/262 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/xfs/262 b/tests/xfs/262
> > > index 6c39268..b109f93 100755
> > > --- a/tests/xfs/262
> > > +++ b/tests/xfs/262
> > > @@ -48,7 +48,7 @@ done
> > >  LD_LIBRARY_PATH=3D$SCRATCH_MNT $LDD_PROG $SCRATCH_MNT/xfs_scrub >> $=
seqres.full
> > >
> > >  echo "Force online repairs"
> > > -XFS_SCRUB_FORCE_REPAIR=3D1 LD_LIBRARY_PATH=3D$SCRATCH_MNT $SCRATCH_M=
NT/xfs_scrub -dTvy $SCRATCH_MNT >> $seqres.full
> > > +XFS_SCRUB_FORCE_REPAIR=3D1 LD_LIBRARY_PATH=3D$SCRATCH_MNT $SCRATCH_M=
NT/xfs_scrub -dTv $SCRATCH_MNT >> $seqres.full
> > >
> > >  # success, all done
> > >  status=3D0
> > > --
> > > 2.7.4
> > >
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
