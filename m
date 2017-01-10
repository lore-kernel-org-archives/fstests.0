Received: from mx1.redhat.com ([209.132.183.28]:35206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932667AbdAJD5d (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Jan 2017 22:57:33 -0500
Date: Tue, 10 Jan 2017 11:57:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: fix error redirection in generic/256
Message-ID: <20170110035732.GI1859@eguan.usersys.redhat.com>
References: <20161112164720.GA18127@infradead.org>
 <20161112183943.GK27776@eguan.usersys.redhat.com>
 <20170109134008.GC19577@infradead.org>
 <20170110034605.GH1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170110034605.GH1859@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 10, 2017 at 11:46:05AM +0800, Eryu Guan wrote:
> On Mon, Jan 09, 2017 at 05:40:08AM -0800, Christoph Hellwig wrote:
> > On Sun, Nov 13, 2016 at 02:39:43AM +0800, Eryu Guan wrote:
> > > On Sat, Nov 12, 2016 at 08:47:20AM -0800, Christoph Hellwig wrote:
> > > > Not sure if my shell is the problem here, but I need this explicit
> > > > redirection to ignore the error output from mkdir and xfs_io, otherwise
> > > > the test fails due to the error messages from these commands.
> > > 
> > > That's weird, from bash manpage, "&>" should be equivalent to "> ... 2>&1"
> > > 
> > > There're many other tests use "&>" as well, do you see such failures
> > > from other tests, such as generic/347?
> > 
> > No.  But 256 keeps on failing for me without this.  Given that it's
> > just a slightly more verbose syntax is there any reason not to just
> > apply this patch for now?
> 
> Ok, I've queued it up for next update.

I need to do some tweaks on this patch, generic/256 has been updated and
patch didn't apply cleanly. I replaced all "&>" with "> ... 2>&1",
though some of them won't generate any output.

Thanks,
Eryu

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 12 Nov 2016 08:47:20 -0800
Subject: [PATCH] generic/256: fix error redirection

Not sure if my shell is the problem here, but I need this explicit
redirection to ignore the error output from mkdir and xfs_io,
otherwise the test fails due to the error messages from these
commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/256 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/256 b/tests/generic/256
index 63f2d4f..5327c33 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -81,10 +81,10 @@ _test_full_fs_punch()
                exit 1
        fi
 
-       rm -f $file_name &> /dev/null
+       rm -f $file_name > /dev/null 2>&1
 
        $XFS_IO_PROG -f -c "pwrite 0 $file_len" \
-               -c "fsync" $file_name &> /dev/null
+               -c "fsync" $file_name > /dev/null 2>&1
        chmod 666 $file_name
 
        # All files are created as a non root user to prevent reserved blocks
@@ -111,8 +111,8 @@ _test_full_fs_punch()
 }
 
 # Make a small file system to fill
-_scratch_unmount &> /dev/null
-_scratch_mkfs_sized $(( 1536 * 1024 * 1024 )) &> /dev/null
+_scratch_unmount > /dev/null 2>&1
+_scratch_mkfs_sized $(( 1536 * 1024 * 1024 )) > /dev/null 2>&1
 _scratch_mount
 # Test must be able to write files with non-root permissions
 chmod 777 $SCRATCH_MNT
