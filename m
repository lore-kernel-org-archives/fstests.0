Received: from imap.thunk.org ([74.207.234.97]:36670 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeIPA5E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 15 Sep 2018 20:57:04 -0400
Date: Sat, 15 Sep 2018 15:36:57 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH resend] android-xfstests: fix finding FS_TYPE when
 userdata is on dm device
Message-ID: <20180915193657.GC9979@thunk.org>
References: <20180905190700.66123-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905190700.66123-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 05, 2018 at 12:07:00PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If the userdata filesystem is on a device-mapper device, then shrinking
> the partition underneath it breaks 'blkid' probing, which
> android-setup-partitions now uses find the filesystem type.  Use blkid's
> '-p' and '-S' options to do a low-level probe with explicitly specified
> size, which still works in this case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
