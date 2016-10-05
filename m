Received: from mx1.redhat.com ([209.132.183.28]:45812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbcJEQdf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Oct 2016 12:33:35 -0400
Date: Wed, 5 Oct 2016 18:33:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161005163332.GA15121@redhat.com>
References: <20160926161856.GB32458@quack2.suse.cz>
 <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004165826.GA10239@redhat.com>
 <20161004200327.GX9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004200327.GX9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/05, Dave Chinner wrote:
>
> On Tue, Oct 04, 2016 at 06:58:27PM +0200, Oleg Nesterov wrote:
> > I removed this test and then the next run (after reboot) hangs at xfs/073 with
> > a lot of errors in dmesg like
> >
> > 	XFS (loop2): Failing async write on buffer block 0x9600790. Retrying async write.
> > 	blk_update_request: I/O error, dev loop2, sector 8389920
> > 	loop: Write error at byte offset 4295647232, length 4096.
>
> tests will dump lots of errors into dmesg. That doesn't mean there's
> a problem - many tests are designed to exercise error paths. That,
> however, looks like a loop device problem.
>
> xfs/073 is using loop devices internally itself, so this ends up
> with XFS on loop2 on XFS on loop1. That loop2 device is 100GB in
> size, and the test copies the xfstests source tree to a loopback
> filesystem image in $SCRATCH_DEV mounted on $TEST_DIR/$$.
>
> The issue is, most likely, that your TEST_DIR and SCRATCH_MNT are
> rooted in the xfstests source tree. Hence copying the xfstests
> source tree will also try to copy the 8GB image files into the
> filesystems that the image files contain. Which, clearly, will
> eventually result in ENOSPC errors when writing to the underlying
> loop device...
>
> Put your TEST_DIR and SCRATCHMNT mount points outside the xfstests
> directory, and this should go away.

Yes, thanks, xfs/073 no longer hangs.

Oleg.

