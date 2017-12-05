Received: from mx2.mpynet.fi ([82.197.21.85]:61612 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdLEO27 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Dec 2017 09:28:59 -0500
Subject: Re: generic/399 and xfs_io pwrite command
References: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
 <20171204222842.GX4094@dastard>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <35d2712c-b036-d017-2d42-f74bbc4444a9@tuxera.com>
Date: Tue, 5 Dec 2017 16:23:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171204222842.GX4094@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Emil Karlson <jkarlson@tuxera.com>
List-ID: <fstests@vger.kernel.org>

On 12/05/2017 12:28 AM, Dave Chinner wrote:
> On Thu, Nov 30, 2017 at 04:21:47PM +0200, Ari Sundholm wrote:
>> Hi!
>>
>> While debugging an issue, we found out that generic/399 seems to
>> rely on a behavior that is specific to ext4 in the following section
>> of code:
>> ----------------8<--------snip--------8<------------------------------
>> #
>> # Write files of 1 MB of all the same byte until we hit ENOSPC.
>> Note that we
>> # must not create sparse files, since the contents of sparse files are not
>> # stored on-disk.  Also, we create multiple files rather than one big file
>> # because we want to test for reuse of per-file keys.
>> #
>> total_file_size=0
>> i=1
>> while true; do
>> 	file=$SCRATCH_MNT/encrypted_dir/file$i
>> 	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
>> 		if ! grep -q 'No space left on device' $tmp.out; then
>> 			echo "FAIL: unexpected pwrite failure"
>> 			cat $tmp.out
>> 		elif [ -e $file ]; then
>> 			total_file_size=$((total_file_size + $(stat -c %s $file)))
>> 		fi
>> 		break
>> 	fi
>> 	total_file_size=$((total_file_size + $(stat -c %s $file)))
>> 	i=$((i + 1))
>> 	if [ $i -gt $fs_size_in_mb ]; then
>> 		echo "FAIL: filesystem never filled up!"
>> 		break
>> 	fi
>> done
>> ----------------8<--------snip--------8<------------------------------
>>
>> What happens with ext4 is that the xfs_io command gives a nonzero
>> exit value not when the pwrite command fails with ENOSPC but during
>> the *next* iteration when opening the file fails with ENOSPC. Turns
>> out the pwrite command failing does not cause xfs_io to give a
>> nonzero exit value.
> 
> That implies ext4 is returning zero bytes written to the pwrite()
> call rather than ENOSPC. i.e.:
> 
>                  bytes = do_pwrite(file->fd, off, cnt, buffersize,
>                                  pwritev2_flags);
>                  if (bytes == 0)
>                          break;
>                  if (bytes < 0) {
>                          perror("pwrite");
>                          return -1;
>                  }
 >
> So if it's exiting with no error, then we can't have got an error
> from ext4 at ENOSPC. If that's the case, it probably should be
> considered an ext4 bug, not an issue with xfs_io...
>

No, according to what we've observed, that is not what happens. The 
pwrite() call does fail and errno is ENOSPC after the call. The 
immediate problem is that xfs_io does not reflect this failure in its 
exit value and thus the check in generic/399 does not work in this case. 
Only when open() fails during the next iteration does xfs_io give a 
nonzero exit value and cause the check in the test case to allow the 
test case to end successfully.

What is specific to ext4 here is, as stated in my original message, that 
open() fails. Some other file system may still be able to create 
zero-length files, which becomes a problem with this test case because 
the subsequent pwrite() failures are basically ignored.

> Can you run this under strace to determine if this is what is really
> happening?

This is the relevant part of the strace for the second-to-last iteration:
----------------8<--------snip--------8<------------------------------
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 368640) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 372736) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 376832) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 380928) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 385024) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 389120) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 393216) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 397312) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 401408) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 405504) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 409600) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 413696) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 417792) = 4096
pwrite64(3, 
"\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315\315"..., 
4096, 421888) = -1 ENOSPC (No space left on device)
dup(2)                                  = 4
fcntl(4, F_GETFL)                       = 0x8001 (flags 
O_WRONLY|O_LARGEFILE)
close(4)                                = 0
write(2, "pwrite: No space left on device\n", 32pwrite: No space left on 
device
) = 32
exit_group(0)                           = ?
+++ exited with 0 +++
----------------8<--------snip--------8<------------------------------
(Please note that xfs_io gives an exit value of 0)

This is the relevant part of the strace for the last iteration:
----------------8<--------snip--------8<------------------------------
open("/mnt/scratch/encrypted_dir/file58", O_RDWR|O_CREAT, 0600) = -1 
ENOSPC (No space left on device)
dup(2)                                  = 3
fcntl(3, F_GETFL)                       = 0x8001 (flags 
O_WRONLY|O_LARGEFILE)
close(3)                                = 0
write(2, "/mnt/scratch/encrypted_dir/file5"..., 
59/mnt/scratch/encrypted_dir/file58: No space left on device
) = 59
exit_group(1)                           = ?
+++ exited with 1 +++
----------------8<--------snip--------8<------------------------------

Thanks,
Ari Sundholm
ari@tuxera.com

> Cheers,
> 
> Dave.
> 

