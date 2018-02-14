Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966588AbeBNDVE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Feb 2018 22:21:04 -0500
Date: Wed, 14 Feb 2018 11:21:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] fstests: use _scratch_mount_nocheck where
 appropriate in tests
Message-ID: <20180214032101.GL18267@eguan.usersys.redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com>
 <20180213091203.22909-3-eguan@redhat.com>
 <20180213233140.GA5208@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213233140.GA5208@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 13, 2018 at 03:31:40PM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2018 at 05:12:03PM +0800, Eryu Guan wrote:
> > Also remove redundant status checks of _scratch_mount.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> 
> <skipping to the generic and xfs tests>
> 
> > diff --git a/tests/generic/054 b/tests/generic/054
> > index 12f471a19090..84b8271a11bd 100755
> > --- a/tests/generic/054
> > +++ b/tests/generic/054
> > @@ -83,7 +83,7 @@ for s in sync nosync ; do
> >  
> >  	# mount the FS
> >  	_echofull "mount"
> > -	if ! _scratch_mount >>$seqres.full 2>&1; then
> > +	if ! _scratch_mount_nocheck >>$seqres.full 2>&1; then
> >  	    _echofull "mount failed: $MOUNT_OPTIONS"
> >  	    continue
> >  	fi
> > @@ -118,7 +118,7 @@ for s in sync nosync ; do
> >  	_print_logstate
> >  
> >  	_echofull "mount with replay"
> > -	_scratch_mount >>$seqres.full 2>&1 \
> > +	_scratch_mount_nocheck >>$seqres.full 2>&1 \
> >  	    || _fail "mount failed: $MOUNT_OPTIONS"
> 
> nocheck || fail ??
> 
> I wonder if the fail message should always spit out the mount options
> that were tried?

Seems there's no need to do so in this case, as we know what
$MOUNT_OPTIONS we're using. We could dump the specific mount options if
the test uses non-default options and really cares about it, and this
should be done case-by-case.

> 
> > diff --git a/tests/generic/068 b/tests/generic/068
> > index bd12278cdd25..91b327866c54 100755
> > --- a/tests/generic/068
> > +++ b/tests/generic/068
> > @@ -62,7 +62,7 @@ echo "*** MKFS ***"                         >>$seqres.full
> >  echo ""                                     >>$seqres.full
> >  _scratch_mkfs                               >>$seqres.full 2>&1 \
> >      || _fail "mkfs failed"
> > -_scratch_mount                              >>$seqres.full 2>&1 \
> > +_scratch_mount_nocheck                      >>$seqres.full 2>&1 \
> >      || _fail "mount failed"
> 
> Can this remain _scratch_mount, since we _fail anyway?
> 
> (There are more of these scattered throughout.)

Sure. I thought it'd be better to keep dumping mount error message to
$seqres.full and keep the pretty format :) But seems that's not
necessary, the error message would break golden image anyway.

I'll revisit the tests with similar patterns.

Thanks,
Eryu
