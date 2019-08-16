Received: from userp2120.oracle.com ([156.151.31.85]:54732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHPCOF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 22:14:05 -0400
Date: Thu, 15 Aug 2019 19:13:27 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH RFC 3/2] fstests: check that we can't write to swap files
Message-ID: <20190816021327.GD15198@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <20190815163434.GA15186@magnolia>
 <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815142603.de9f1c0d9fcc017f3237708d@linux-foundation.org>
Sender: fstests-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hch@infradead.org, tytso@mit.edu, viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 15, 2019 at 02:26:03PM -0700, Andrew Morton wrote:
> On Thu, 15 Aug 2019 09:34:34 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:
> 
> > While active, the media backing a swap file is leased to the kernel.
> > Userspace has no business writing to it.  Make sure we can't do this.
> 
> I don't think this tests the case where a file was already open for
> writing and someone does swapon(that file)?
> 
> And then does swapoff(that file), when writes should start working again?
> 
> Ditto all the above, with s/open/mmap/.

Heh, ok.  I'll start working on a C program to do that.

> Do we handle (and test!) the case where there's unwritten dirty
> pagecache at the time of swapon()? Ditto pte-dirty MAP_SHARED pages?

One of the tests I wrote for iomap_swapfile_activate way back when
checks that.  The iomap version calls vfs_fsync, but AFAICT
generic_swapfile_activate doesn't do that.

--D
