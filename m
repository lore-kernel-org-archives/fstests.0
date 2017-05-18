Received: from imap.thunk.org ([74.207.234.97]:39032 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbdERSvI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 14:51:08 -0400
Date: Thu, 18 May 2017 14:51:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 4/5] kernel-configs: enable f2fs support
Message-ID: <20170518185106.5p4yh3zl3eyzt2ji@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
 <20170517233233.61244-5-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517233233.61244-5-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 04:32:32PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Merged the following into each config:
> 
>     CONFIG_F2FS_FS=y
>     CONFIG_F2FS_FS_SECURITY=y
>     CONFIG_F2FS_FS_ENCRYPTION=y
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
