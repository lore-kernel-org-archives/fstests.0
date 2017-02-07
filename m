Received: from imap.thunk.org ([74.207.234.97]:43330 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753840AbdBGRkr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Feb 2017 12:40:47 -0500
Date: Tue, 7 Feb 2017 12:40:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: format filesystem with '-O encrypt' in
 encrypt config
Message-ID: <20170207174045.lf6fb342rfnva3cp@thunk.org>
References: <20170206214237.8838-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206214237.8838-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 06, 2017 at 01:42:34PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> We were relying on the kernel setting the 'encrypt' feature flag for us.
> We should just do it in userspace when formatting the filesystem.  This
> will allow us to eventually remove the kernel-side hack to force-set the
> 'encrypt' flag in the superblock.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
