Received: from imap.thunk.org ([74.207.234.97]:50610 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbdAGRAO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 7 Jan 2017 12:00:14 -0500
Date: Sat, 7 Jan 2017 12:00:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: document how to add debian packages to GCE
 image
Message-ID: <20170107170011.yovxavb32r77awhv@thunk.org>
References: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
 <20161222170433.cbyrt2phsapq2tr7@thunk.org>
 <20161228212132.GB8557@zzz>
 <20161231155223.pooklm4xsbv5yxhz@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161231155223.pooklm4xsbv5yxhz@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

It looks like "gsutil rsync -cd" is actually pretty efficient, so I'll
be adopting your suggestion of using that so we can use the same
mechanism for the kvm-xfstests create-image script.

I'm also going to be teaching gce-xfstests-bld.sh to use the
jessie-backports version for e2fsprogs and btrfs-progs, and f2fs-tools
is currently waiting to be installed in the debian backports queue.
Once that's done, we won't actually need any extra packages for the
gce-xfstests image which I am distributing, since we can just use the
jessie-backports version.

We still need a similar mechanism for the other build mechanisms, but
we can do that later.

					- Ted
