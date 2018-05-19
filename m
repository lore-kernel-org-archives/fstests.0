Received: from userp2120.oracle.com ([156.151.31.85]:51596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeESPZl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 May 2018 11:25:41 -0400
Date: Sat, 19 May 2018 08:25:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: commit b4678df184b causing xfstests regressions
Message-ID: <20180519152503.GA4507@magnolia>
References: <20180518225037.GA26206@thunk.org>
 <630faadb74f608aa5a42649b81657e8b62d46bc3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630faadb74f608aa5a42649b81657e8b62d46bc3.camel@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 19, 2018 at 09:09:46AM -0400, Jeff Layton wrote:
> On Fri, 2018-05-18 at 18:50 -0400, Theodore Y. Ts'o wrote:
> > Hi Matthew,
> > 
> > Commit b4678df184b: "errseq: Always report a writeback error once"
> > appears to be causing xfstests regressions.  For ext4, running
> > "gce-xfstests -c 4k -g auto" will result in reliable shared/298
> > failures which go away if I revert b4678df184b.
> > 
> > Darrick has also reported occasional generic/047 failures, which I
> > have seen at least once as well.  I believe two are linked, because
> > after instrumenting mke2fs in shared/298, the failure is happening
> > after creating a new 300 MB file:
> > 
> > dd if=/dev/zero of=$img_file bs=1M count=300 &> /dev/null
> > 
> > creating a new loop device
> > 
> > loop_dev=$(_create_loop_device $img_file)
> > 
> > ... and then run mke2fs on that loop device.
> > 
> > The instrumentation of mke2fs shows that the first fsync() on
> > /dev/loop0 (in lib/ext2fs/closefs.c) which is failing with EIO.
> > 
> > I haven't had a chance to really drill down on it, but I think what is
> > going on is there is some former test which exercises an error path
> > (using dm_error, or some such), and somehow the errseq_t for the loop
> > device isn't getting reset, or the inode for the underlying backing
> > file, had an unitialized errseq_t.
> > 
> > Can you take a closer look at this?
> > 
> > Thanks,
> > 
> > 					- Ted
> > 
> 
> Thanks Ted. I'm not that familiar with the loopdev code, but after
> giving it a quick look, I suspect that you're correct. We probably need
> to do something like reset the loop device's bd_inode->i_mapping->wb_err 
> back to zero when we detach the file that backs it.
> 
> I wonder if we could roll a test that would do:
> 
> create a scratch fs on a dm-error dev with a file on it
> set up a loop device on that file
> have the backing device of the scratch file throw errors
> write to the device
> detach loop device
> clear dm-error condition
> delete file and recreate it
> attach same loop device to new file
> fsync loop device
> 
> My suspicion is that that last fsync would throw an error now and it
> wouldn't have before.

I /think/ it's because inode_init_always doesn't clear mapping->wb_err
(even though it clears mapping->flags) when recycling struct inodes.
Will send patch shortly.

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
