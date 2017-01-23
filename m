Received: from mx1.redhat.com ([209.132.183.28]:36806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdAWDlK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 22 Jan 2017 22:41:10 -0500
Date: Mon, 23 Jan 2017 11:41:09 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [RFC PATCH] check: add flag file to stop running xfstests
Message-ID: <20170123034108.xwmaer6mifuxxwfa@XZHOUW.usersys.redhat.com>
References: <1484903008-32422-1-git-send-email-xzhou@redhat.com>
 <20170120164410.GN14033@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120164410.GN14033@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 20, 2017 at 08:44:10AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 20, 2017 at 05:03:28PM +0800, Xiong Zhou wrote:
> > Check if file /tmp/.stopxfstests exists after every
> > case, break and report if positive.
> > 
> > This could gentlely end a xfstests run, instead of
> > killing processes around.
> > 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  check | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/check b/check
> > index 5a93c94..75ef245 100755
> > --- a/check
> > +++ b/check
> > @@ -472,6 +472,7 @@ else
> >  	trap "_wrapup; exit \$status" 0 1 2 3 15
> >  fi
> >  
> > +rm -f /tmp/.stopxfstests
> >  for section in $HOST_OPTIONS_SECTIONS; do
> >  	OLD_FSTYP=$FSTYP
> >  	OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
> > @@ -595,6 +596,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >  
> >  	for seq in $list
> >  	do
> > +	    if [ -e /tmp/.stopxfstests ] ; then
> > +	        _wrapup
> > +	        echo "WARN: This is an interruptted run."
> 
> "interrupted"
> 
> And, uh, why do we need the ability to programmatically kill xfstests?

Forget it, it's from one of my weird need.

Sometimes I wanna end a running xfstests started by cron, peacefully.

> 
> > +	        echo
> > +                _test_unmount 2> /dev/null
> > +                _scratch_unmount 2> /dev/null
> > +                break 2
> 
> Weird indentation...?

Good catch.

Thanks,
Xiong
> 
> --D
> 
> > +            fi
> >  	    err=false
> >  	    if [ ! -f $seq ]; then
> >  	        # Try to get full name in case the user supplied only seq id
> > -- 
> > 1.8.3.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
