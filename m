Received: from imap.thunk.org ([74.207.234.97]:54716 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbcKRQW7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Nov 2016 11:22:59 -0500
Date: Fri, 18 Nov 2016 11:22:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Message-ID: <20161118162249.iu45dkdynxdaotq7@thunk.org>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
 <20161118043835.GA22707@jaegeuk>
 <20161118045157.nclslkbhumszrggz@thunk.org>
 <20161118051113.GA24878@jaegeuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161118051113.GA24878@jaegeuk>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 09:11:13PM -0800, Jaegeuk Kim wrote:
> 
> IIUC, I guess it'd be okay if VM installed that as a package. I tried to add
> f2fs-tools repo likewise fio, I could't find /sbin/mkfs.f2fs, even if it was
> installed into bld/sbin/. Instead, bld/sbin/* were copied into xfstests/bin/
> in VM, which enables to execute mkfs.f2fs globally through $PATH.

Ah, I see what you mean; I thought you were talking about your local
f2fstools git repo, and not changes you've made to your local
xfstests-bld repo.

The reason why xfsprogs is installed in xfstests/bin is that
historically, xfstests needed some of the xfsprogs tools (no matter
what file system type you were testing), and the xfsprogs installed in
Debian and Ubuntu was too old or didn't install all of the utilities
that xfstests required.

However, I have not tried to build the file system utilities for other
file systems in xfstests-bld --- and this includes e2fsprogs.  My goal
is to allow xfstests-bld to support a large number of file systems,
and it doesn't scale to build all file system utilities in
xfstests-bld.  Also, most of the time, the file system utilities tend
to move at a slower pace, and the requirements for needing a newer
file system utility than what is shipped in the distribution is rarer.

I have sometimes built a newer version of e2fsprogs as a Debian
package, and installed it into the VM.  These days, what I tend to do
when that's been necessary is to build a new Debian package for
jessie-backports, and upload it to the jessie-backports repository, so
everyone can use the same binary package.

I guess I don't have any objections to allowing people to put locally
compiled versions of the utilities in /root/xfstests/sbin and rely on
the PATH to use that version in preference to the /sbin/mkfs.f2fs
version of the utilities.  As far as adding the ability to download
and build local versions of f2fstools in the upstream xfstests-bld, I
guess I could accept that so long as it's optional, and not turned on
by default.  The main issue here is that if i have a half dozen file
system-specific utilities included in xfstests-bld, which were all
enabled for download by default, it would increase the build time of
xfstests-bld significantly, so it doesn't scale.  I'd much prefer to
see newer versions of the utilities (if necessary) in
debian-backports.

Cheers,

						- Ted
