Received: from mx1.redhat.com ([209.132.183.28]:55992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbcFVDXx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 23:23:53 -0400
Date: Wed, 22 Jun 2016 11:23:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 1/2] fstests: introduce _require_no_mount_opts helper
Message-ID: <20160622032351.GZ5140@eguan.usersys.redhat.com>
References: <1466505629-9402-1-git-send-email-eguan@redhat.com>
 <20160621234202.GB27480@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160621234202.GB27480@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 22, 2016 at 09:42:02AM +1000, Dave Chinner wrote:
> On Tue, Jun 21, 2016 at 06:40:28PM +0800, Eryu Guan wrote:
> > Some tests require that there's no certain mount option, so
> > introduce a new helper _require_no_mount_opts() to do the check on
> > $MOUNT_OPTIONS.
> 
> I think this is fine, except for the name. It's more of an exclude
> rule rather than a "require" rule. i.e.  _exclude_mount_option() is
> closer to it's purpose.

This does look better to me, thanks!

> 
> The only other question I have is that mount options can be
> different between test and scratch devices - the test device mount
> options can be set via TEST_FS_MOUNT_OPTS, as well as via
> MOUNT_OPTIONS. Does this rule need to handle that?

I didn't think about TEST_FS_MOUNT_OPTS. Currently there's no need to
handle it, MOUNT_OPTIONS is sufficient I think.

How about I rename it to _exclude_scratch_mount_option()? And we can
always add another _exclude_test_mount_option() if needed in future.

Thanks,
Eryu
