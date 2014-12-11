Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:54451 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933529AbaLKEJM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Dec 2014 23:09:12 -0500
Date: Thu, 11 Dec 2014 15:06:46 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: generic/256 test failure?
Message-ID: <20141211040646.GE24183@dastard>
References: <20141211005030.GA30240@thunk.org>
 <20141211021517.GF3370@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141211021517.GF3370@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 10, 2014 at 09:15:17PM -0500, Theodore Ts'o wrote:
> I figured it out; the problem is that Debian uses /bin/dash as the
> default shell (which is good, it meant that most Debian systems didn't
> get screwed by the bash security hole).  But it's also bad, because
> xfstests has a few /bin/bashisms.

FYI, bash is required for xfstests - we made this explicit several
years ago:

commit 771e69de67b138654a1f63258cfe4c1bf1c156ee
Author: Dave Chinner <david@fromorbit.com>
Date:   Wed Jan 20 10:27:08 2010 +1100

    xfstests: Convert all tests to use /bin/bash
    
    While most tests use /bin/sh, they are dependent on /bin/sh being a
    bash shell.  Convert all the tests to execute via /bin/bash as it is
    much, much simpler than trying to debug and remove all the bashisms
    throughout the test code.
    
    Signed-off-by: Dave Chinner <david@fromorbit.com>
    Reviewed-by: Eric Sandeen <sandeen@sandeen.net>


> Normally, this isn't a problem
> because most of the scripts are started by #!/bin/bash.  However, on
> my test system fsgqa had a shell of /dev/sh, and in Debian this is
> /bin/dash.
> 
> So there are a couple of ways I can fix this.
> 
> 1) Document in README that fsgqa must use a shell of fsgqa to
> /bin/bash or some tests might fail.

Please send a patch to do that.

> 2) Change _user_do() to use "su -s /bin/bash $qa_user ...".
> 
> 3) Change tests/generic/256 so that instead of
> 
>    	  _user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin &> /dev/null"
> 
> we use:
> 
>    	  _user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin > /dev/null 2>&1"

That's consistent with all the redirections in the rest of the code,
so it's probably a good idea to sanitise the test while this is in
our minds.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
