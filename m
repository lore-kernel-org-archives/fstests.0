Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeJDG1w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Oct 2018 02:27:52 -0400
Date: Wed, 3 Oct 2018 16:37:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH resend] android-xfstests: fix finding FS_TYPE when
 userdata is on dm device
Message-ID: <20181003233717.GA58226@gmail.com>
References: <20180905190700.66123-1-ebiggers@kernel.org>
 <20180915193657.GC9979@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915193657.GC9979@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Sep 15, 2018 at 03:36:57PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Sep 05, 2018 at 12:07:00PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If the userdata filesystem is on a device-mapper device, then shrinking
> > the partition underneath it breaks 'blkid' probing, which
> > android-setup-partitions now uses find the filesystem type.  Use blkid's
> > '-p' and '-S' options to do a low-level probe with explicitly specified
> > size, which still works in this case.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Thanks, applied.
> 
> 					- Ted

Hi Ted, are you planning to push this out?

- Eric
