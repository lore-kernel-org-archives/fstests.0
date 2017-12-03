Received: from imap.thunk.org ([74.207.234.97]:56266 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbdLCVic (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Dec 2017 16:38:32 -0500
Date: Sun, 3 Dec 2017 16:38:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] kernel-configs: add 4.14 configs
Message-ID: <20171203213829.bczdk3hwpwwkdqj2@thunk.org>
References: <20171113213752.18123-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113213752.18123-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 13, 2017 at 01:37:52PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Enabled the following new options:
> 
>     CONFIG_REFCOUNT_FULL=y
>     CONFIG_UBIFS_FS_ENCRYPTION=y
>     CONFIG_FORTIFY_SOURCE=y
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
