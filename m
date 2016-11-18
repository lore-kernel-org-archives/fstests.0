Received: from imap.thunk.org ([74.207.234.97]:33348 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbcKRWHq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Nov 2016 17:07:46 -0500
Date: Fri, 18 Nov 2016 17:07:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Message-ID: <20161118220740.pisri5zaldj7h5ic@thunk.org>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
 <20161118043835.GA22707@jaegeuk>
 <20161118045157.nclslkbhumszrggz@thunk.org>
 <20161118051113.GA24878@jaegeuk>
 <20161118162249.iu45dkdynxdaotq7@thunk.org>
 <20161118180421.GA31226@jaegeuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118180421.GA31226@jaegeuk>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 18, 2016 at 10:04:21AM -0800, Jaegeuk Kim wrote:
> 
> I realize that xfstests-bld is really great to test multiple kernel versions.
> I guess it can be quite doable to test arm-based kernel as well, as I can see
> cross compile environment.

I have had reports that some folks have run into problems using the
armhf chroot on an Android device.  I'm not sure what problems they
ran into, since their report was quite vague.  I'm aware of one
namespace-related test that will fail when you run xfstests in a
chroot, and I would expect that SELinux would have to be disabled, but
other than that I would have expected it to work.

If you (or anyone else) have managed to use the armhf chroot
successfully on an Android device, please let me know, and let me know
if there are any updates we can make to Documentation/android-xfstests.md.

Unfortunately I haven't had time to investigate those reports myself.
If someone has time to try it out and send me a more detailed report,
that would be great.

Thanks!!

						- Ted
