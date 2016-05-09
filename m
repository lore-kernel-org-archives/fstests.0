Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:34573 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbcEIGK5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 9 May 2016 02:10:57 -0400
Date: Mon, 9 May 2016 16:10:54 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2 V2] dm-thinp demo test
Message-ID: <20160509061054.GU18496@dastard>
References: <5717DA92.4030003@redhat.com>
 <5717DB06.2060004@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5717DB06.2060004@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Mike Snitzer <msnitzer@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 20, 2016 at 03:39:50PM -0400, Eric Sandeen wrote:
> Fairly trivial test to use the dm-thin infrastructure.
> 
> Right now it exhausts space in queue-on-error mode,
> adds more space, does a bit more IO, then unmounts &
> checks the fs.
> 
> Not sure if that's valid to test, but it works here and
> demonstrates the common/dmthin helpers.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Had a wacky one-off failure on only one of my test machines:

generic/347      [failed, exit status 1] - output mismatch (see /home/dave/src/xfstests-dev/results//generic/347.out.bad)
    --- tests/generic/347.out   2016-05-09 10:55:14.425279726 +1000
    +++ /home/dave/src/xfstests-dev/results//generic/347.out.bad        2016-05-09 12:57:46.040915465 +1000
    @@ -1,2 +1,4 @@
     QA output created by 347
    -=== completed
    +device-mapper: reload ioctl on thin-pool failed: Invalid or incomplete multibyte or wide character
    +Command failed
    +failed to create dm thin pool device
    ...
    (Run 'diff -u tests/generic/347.out /home/dave/src/xfstests-dev/results//generic/347.out.bad'  to see the entire diff)

It's worked on all the other test machines running the same kernel
and userspace, so I'll commit it as it stands. If it continues to be
a problem, I'll bug you for a fix...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
