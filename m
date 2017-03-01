Received: from imap.thunk.org ([74.207.234.97]:47156 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbdCAUhc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Mar 2017 15:37:32 -0500
Date: Wed, 1 Mar 2017 14:42:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] [xfstests-bld] test-appliance: yet another file
 permissions fix
Message-ID: <20170301194250.33cas2a42hlskol4@thunk.org>
References: <20170228204643.37016-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228204643.37016-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 28, 2017 at 12:46:43PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Several directories in the kvm-xfstests appliance were still not being
> given the correct file permissions, since they were rsync'ed directly
> into the mounted root filesystem with the '-a' option.  Unfortunately it
> seems we can't express "go+u-w" with rsync options (it's not accepted by
> --chmod), but we can copy the files through 'tar' instead, similar to
> what is done elsewhere.
> 
> (I didn't notice this earlier because it is kvm-xfstests specific, and
> it only broke a couple tests such as generic/128.)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
