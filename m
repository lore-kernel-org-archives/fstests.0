Received: from imap.thunk.org ([74.207.234.97]:39712 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754574AbeDFNai (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Apr 2018 09:30:38 -0400
Date: Fri, 6 Apr 2018 09:30:36 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: support f2fs-tools v1.9 and
 later
Message-ID: <20180406133036.GD7345@thunk.org>
References: <20180405222141.42376-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405222141.42376-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 05, 2018 at 03:21:41PM -0700, Eric Biggers wrote:
> Pass the -f option to mkfs.f2fs when it appears to support it.  This is
> required by f2fs-tools v1.9 and later in order to format the filesystem
> even when an existing filesystem is detected.  But earlier versions did
> not accept this option.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for now, but ugh.  Grepping strings out of binaries is not
something I really like to depend upon.  Can we convince the f2fs
folks to provide a "/sbin/mkfs.f2fs -V" which prints a version string,
or some such?

						- Ted
