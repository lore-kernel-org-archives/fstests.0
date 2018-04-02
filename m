Received: from imap.thunk.org ([74.207.234.97]:52008 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeDBAYj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Apr 2018 20:24:39 -0400
Date: Sun, 1 Apr 2018 20:24:35 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] android-xfstests: support f2fs
Message-ID: <20180402002435.GA26510@thunk.org>
References: <20180330010050.64034-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330010050.64034-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 29, 2018 at 06:00:50PM -0700, Eric Biggers wrote:
> Make android-setup-partitions use 'blkid' to detect the type of the
> userdata filesystem, and if it is f2fs calculate its size using fields
> from the f2fs superblock.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
