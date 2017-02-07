Received: from imap.thunk.org ([74.207.234.97]:43348 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbdBGRll (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Feb 2017 12:41:41 -0500
Date: Tue, 7 Feb 2017 12:41:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: use old key prefix in ext4 encrypt config
Message-ID: <20170207174138.gjseo3klxyk34bwx@thunk.org>
References: <20170206214237.8838-3-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206214237.8838-3-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 06, 2017 at 01:42:35PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> For the ext4 encrypt config, add the dummy key using the "ext4:" prefix
> instead of the "fscrypt:" prefix.  This will allow xfstests-bld to test
> any old kernels to which the change to make test_dummy_encryption
> require a keyring key may get backported.  (Of course, it also remains
> able to test old kernels to which that change has *not* been
> backported.)  Using the old / fs-specific key prefix is also consistent
> with the xfstests in the "encrypt" group, which use the fs-specific key
> prefix to allow the tests to run unmodified on older kernels.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
