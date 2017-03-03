Received: from imap.thunk.org ([74.207.234.97]:40992 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdCDAgc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Mar 2017 19:36:32 -0500
Date: Fri, 3 Mar 2017 18:01:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170303230129.apzqe77r4d5jtf63@thunk.org>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303172157.GA5070@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 03, 2017 at 09:21:57AM -0800, Darrick J. Wong wrote:
> 
> <shrug> The test device isn't supposed to get corrupted, since it (at
> least in theory) should be an old filesystem.  That said, I suppose
> there's little point in banging around with a corrupt test fs.  Maybe we
> could go further and stop running if there's unfixable corruption?

Yes, that was the other alternative I considered.  In my case, though,
since I'm trying to get a sense of how many failures I have to deal
with, I really wanted a "make -k" behavior that would continue after
the first failure.  After all, all I was going to do was manually run
fsck, and then continue the run --- so we might as well have the check
script do it automatically and then allow things to continue.

We could make it be configurable, via a command-line option.  The -k
option isn't taken so we could have check -k that works like make -k
if you think that's better.  OTOH, perhaps making -k the default
behaviour is actually the better way to go, and in that case, maybe
it's not worth having the command-line flag?

					- Ted
