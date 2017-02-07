Received: from imap.thunk.org ([74.207.234.97]:43428 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753433AbdBGR50 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Feb 2017 12:57:26 -0500
Date: Tue, 7 Feb 2017 12:57:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: enable crypto self-tests in kernel configs
Message-ID: <20170207175724.awvz2yhwkln7ry63@thunk.org>
References: <20170206214237.8838-5-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206214237.8838-5-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 06, 2017 at 01:42:37PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> It can be useful to enable crypto self-tests by setting
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n.  This makes the crypto API test
> each algorithm against its test vectors before it is used.  Otherwise,
> there could be undetected bugs or incompatibilities in the algorithms
> --- which would be especially problematic for filesystem encryption.
> Note that the crypto self-tests are quite fast and only happen for a
> given algorithm when someone first requests that algorithm.
> 
> I updated all configs for kernels 3.18 and later, excluding 4.2 which
> I've proposed removing, and regenerated the configs for the latest
> upstream stable version of each.  I didn't bother with pre-3.18 kernels.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
