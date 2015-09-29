Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:36977 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbbI2X23 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 29 Sep 2015 19:28:29 -0400
Date: Wed, 30 Sep 2015 09:28:26 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: help on xfs test results
Message-ID: <20150929232826.GA3902@dastard>
References: <560B18C8.8000204@sysam.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560B18C8.8000204@sysam.it>
Sender: fstests-owner@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 30, 2015 at 01:03:36AM +0200, Angelo Dureghello wrote:
> Hi all,
> 
> thanks for all the great support until now.
> 
> I finally completed all the tests in my arm 32 bit target platform,
> and have still 4 hopefully false positives. Below my comments:
> 
> 
> 
> generic tests
> 
> *** 256
> /media/p6/fill.161/3.bin: No space left on device
> 
>  - output mismatch (see
> /home/angelo/xfstests/results//./generic/256.out.bad)
>     --- tests/./generic/256.out	2015-09-17 10:54:06.815078834 +0000
>     +++
> /home/angelo/xfstests/results//./generic/256.out.bad	2000-01-01
> 00:42:13.822058816 +0000
>     @@ -1 +1,2229 @@
>      QA output created by 256
>     +wrote 1073741824/1073741824 bytes at offset 0
>     +1 GiB, 262144 ops; 0:02:35.00 (6.602 MiB/sec and 1690.0353 ops/sec)
>     +pwrite64: No space left on device
>     +pwrite64: No space left on device
>     +pwrite64: No space left on device
>     +pwrite64: No space left on device
>     ...

There should be ENOSPC being reported during the test but they
should all be redirected to /dev/null. Perhaps shomething wrong with
redirection?

> xfs tests
> **** 020

You need to be more explicit about the test description. Does "020"
mean generic/020, xfs/020, btrfs/020, etc?

> creates a 60t, fails if > 16t (Growing the data section failed),
> could be normal in 32bit arch ?

32 bit system can't use a 60TB block device or file, so this needs
a "_requires_64bit_blockdev" type of check.

> **** 080
> Looks like not XFS issue. mmap() failed, no more memory after 2,5G

various tests will fail if you don't have enough memory or address
space. Expunge them from your normal testing if it's just memory
allocation that is the problem.

> **** 136
> very long test, output similar but different values

xfs/136 shouldn't run your machine out of memory. If it does, then
you probably should start looking for a memory leak...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
