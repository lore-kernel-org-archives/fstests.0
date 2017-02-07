Received: from imap.thunk.org ([74.207.234.97]:43318 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753322AbdBGRjq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Feb 2017 12:39:46 -0500
Date: Tue, 7 Feb 2017 12:39:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: be tolerant of /proc/slabinfo being missing
Message-ID: <20170207173943.hkcipu36syvgdtxk@thunk.org>
References: <20170206214237.8838-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206214237.8838-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 06, 2017 at 01:42:33PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In kernels compiled without /proc/slabinfo (CONFIG_SLABINFO),
> runtests.sh would report errors when trying to save the contents of
> /proc/slabinfo.  Update runtests.sh to consider /proc/slabinfo to be
> optional, saving its contents only if present.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
