Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:7766 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459AbcF0Ajh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 26 Jun 2016 20:39:37 -0400
Date: Mon, 27 Jun 2016 10:39:34 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 1/2] fstests: introduce _require_no_mount_opts helper
Message-ID: <20160627003934.GO27480@dastard>
References: <1466505629-9402-1-git-send-email-eguan@redhat.com>
 <20160621234202.GB27480@dastard>
 <20160622032351.GZ5140@eguan.usersys.redhat.com>
 <20160622230650.GL27480@dastard>
 <20160624045019.GC23649@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160624045019.GC23649@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 24, 2016 at 12:50:19PM +0800, Eryu Guan wrote:
> On Thu, Jun 23, 2016 at 09:06:50AM +1000, Dave Chinner wrote:
> > On Wed, Jun 22, 2016 at 11:23:51AM +0800, Eryu Guan wrote:
> > > On Wed, Jun 22, 2016 at 09:42:02AM +1000, Dave Chinner wrote:
> > > > On Tue, Jun 21, 2016 at 06:40:28PM +0800, Eryu Guan wrote:
> > > > > Some tests require that there's no certain mount option, so
> > > > > introduce a new helper _require_no_mount_opts() to do the check on
> > > > > $MOUNT_OPTIONS.
> > > > 
> > > > I think this is fine, except for the name. It's more of an exclude
> > > > rule rather than a "require" rule. i.e.  _exclude_mount_option() is
> > > > closer to it's purpose.
> > > 
> > > This does look better to me, thanks!
> > > 
> > > > 
> > > > The only other question I have is that mount options can be
> > > > different between test and scratch devices - the test device mount
> > > > options can be set via TEST_FS_MOUNT_OPTS, as well as via
> > > > MOUNT_OPTIONS. Does this rule need to handle that?
> > > 
> > > I didn't think about TEST_FS_MOUNT_OPTS. Currently there's no need to
> > > handle it, MOUNT_OPTIONS is sufficient I think.
> > > 
> > > How about I rename it to _exclude_scratch_mount_option()? And we can
> > > always add another _exclude_test_mount_option() if needed in future.
> > 
> > Sounds good.
> 
> Hi Dave,
> 
> My v4 patches simply rename the helper to this
> "_exclude_scratch_mount_option", no function change. Then I take your
> reviews as a "Reviewed-by" tag based on "I think this is fine, except for
> the name." and the above "Sounds good.". So I can queue them for next
> pull request and start release testing, and don't have to bother you
> providing an explicit reviewed-by.

Yup - it's better to ask thn assume, though, so:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
