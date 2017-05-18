Received: from imap.thunk.org ([74.207.234.97]:39046 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754072AbdERSyS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 14:54:18 -0400
Date: Thu, 18 May 2017 14:54:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 5/5] kernel-configs: enable ubifs support
Message-ID: <20170518185416.hw5lumeq5jwyahgt@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
 <20170517233233.61244-6-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517233233.61244-6-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 04:32:33PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Merged the following into each config:
> 
>     CONFIG_MTD=y
>     CONFIG_MTD_BLOCK2MTD=y
>     CONFIG_MTD_UBI=y
>     CONFIG_UBIFS_FS=y
> 
> (No need for CONFIG_UBIFS_FS_ENCRYPTION yet, since that was added in
> 4.10, and currently the latest config is 4.9.)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
