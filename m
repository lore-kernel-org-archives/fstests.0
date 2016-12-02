Received: from mx1.redhat.com ([209.132.183.28]:60212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752794AbcLBGZg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Dec 2016 01:25:36 -0500
Date: Fri, 2 Dec 2016 14:25:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: cleanups after common/rc split
Message-ID: <20161202062533.GJ29149@eguan.usersys.redhat.com>
References: <20161201042213.16859-1-eguan@redhat.com>
 <20161202032935.GH11750@dastard>
 <20161202033504.GF29149@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202033504.GF29149@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 02, 2016 at 11:35:04AM +0800, Eryu Guan wrote:
...
> > > +	if [ $ok -eq 0 ]; then
> > > +		echo "*** mount output ***"		>>$seqres.full
> > > +		_mount					>>$seqres.full
> > > +		echo "*** end mount output"		>>$seqres.full
> > > +	elif [ "$type" = "xfs" ]; then
> > > +		_mount_or_remount_rw "$extra_mount_options" $device $mountpoint

I looked at this more and I think that a "ok=$?" is missed here
(_mount_or_remount_rw return 1 as success), both
_check_generic_filesystem and _check_btrfs_filesystem do this. So if it
passes the first $ok check then does this rw mount and sets $ok based on
the mount result. I'll just add a "ok=$?" here.

Thanks,
Eryu

> > > +	fi
> > > +
> > > +	if [ $ok -eq 0 ]; then
> > > +		status=1
> > > +		if [ "$iam" != "check" ]; then
> > > +			exit 1
> > > +		fi
> > > +		return 1
> > > +	fi
> > 
> > THese $ok -eq 0 cases can be combined.
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
