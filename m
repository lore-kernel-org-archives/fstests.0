Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38948 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbaFXEii (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Jun 2014 00:38:38 -0400
Date: Tue, 24 Jun 2014 14:38:35 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
 different block sizes
Message-ID: <20140624043835.GF9508@dastard>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
 <1403535255-14601-2-git-send-email-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403535255-14601-2-git-send-email-lczerner@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 23, 2014 at 04:54:15PM +0200, Lukas Czerner wrote:
> User takes care about specifying mkfs options he wishes to test and the
> test itself should not change it if it's not strictly necessary for the
> test itself.
> 
> In this case it is not necessary and we should only test configuration
> provided by the user. Moreover if the block size was already specified
> some mkfs utilities does not handle multiple of the same parameters and
> the mkfs utility fails making it re-try with only provided options
> (ignoring what user specified), which is wrong.

I disagree strongly with this justification. The test is perfectly
fine: it is allowed to do whatever it wants with mkfs and mount
options.

It is up to the implementations of the specific FSTYP mkfs
implementation called from _scratch_mkfs to handle
conflicting/unsupported options sanely, not the test....

> In this case it's also a problem for btrfs file system which does not
> support block size < page size.

i.e. _scratch_mkfs_btrfs needs to either filter that out or
_fail/_not_run the test if it can't....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
