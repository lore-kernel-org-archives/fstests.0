Received: from imap.thunk.org ([74.207.234.97]:51528 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755077AbeDQQIl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Apr 2018 12:08:41 -0400
Date: Tue, 17 Apr 2018 12:08:38 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: detect 'mkfs.f2fs -f'
 support by grepping help output
Message-ID: <20180417160838.GA22382@thunk.org>
References: <20180416220621.196700-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416220621.196700-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 16, 2018 at 03:06:21PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Grep the help output rather than the binary itself.  This matches the
> detection method that was implemented in xfstests common/config.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
