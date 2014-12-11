Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:50473 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933315AbaLKCPV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Dec 2014 21:15:21 -0500
Date: Wed, 10 Dec 2014 21:15:17 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: generic/256 test failure?
Message-ID: <20141211021517.GF3370@thunk.org>
References: <20141211005030.GA30240@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141211005030.GA30240@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I figured it out; the problem is that Debian uses /bin/dash as the
default shell (which is good, it meant that most Debian systems didn't
get screwed by the bash security hole).  But it's also bad, because
xfstests has a few /bin/bashisms.  Normally, this isn't a problem
because most of the scripts are started by #!/bin/bash.  However, on
my test system fsgqa had a shell of /dev/sh, and in Debian this is
/bin/dash.

So there are a couple of ways I can fix this.

1) Document in README that fsgqa must use a shell of fsgqa to
/bin/bash or some tests might fail.

2) Change _user_do() to use "su -s /bin/bash $qa_user ...".

3) Change tests/generic/256 so that instead of

   	  _user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin &> /dev/null"

we use:

   	  _user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin > /dev/null 2>&1"

or:

   	  _user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin" &> /dev/null

Any preference which patch, if any, I should send?  (If #1, then we
probably document the fact that fsgqa must have a shell of bash).

Thanks,

							- Ted

