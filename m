Received: from imap.thunk.org ([74.207.234.97]:34068 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754964AbdBVULl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Feb 2017 15:11:41 -0500
Date: Wed, 22 Feb 2017 15:11:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: fix setting mkfs options for ext4
Message-ID: <20170222201126.gx3pvz7jhby45gzn@thunk.org>
References: <20170222193013.116510-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222193013.116510-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 22, 2017 at 11:30:13AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit ebbfbefce909 ("test-appliance: add support for xfstests to use
> EXT_MKFS_OPTIONS") changed the test appliances to set both MKFS_OPTIONS
> and EXT_MKFS_OPTIONS when starting 'check'.  However, MKFS_OPTIONS was
> not exported into the environment, so it was not actually being
> recognized.  Fix this by exporting it.
> 

Oops.   Nice catch!

BTW, I am very much thinking about sending in a patch upstream so that
xfstests recognizes EXT_MKFS_OPTIONS.  The problem is once we do this
it will break people's config file or other systems that wrap xfstests
if they are just using the bare MKFS_OPTIONS.  I'm making
kvm-xfstests/gce-xfstests be able to be agile with respect to this
proposed change, by setting both, but this could potentially break
other people.

There's a larger issue here, which is that xfstests as a whole is very
inconsistent, on a file system by file system basis, about whether or
not <FSTYPE>_MKFS_OPTIONS and <FSTYPE>_MOUNT_OPTIONS are used or not.

It might be nice to fix the larger problem, but for now I'm more
focused on making ext4 consistent with most (but not all) of the other
file systems supported by xfstests.

					- Ted
