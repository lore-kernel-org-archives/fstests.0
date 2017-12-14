Received: from imap.thunk.org ([74.207.234.97]:42794 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdLNDIL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Dec 2017 22:08:11 -0500
Date: Wed, 13 Dec 2017 22:08:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] xfstests-bld: add support for UBIFS using block2mtd
Message-ID: <20171214030807.3hsdycsazcsk3hzq@thunk.org>
References: <20171214020348.185463-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214020348.185463-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 13, 2017 at 06:03:48PM -0800, Eric Biggers wrote:
> Hi Ted, are you interested in taking this UBIFS support patch into
> xfstests-bld now?  The 'block2mtd' approach hasn't gotten any better
> from when I sent this patch out originally, but it's better than nothing
> (it's useful to me, at least).  Also, xfstests itself supports UBIFS
> now, so only xfstests-bld support is missing.

Agreed, thanks for doing this work!  I've applied this patch to
xfstests-bld.

						- Ted
