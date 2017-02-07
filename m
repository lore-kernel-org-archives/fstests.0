Received: from imap.thunk.org ([74.207.234.97]:43380 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754440AbdBGRsH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Feb 2017 12:48:07 -0500
Date: Tue, 7 Feb 2017 12:48:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: remove kernel-configs for 4.2
Message-ID: <20170207174804.slabaffl3olib4rd@thunk.org>
References: <20170206214237.8838-4-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206214237.8838-4-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 06, 2017 at 01:42:36PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> I am not aware of anyone who is maintaining 4.2 as a stable version, and
> it's just one version ahead of 4.1 which actually is being maintained as
> an upstream stable version.  So it seems it isn't worthwhile to maintain
> kernel configs for 4.2 in xfstests-bld anymore, and in the off-chance
> someone wants them they can just base their config on 4.1.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Fair enough.  Thanks, applied.

				- Ted
