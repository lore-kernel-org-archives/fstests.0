Received: from imap.thunk.org ([74.207.234.97]:38498 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdEBEmD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 May 2017 00:42:03 -0400
Date: Tue, 2 May 2017 00:42:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kvm-xfstests: unmount /results before shutting down
Message-ID: <20170502044201.nfa4wwjj3u4xtzyx@thunk.org>
References: <20170501170420.94456-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501170420.94456-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, May 01, 2017 at 10:04:20AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> kvm-xfstests shuts down the VM with 'poweroff -f', which with old
> versions of systemd's 'poweroff' command (including the version included
> in Debian Jessie) does not call sync().  This could cause data written
> to the /results filesystem to be lost.  Work around this by unmounting
> /results before shutting down.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

				- Ted
