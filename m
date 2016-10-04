Received: from mx1.redhat.com ([209.132.183.28]:33252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbcJDQ6a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 4 Oct 2016 12:58:30 -0400
Date: Tue, 4 Oct 2016 18:58:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161004165826.GA10239@redhat.com>
References: <20160926160724.GA6739@redhat.com>
 <20160926160806.GB6748@redhat.com>
 <20160926161856.GB32458@quack2.suse.cz>
 <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004114341.GA8572@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/04, Oleg Nesterov wrote:
>
> This time it hangs after generic/274:
>
> 	--- tests/generic/274.out	2016-10-04 04:23:24.209006171 -0400
> 	+++ /root/XFS/xfstests-dev/results//generic/274.out.bad	2016-10-04 05:17:49.291742498 -0400
> 	@@ -3,3 +3,4 @@
> 	preallocation test
> 	------------------------------
> 	done
> 	+./common/rc: line 344:  4693 Segmentation fault      exit
> 	...
> 	(Run 'diff -u tests/generic/274.out /root/XFS/xfstests-dev/results//generic/274.out.bad'  to see the entire diff)
>
> because of kernel bug:
>
> 	[ 2730.242537] run fstests generic/274 at 2016-10-04 05:17:34
> 	[ 2730.738352] XFS (loop1): Mounting V5 Filesystem
> 	[ 2730.741451] XFS (loop1): Ending clean mount
> 	[ 2744.508698] ------------[ cut here ]------------
> 	[ 2744.509190] kernel BUG at ./include/linux/swap.h:276!

I removed this test and then the next run (after reboot) hangs at xfs/073 with
a lot of errors in dmesg like

	XFS (loop2): Failing async write on buffer block 0x9600790. Retrying async write.
	blk_update_request: I/O error, dev loop2, sector 8389920
	loop: Write error at byte offset 4295647232, length 4096.

Oleg.

