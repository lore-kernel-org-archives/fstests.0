Received: from bombadil.infradead.org ([198.137.202.133]:49652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeESCR7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 May 2018 22:17:59 -0400
Date: Fri, 18 May 2018 19:17:58 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: commit b4678df184b causing xfstests regressions
Message-ID: <20180519021758.GA28858@bombadil.infradead.org>
References: <20180518225037.GA26206@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518225037.GA26206@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 18, 2018 at 06:50:37PM -0400, Theodore Y. Ts'o wrote:
> Hi Matthew,
> 
> Commit b4678df184b: "errseq: Always report a writeback error once"
> appears to be causing xfstests regressions.  For ext4, running
> "gce-xfstests -c 4k -g auto" will result in reliable shared/298
> failures which go away if I revert b4678df184b.

Thanks; I'll take a look.  Monday is a holiday in Canada, so it may be
Tuesday before I get to it.

> Darrick has also reported occasional generic/047 failures, which I
> have seen at least once as well.  I believe two are linked, because
> after instrumenting mke2fs in shared/298, the failure is happening
> after creating a new 300 MB file:
> 
> dd if=/dev/zero of=$img_file bs=1M count=300 &> /dev/null
> 
> creating a new loop device
> 
> loop_dev=$(_create_loop_device $img_file)
> 
> ... and then run mke2fs on that loop device.
> 
> The instrumentation of mke2fs shows that the first fsync() on
> /dev/loop0 (in lib/ext2fs/closefs.c) which is failing with EIO.
> 
> I haven't had a chance to really drill down on it, but I think what is
> going on is there is some former test which exercises an error path
> (using dm_error, or some such), and somehow the errseq_t for the loop
> device isn't getting reset, or the inode for the underlying backing
> file, had an unitialized errseq_t.
> 
> Can you take a closer look at this?
> 
> Thanks,
> 
> 					- Ted
> 
> 
