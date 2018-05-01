Received: from imap.thunk.org ([74.207.234.97]:47890 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeEACSB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Apr 2018 22:18:01 -0400
Date: Mon, 30 Apr 2018 22:17:58 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH 2/2] test-appliance: add 'encrypt' config
 for f2fs
Message-ID: <20180501021758.GH20585@thunk.org>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
 <20180419205020.16868-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419205020.16868-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 19, 2018 at 01:50:20PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Allow testing f2fs using the test_dummy_encryption mount option,
> available with f2fs in kernel 4.17 and later.  E.g.,
> 
>     gce-xfstests -c f2fs/encrypt -g auto
> 
> This is the f2fs equivalent of ext4/encrypt.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
