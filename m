Received: from imap.thunk.org ([74.207.234.97]:50054 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbdHPPCi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Aug 2017 11:02:38 -0400
Date: Wed, 16 Aug 2017 11:02:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH 2/2] Make the build and creation of
 xfstests.tar.gz to be reproducible
Message-ID: <20170816150234.36iqgbmbtb3wyl3s@thunk.org>
References: <20170813173224.28900-1-tytso@mit.edu>
 <20170813173224.28900-2-tytso@mit.edu>
 <20170816034543.GC1417@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816034543.GC1417@zzz.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 15, 2017 at 08:45:43PM -0700, Eric Biggers wrote:
> On Sun, Aug 13, 2017 at 01:32:24PM -0400, Theodore Ts'o wrote:
> > +find xfstests -print0 | LC_ALL=C sort -z | \
> > +    tar c --owner=0 --group=0 --numeric-owner --mtime="@${SOURCE_DATE_EPOCH}" \
> > +    --mode=go+u-w --null --no-recursion -T - | $GZIP -9n > xfstests.tar.gz
> 
> This step isn't reproducible for me because earlier in the script $GZIP can be
> set to pigz, which differs from gzip.  'gzip -n' omits the filename and
> timestamp from the gz file, but 'pigz -n' only omits the filename, and the -T
> option is needed to also omit the timestamp.

Thanks for pointing this out.  I'll fix this in my tree before I push
out the commit.

I'll note that the use of pigz vs gzip does make a difference in the
reproducibility of the tar.gz file:

11904 -rw-r--r-- 1 tytso tytso 12188800 Aug 16 10:55 xfstests-pigz.tar.gz
11896 -rw-r--r-- 1 tytso tytso 12180273 Aug 16 10:50 xfstests-gzip.tar.gz

So eventually, if we really want to allow someone else to be reproduce
a binary build, we will need to distribute something like a
Debian-style "buildinfo" file where the exact version of the compiler,
and other parts of the build environment (including gzip vs pigz), are
documented.

					- Ted
