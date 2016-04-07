Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:62819 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636AbcDGV3H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 Apr 2016 17:29:07 -0400
Date: Fri, 8 Apr 2016 07:28:57 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Pass --retry to dmsetup when removing flakey and error
 devices
Message-ID: <20160407212857.GC761@dastard>
References: <1460009548-20668-1-git-send-email-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460009548-20668-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 07, 2016 at 07:12:28AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running multiple tests using dm's flakey target, often (very rarely)
> I was getting an error when a test tried to setup a dm flakey target,
> resulting in the following messages in the test's .out.bad file:
> 
>   device-mapper: reload ioctl on flakey-test failed: Device or resource busy
>   Command failed
>   failed to create flakey device
> 
> Upon further investigation it turns out that it was because the previous
> test that ran had failed to remove the flakey device because the device
> was being used at the time but this has not made that previous test fail
> because we simply redirect the stderr (and stdout) to /dev/null and don't
> fail if the dmsetup remove command exits with a non-zero status.
> The device was in use, when the test attempted to remove it, by an udev
> rule (btrfs udev rule).

And that's why we have $UDEV_SETTLE_PROG calls before removing the
dm device, which it appears _dmerror_init() does not have.

If there are things other than udev holding the device open, then we
ned to find what they are first rather than trying to ignore them...

> Fix this by passing the option --retry to dmsetup remove, which serves to
> deal with such cases. From dmsetup's man page:
> 
>   "If an attempt to remove a device fails, perhaps because a process run
>    from a quick udev rule temporarily opened the device, the --retry
>    option will cause the operation to be retried for a few seconds before
>    failing."

It also talks about udev, so running $UDEV_SETTLE_PROG before remove
should prevent this from happening. If it is not sufficient, then we
need to understand why it is not sufficient, not blindly hack around
it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
