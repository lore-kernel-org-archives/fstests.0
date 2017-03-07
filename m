Received: from mx1.redhat.com ([209.132.183.28]:53378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754350AbdCGIrs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Mar 2017 03:47:48 -0500
Date: Tue, 7 Mar 2017 16:35:41 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/409-411: remove all after unbind mountpoints
Message-ID: <20170307083541.GM14075@dhcp12-143.nay.redhat.com>
References: <1488872934-20001-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxh_OtLAZadj-Cj+k53mcbmzuKk0qNSrYba7PNsbLC2n-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh_OtLAZadj-Cj+k53mcbmzuKk0qNSrYba7PNsbLC2n-w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 07, 2017 at 10:09:33AM +0200, Amir Goldstein wrote:
> On Tue, Mar 7, 2017 at 9:48 AM, Zorro Lang <zlang@redhat.com> wrote:
> > After some shared subtrees test (bind/slave/shared/private), maybe
> > some dentries isn't freed. For example, EBUSY maybe returned due to
> > some bugs. This patch tries to verify that.
> >
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/generic/409 | 1 +
> >  tests/generic/410 | 1 +
> >  tests/generic/411 | 1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/tests/generic/409 b/tests/generic/409
> > index d7c39d6..76d657f 100755
> > --- a/tests/generic/409
> > +++ b/tests/generic/409
> > @@ -48,6 +48,7 @@ _cleanup()
> >         cd /
> >         rm -f $tmp.*
> >         _clear_mount_stack
> > +       rm -rf $MNTHEAD $mpA $mpB $mpC $mpD
> 
> $mp* are under $MNTHEAD, so why bother listing them here?

Wow yes ;)

> 
> It would be wise to also rm -rf $MNTHEAD before mkdir $MNTHEAD
> or at least mkdir -p $MNTHEAD.
> rm -rf is better because TEST_DIR may have a file by that name
> (e.g. from failure to cleanup after generic/247).

Hmm.. sure I can remove them incidentally in this patch.

Thanks,
Zorro

> 
> >  }
> >
> >  # get standard environment, filters and checks
> > diff --git a/tests/generic/410 b/tests/generic/410
> > index e627cfe..f39b4fe 100755
> > --- a/tests/generic/410
> > +++ b/tests/generic/410
> > @@ -56,6 +56,7 @@ _cleanup()
> >         cd /
> >         rm -f $tmp.*
> >         _clear_mount_stack
> > +       rm -rf $MNTHEAD $mpA $mpB $mpC
> >  }
> >
> >  # get standard environment, filters and checks
> > diff --git a/tests/generic/411 b/tests/generic/411
> > index 414d3a5..e6afaf9 100755
> > --- a/tests/generic/411
> > +++ b/tests/generic/411
> > @@ -37,6 +37,7 @@ _cleanup()
> >         cd /
> >         rm -f $tmp.*
> >         _clear_mount_stack
> > +       rm -rf $MNTHEAD $mpA $mpB $mpC
> >  }
> >
> >  # get standard environment, filters and checks
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
