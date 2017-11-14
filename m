Received: from mx1.redhat.com ([209.132.183.28]:44630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbdKNJP6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Nov 2017 04:15:58 -0500
Date: Tue, 14 Nov 2017 17:15:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/1] overlay/035: small fix for newer util-linux
Message-ID: <20171114091556.GF17339@eguan.usersys.redhat.com>
References: <7a255645-5148-cd45-c0f7-1645982ca4e9@jp.fujitsu.com>
 <8389cef1-9d9b-a9f2-e5b7-e409e42e2df3@jp.fujitsu.com>
 <CAOQ4uxjwYhJVR38pBbrTtLXfLoW3TaT_2TWEH+BqnU=Rf8Dyrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjwYhJVR38pBbrTtLXfLoW3TaT_2TWEH+BqnU=Rf8Dyrw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 14, 2017 at 10:55:34AM +0200, Amir Goldstein wrote:
> On Tue, Nov 14, 2017 at 3:10 AM, Misono, Tomohiro
> <misono.tomohiro@jp.fujitsu.com> wrote:
> > Modify filter in order make the test run correctly for
> > both old (2.29) and new (2.30) util-linux.
> >
> > Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
> > ---
> >  tests/overlay/035 | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/overlay/035 b/tests/overlay/035
> > index 64fcd708..6f1627c6 100755
> > --- a/tests/overlay/035
> > +++ b/tests/overlay/035
> > @@ -69,7 +69,8 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
> >  $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
> >                         $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
> >  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> > -_scratch_remount rw 2>&1 | _filter_scratch
> > +_scratch_remount rw 2>&1 | _filter_scratch \
> > +       | sed -e "s,SCRATCH_MNT: ,," | sed -e "s,\.$,,"
> >  $UMOUNT_PROG $SCRATCH_MNT
> >
> 
> 
> This change doesn't look right and/or not explained properly.
> Any change to accommodate tool differences should be done
> in the filter helpers, not in an individual test that filters the
> output of a generic helper.

If this is a really cornor case that only affects this case and not
likely affects future tests, I think this one-time fix is fine.

But this is not that case. I found generic/050, xfs/005, xfs/333 and
overlay/03[567] are all affected by the change in util-linux, and in
different ways. So generic helper(s) might be more useful.

I'm now working on a patchset to do the filter using common helpers,
will post them later.

> 
> What is the change 2.29 -> 2.30 that causes the problem?
> Without mentioning this, it is really hard to review if your change is correct.

Agreed, at least please provide both 'old' and 'new' format in the
commit log or comments, that'll be easier to review.

Thanks,
Eryu

> 
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
