Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:51154 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751583AbbFIW3f (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2015 18:29:35 -0400
Date: Wed, 10 Jun 2015 08:29:33 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
Message-ID: <20150609222933.GC24666@dastard>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com>
 <1433767271-30562-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433767271-30562-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 08, 2015 at 08:41:11PM +0800, Eryu Guan wrote:
> Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O on the
> same files.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> This fio job file has been proven to be potent, it triggers WARNINGs on ext4
> and xfs with 4.1-rc6 kernel.
> 
> ext4: WARNING: at fs/ext4/inode.c:1328
> xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_dio_aio_write+0x176/0x2a8 [xfs]()
> 
> The ext4 issue should be fixed by Lukas's patch
> ext4: fix reservation release on invalidatepage for delalloc fs
> 
> And it ever paniced kernel in mm code and hung xfs.
> 
> I reduced the numjobs and iodepth to reduce the test time(~25s on my test host)
> and scale them by $LOAD_FACTOR. And it still could trigger the warning on ext4
> and xfs with reduced workload.
> 
> v2:
> - use mktemp to create tmp fio job file
....
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +fio_config=`mktemp`
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15

By removing the definition of $tmp, you are now dumping all
the temporary files the test harnes creates in /.

> +_cleanup()
> +{
> +	cd /
> +	rm -f $fio_config
> +}

And now not removing them when the test complests...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
