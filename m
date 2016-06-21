Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:60140 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750890AbcFUXmH (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 19:42:07 -0400
Date: Wed, 22 Jun 2016 09:42:02 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 1/2] fstests: introduce _require_no_mount_opts helper
Message-ID: <20160621234202.GB27480@dastard>
References: <1466505629-9402-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466505629-9402-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 21, 2016 at 06:40:28PM +0800, Eryu Guan wrote:
> Some tests require that there's no certain mount option, so
> introduce a new helper _require_no_mount_opts() to do the check on
> $MOUNT_OPTIONS.

I think this is fine, except for the name. It's more of an exclude
rule rather than a "require" rule. i.e.  _exclude_mount_option() is
closer to it's purpose.

The only other question I have is that mount options can be
different between test and scratch devices - the test device mount
options can be set via TEST_FS_MOUNT_OPTS, as well as via
MOUNT_OPTIONS. Does this rule need to handle that?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
