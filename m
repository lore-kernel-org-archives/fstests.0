Received: from imap.thunk.org ([74.207.234.97]:50782 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbcJABOK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Sep 2016 21:14:10 -0400
Date: Fri, 30 Sep 2016 18:19:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] [xfstests-bld] Remove redundant gce-xfstests
 documentation
Message-ID: <20160930221949.ixypgnpz7qy5rwp3@thunk.org>
References: <1474664172-84173-1-git-send-email-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474664172-84173-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 23, 2016 at 01:56:10PM -0700, Eric Biggers wrote:
> README.GCE is no longer necessary because the same information, with
> more details, can now be found in gce-xfstests.md.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

I had left this behind deliberately, because there are some old emails
and documentation aronud that pointed users at URL's like this:

https://git.kernel.org/cgit/fs/ext2/xfstests-bld.git/tree/kvm-xfstests/README.GCE

What I'll do instead is replace these files with pointers to the *.md
versions of the file in the Documentation directory.  A year or so
from now I'll get rid of the forwarding pointers, but I want to keep
these around for a bit.

Cheers,

						- Ted
