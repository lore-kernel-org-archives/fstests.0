Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:2289 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbbFQWP7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 18:15:59 -0400
Date: Thu, 18 Jun 2015 08:15:25 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] generic: concurrent IO test with mixed IO types
Message-ID: <20150617221525.GJ10224@dastard>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com>
 <1434014273-1059-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434014273-1059-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 11, 2015 at 05:17:53PM +0800, Eryu Guan wrote:
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

Ok, so that warning is expected on XFS - that's intentional,
WARN_ONCE() output indicating a data coherency problem has occurred
because of the because the application is mixing buffered/mmap IO
with direct IO on the same file and direct Io has been unable to
cleanly invalidate the cache. i.e.  it's information to us
developers explaining why the user is complaining about data
corruption....

So this test is never going to pass on XFS unless you tell the test
harness to ignore the dmesg output...

> And it ever paniced kernel in mm code and hung xfs.

The "hung XFS" case will probably be the pipe mutex inversion
problem in the generic splice code. i.e.

.splice_read -> xfs_file_splice_read -> IOLOCK_SHARED ->
generic_file_splice_read -> splice_to_pipe -> pipe_lock()

vs:

iter_file_splice_write -> pipe_lock() -> vfs_iter_write ->
xfs_file_write_iter -> xfs_file_buffered_aio_write -> IOLOCK_EXCL

Can you confirm this? If so, there's not much we can actually do
about this - the recent big splice rewrite replaced the
pipe_lock/i_mutex inversion deadlock with a different pipe_lock
inversion deadlock....

> diff --git a/tests/generic/group b/tests/generic/group
> index 0c8964c..2e534a5 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -92,6 +92,7 @@
>  087 perms auto quick
>  088 perms auto quick
>  089 metadata auto
> +090 auto rw stress

Hence I'm not sure "auto" is the correct group here. "dangerous" is
more likely because it is exercising a problem we can't fix and will
prevent the auto test group from making progress past this test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
