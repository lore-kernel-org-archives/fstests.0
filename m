Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:6386 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176AbbBRBP4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Feb 2015 20:15:56 -0500
Date: Wed, 18 Feb 2015 12:15:21 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Test xfs/106 failure
Message-ID: <20150218011521.GN4251@dastard>
References: <20150217163149.GA1824@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150217163149.GA1824@quack.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 17, 2015 at 05:31:49PM +0100, Jan Kara wrote:
>   Hello,
> 
>   I'm consistently getting failure in xfs/106 test because the files
> created by fsstress are just completely different from what they are
> expected to be. It almost seems as if the random numbers generated for
> fsstress are different. Anyone has seen this as well?

If it's not in the auto group, then it's not expected to function as
a reliable regression test. There are few tests around the
xfs/100 to xfs/130 that fall into this category. Some were tests
that were never completed, others were simply a method of exercising
the functionality and not intended to have deterministic output
and hence "always fail".

given the amount of commented out functionality and comments like
"# not yet working properly?" in xfs/106 leads me to beleive it
falls into the former category of "unfinished".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
