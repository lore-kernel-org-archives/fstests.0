Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966670AbeBNDau (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Feb 2018 22:30:50 -0500
Date: Wed, 14 Feb 2018 11:30:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] fstests: introduce _scratch_mount_nocheck
Message-ID: <20180214033047.GM18267@eguan.usersys.redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com>
 <20180213091203.22909-2-eguan@redhat.com>
 <CAHc6FU5tmwRRCWt+6qY_Tqpr_f3=3CuvTFumhtVaoz9y_DE+MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5tmwRRCWt+6qY_Tqpr_f3=3CuvTFumhtVaoz9y_DE+MQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 13, 2018 at 03:11:07PM +0100, Andreas Gruenbacher wrote:
> On 13 February 2018 at 10:12, Eryu Guan <eguan@redhat.com> wrote:
> > _fail test by default if _scratch_mount failed and introduce
> > _scratch_mount_nocheck for tests that need to check mount results
> > themselves.
> >
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---

[snip]

> > --- a/common/rc
> > +++ b/common/rc
> > @@ -352,13 +352,18 @@ _supports_filetype()
> >         esac
> >  }
> >
> > +_scratch_mount_nocheck()
> > +{
> > +       if [ "$FSTYP" == "overlay" ]; then
> > +               _overlay_scratch_mount $*
> > +               return $?
> > +       fi
> > +       _mount -t $FSTYP `_scratch_mount_options $*`
> > +}
> > +
> >  _scratch_mount()
> >  {
> > -    if [ "$FSTYP" == "overlay" ]; then
> > -        _overlay_scratch_mount $*
> > -        return $?
> > -    fi
> > -    _mount -t $FSTYP `_scratch_mount_options $*`
> > +       _scratch_mount_nocheck $* || _fail "_scratch_mount failed"
> 
> I'd change that to "mount failed"; the name of the helper function
> isn't very interesting.

I think it'd be easier to know which mount fails, but sure, I have no
strong preference on it.

> 
> >  }
> >
> >  _scratch_unmount()
> > @@ -397,7 +402,7 @@ _scratch_cycle_mount()
> >         opts="-o $opts"
> >      fi
> >      _scratch_unmount
> > -    _scratch_mount "$opts"
> > +    _scratch_mount_nocheck "$opts" || _fail "_scratch_cycle_mount failed"
> 
> Same here, change to "cycle mount failed" or similar.

OK.

And thanks for the testing feedback!

Eryu
