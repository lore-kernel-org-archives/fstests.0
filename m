Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40391 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862AbcBDVG4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 4 Feb 2016 16:06:56 -0500
Date: Fri, 5 Feb 2016 08:04:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] xfs: support realtime/log device setup changes in
 config sections
Message-ID: <20160204210455.GC31407@dastard>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
 <1453340593-10236-2-git-send-email-david@fromorbit.com>
 <20160202043633.GD11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160202043633.GD11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 02, 2016 at 12:36:33PM +0800, Eryu Guan wrote:
> On Thu, Jan 21, 2016 at 12:43:11PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Currently changing the devices used by "USE_EXTERNAL" environmental
> > variable is not supported by the config section parsing. Add the
> > functionality so that we can use config sections to test external
> > device configs successfully.
> > 
> > This required tracking down a bug in _check_xfs_filesystem() which
> > was causing a log device to be passed to a test device without an
> > external log device. This was caused by an uninitialised variable in
> > the function. I also added full output file removals to the first
> > couple of generic tests that were failing, because that's where the
> > check failure output ends up in this case.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> 
> Looks good to me. And I ran some tests on NFS/CIFS/XFS/overlay and the
> new _check_device function worked as expected. Just one white space
> issue below
> 
> > ---
> >  common/config     | 63 +++++++++++++++++++++++++++++++++++++++----------------
> >  common/dmflakey   |  3 ++-
> >  common/rc         |  1 +
> >  tests/generic/002 |  2 ++
> >  tests/generic/004 |  2 ++
> >  5 files changed, 52 insertions(+), 19 deletions(-)
> > 
> > diff --git a/common/config b/common/config
> > index cb34fd7..477753e 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -416,6 +416,30 @@ if [ -f "$HOST_OPTIONS" ]; then
> >  	fi
> >  fi
> >  
> > +_check_device()
> > +{
> > +	local name=$1
> > +	local dev_needed=$2
> > +	local dev=$3
> > +
> > +	if [ -z "$dev" ]; then
> > +		if [ "$dev_needed" == "required" ]; then 
> 
> Above line introduced trailing white space.

Fixed, so can I add your reviewed-by?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
