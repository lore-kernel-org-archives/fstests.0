Received: from mx1.redhat.com ([209.132.183.28]:51184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755257AbeASCvz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 21:51:55 -0500
Date: Fri, 19 Jan 2018 10:51:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v5 2/3] common/filter: Factor out expected XFS warnings
 for assert
Message-ID: <20180119025152.GV3102@eguan.usersys.redhat.com>
References: <20180118084645.GT3102@eguan.usersys.redhat.com>
 <1516272595-3678-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1516272595-3678-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180118182915.GI5606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118182915.GI5606@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: xiao yang <yangx.jy@cn.fujitsu.com>, david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 18, 2018 at 10:29:15AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 18, 2018 at 06:49:54PM +0800, xiao yang wrote:
> > 1) Introduce _require_no_xfs_bug_on_assert helper to check if XFS is built
> >    with CONFIG_XFS_ASSERT_FATAL, and just call _require_no_xfs_debug if
> >    /sys/fs/xfs/debug/bug_on_assert is not available.
> > 
> > 2) Apply _require_no_xfs_bug_on_assert in xfs/098 and xfs/115.
> > 
> > 3) Move filter_xfs_dmesg from xfs/098 to common/filter, and rename
> >    it as _filter_assert_dmesg.
> > 
> > Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  common/filter | 11 +++++++++++
> >  common/xfs    | 12 ++++++++++++
> >  tests/xfs/098 | 20 ++++++++------------
> >  tests/xfs/115 |  7 ++++---
> >  4 files changed, 35 insertions(+), 15 deletions(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index 8e1fdb4..53874a0 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -570,5 +570,16 @@ _filter_aiodio_dmesg()
> >  	    -e "s#$warn9#Intentional warnings in dio_complete#"
> >  }
> >  
> > +# We generate assert related WARNINGs on purpose and make sure test doesn't fail
> > +# because of these warnings. This is a helper for _check_dmesg() to filter out
> > +# them.
> > +_filter_assert_dmesg()
> > +{
> > +	local warn1="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
> > +	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
> > +	sed -e "s#$warn1#Intentional warnings in asswarn#" \
> > +	    -e "s#$warn2#Intentional warnings in assfail#"
> > +}
> > +
> >  # make sure this script returns success
> >  /bin/true
> > diff --git a/common/xfs b/common/xfs
> > index ab58364..a0e03b6 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -625,6 +625,18 @@ _require_no_xfs_debug()
> >  	fi
> >  }
> >  
> > +# Check if XFS is built with CONFIG_XFS_ASSERT_FATAL
> > +_require_no_xfs_bug_on_assert()
> > +{
> > +	if [ -f /sys/fs/xfs/debug/bug_on_assert ]; then
> > +		grep -q "1" /sys/fs/xfs/debug/bug_on_assert && \
> > +		   _notrun "Require XFS built without CONFIG_XFS_ASSERT_FATAL"
> 
> This knob can be written, so perhaps we'd rather just set it to zero
> instead of _notrun?

I thought about it too, in the end I think it's better to not change the
behavior in test, this simplies the code a bit (if we change it, do we
need to change it back after test?) and gives the testers full control
on assert behavior (tester would want a crash in debugging?).

Perhaps we could update the _notrun message a bit to indicate that
bug_on_assert could be turned off if you want test to run.

Thanks,
Eryu
