Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:1573 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008AbbLBUFJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 2 Dec 2015 15:05:09 -0500
Date: Thu, 3 Dec 2015 07:04:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch] dmflakey: filter out 'dax' from mount options
Message-ID: <20151202200454.GR26718@dastard>
References: <x49610gq180.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49610gq180.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 02, 2015 at 11:11:59AM -0500, Jeff Moyer wrote:
> Hi,
> 
> In testing with MOUNT_OPTIONS="-o dax" ./check ..., I ran into issues
> with every single test that uses dmflakey.  The problem is that the
> mount will fail, since we're layering a stacking driver on top of the
> pmem device, and that stacking driver does not support direct access.
> To fix that, I decided to filter out the dax mount option from dmflakey
> mounts.  If there are suggestions for a better approach, I'm all ears.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

These tests don't run on a ram disk because of the
_require_sane_bdev_flush() check in each of these dm-flakey tests
and so none of my DAX testing has tripped over this...

Because dm-flakey will not alow you to use DAX, there's not much
point in running these tests if the DAX mount option is enabled.
Hence I'd just add this to common/dm-flakey:

echo $MOUNT_OPTIONS | grep -q dax
if [ $? -ne 0 ]; then
	_notrun "Cannot run tests with DAX on dmflakey devices"
fi

That way we have a clear reminder that these tests do not run with
DAX enabled and hence we are not doing crash integrity testing using
dm-flakey on DAX devices....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
