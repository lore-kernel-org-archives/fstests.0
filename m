Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:55993 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754751AbaLKEOo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Dec 2014 23:14:44 -0500
Date: Thu, 11 Dec 2014 15:13:23 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: suppress "Broken pipe" errors
Message-ID: <20141211041323.GF24183@dastard>
References: <1418264718-31198-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418264718-31198-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 10, 2014 at 09:25:18PM -0500, Theodore Ts'o wrote:
> It's possible based on a race conditions (and possibly the version of
> coreutils which supplies /usr/bin/yes) that commands of the form:
> 
> yes | $MKFS_PROG ...
> 
> will end up causing the following failure:

What race conditions? 

> shared/298 16s ...	[23:49:03] [23:49:19] - output mismatch (see /results/results-4k/shared/298.out.bad)
>     --- tests/shared/298.out	2014-10-31 10:13:04.000000000 -0400
>     +++ /results/results-4k/shared/298.out.bad	2014-11-29 23:49:19.118138099 -0500
>     @@ -1,4 +1,6 @@
>      QA output created by 298
>     +yes: standard output: Broken pipe
>     +yes: write error

But thats indicative that something failed and you need to analyse
the reason, yes? So AFAICT this is deisred behaviour, and hiding the
error will actually hide other failures, right?

>      Generating garbage on loop...done.
>      Running fstrim...done.
>      Detecting interesting holes in image...done.
>     ...
>     (Run 'diff -u tests/shared/298.out /results/results-4k/shared/298.out.bad'  to see the entire diff)
> 
> The simplest way to fix this is to redirect the stderr of the yes
> command to /dev/null.

I'd highly recommend you add ext4 specific mkfs branches so you can
use the non-interactive/force mkfs flags so that "yes |" is not
necessary for your (and everyone elses ext4) test environments.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
