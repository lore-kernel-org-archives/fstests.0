Received: from imap.thunk.org ([74.207.234.97]:56796 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754612AbcLaPw2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 31 Dec 2016 10:52:28 -0500
Date: Sat, 31 Dec 2016 10:52:23 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: document how to add debian packages to GCE
 image
Message-ID: <20161231155223.pooklm4xsbv5yxhz@thunk.org>
References: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
 <20161222170433.cbyrt2phsapq2tr7@thunk.org>
 <20161228212132.GB8557@zzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228212132.GB8557@zzz>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 28, 2016 at 03:21:32PM -0600, Eric Biggers wrote:
> That works with kvm-xfstests (gen-image), but it didn't work when I tried it
> with gce-xfstests (gce-create-image) because nothing was actually copying the
> debian packages into the GS bucket for the test appliance to install.  How about
> we update gce-create-image to copy the debian packages from
> test-appliances/debs/ into the GS bucket (maybe gsutil rsync -d to a directory
> 'debs'), so that it works in the way you're suggesting?

Oh, right; I had forgotten.  I was originally planning on copying the
debian packages into the GS bucket, but I gave up on that because it
was too slow.  I didn't try using gsutil rsync, but the multiple round
trips is very likely going to make things slower than we'd like.

Actually, what would probably work better for gce-create-image is
simply add jessie-backports to the apt sources list, and then use
"apt-get install -t jessie-backports <package> ..." to get the newer
version of e2fsprogs, f2fs-tools, etc.  If we also use
snapshots.debian.org URL instead of the standard debian download site
(as we do with kvm-xfstests), it also has the advantage making the
build of the image be perfectly reproducible.

Converting kvm-xfstests to using jessie-backports as well is going to
be a bit tricky, since debootstrap doesn't understand how to install
from backports; so this would probably require hacking up something
using python-debian and possibly python-apt.  So perhaps we'll just
change gce-create-image to use jessie-backports first, and we can
convert kvm-xfstests later.

						- Ted

P.S.  BTW, I checked in with the f2fs-tools maintainer and he has no
objections to porting the latest version of f2fs-tools from Debian
stretch to Debian jessie, so that should be happening in the next week
or so.
