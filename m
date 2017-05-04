Received: from imap.thunk.org ([74.207.234.97]:47324 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdEDO3X (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 10:29:23 -0400
Date: Thu, 4 May 2017 10:29:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] android-xfstests: support userdata on device-mapper
 device
Message-ID: <20170504142920.z2y3o6jghmbkpe72@thunk.org>
References: <20170503230854.112349-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503230854.112349-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 03, 2017 at 04:08:54PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Update android-xfstests to support setting up the xfstests partitions on
> Android devices where the userdata filesystem is located on a
> device-mapper device backed by the userdata partition, rather than on
> the userdata partition itself.  This is the case for devices using
> "full-disk encryption", for example, in which case dm-crypt is used.
> 
> We can do things pretty similarly to the non-dm case: just shrink the
> raw userdata partition after reformatting the filesystem to be smaller,
> then create the test partitions in the newly "free" space.  Shrinking
> the dm device itself is not required.  We do however need to make sure
> not to clobber any footer, e.g. a crypto footer, that may be present.
> 
> Note that it's not possible to create the test partitions on top of the
> dm device.  However, it would be possible to add an option to set up
> separate dm devices for the test partitions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
