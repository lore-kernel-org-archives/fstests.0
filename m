Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49357 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752398AbdLDW2q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Dec 2017 17:28:46 -0500
Date: Tue, 5 Dec 2017 09:28:42 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: generic/399 and xfs_io pwrite command
Message-ID: <20171204222842.GX4094@dastard>
References: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org, Emil Karlson <jkarlson@tuxera.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 30, 2017 at 04:21:47PM +0200, Ari Sundholm wrote:
> Hi!
> 
> While debugging an issue, we found out that generic/399 seems to
> rely on a behavior that is specific to ext4 in the following section
> of code:
> ----------------8<--------snip--------8<------------------------------
> #
> # Write files of 1 MB of all the same byte until we hit ENOSPC.
> Note that we
> # must not create sparse files, since the contents of sparse files are not
> # stored on-disk.  Also, we create multiple files rather than one big file
> # because we want to test for reuse of per-file keys.
> #
> total_file_size=0
> i=1
> while true; do
> 	file=$SCRATCH_MNT/encrypted_dir/file$i
> 	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
> 		if ! grep -q 'No space left on device' $tmp.out; then
> 			echo "FAIL: unexpected pwrite failure"
> 			cat $tmp.out
> 		elif [ -e $file ]; then
> 			total_file_size=$((total_file_size + $(stat -c %s $file)))
> 		fi
> 		break
> 	fi
> 	total_file_size=$((total_file_size + $(stat -c %s $file)))
> 	i=$((i + 1))
> 	if [ $i -gt $fs_size_in_mb ]; then
> 		echo "FAIL: filesystem never filled up!"
> 		break
> 	fi
> done
> ----------------8<--------snip--------8<------------------------------
> 
> What happens with ext4 is that the xfs_io command gives a nonzero
> exit value not when the pwrite command fails with ENOSPC but during
> the *next* iteration when opening the file fails with ENOSPC. Turns
> out the pwrite command failing does not cause xfs_io to give a
> nonzero exit value.

That implies ext4 is returning zero bytes written to the pwrite()
call rather than ENOSPC. i.e.:

                bytes = do_pwrite(file->fd, off, cnt, buffersize,
                                pwritev2_flags);
                if (bytes == 0)
                        break;
                if (bytes < 0) {
                        perror("pwrite");
                        return -1;
                }

So if it's exiting with no error, then we can't have got an error
from ext4 at ENOSPC. If that's the case, it probably should be
considered an ext4 bug, not an issue with xfs_io...

Can you run this under strace to determine if this is what is really
happening? 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
