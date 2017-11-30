Received: from mx1.mpynet.fi ([82.197.21.84]:11348 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbdK3OVu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 Nov 2017 09:21:50 -0500
From: Ari Sundholm <ari@tuxera.com>
Subject: generic/399 and xfs_io pwrite command
Message-ID: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
Date: Thu, 30 Nov 2017 16:21:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Emil Karlson <jkarlson@tuxera.com>
List-ID: <fstests@vger.kernel.org>

Hi!

While debugging an issue, we found out that generic/399 seems to rely on 
a behavior that is specific to ext4 in the following section of code:
----------------8<--------snip--------8<------------------------------
#
# Write files of 1 MB of all the same byte until we hit ENOSPC.  Note 
that we
# must not create sparse files, since the contents of sparse files are not
# stored on-disk.  Also, we create multiple files rather than one big file
# because we want to test for reuse of per-file keys.
#
total_file_size=0
i=1
while true; do
	file=$SCRATCH_MNT/encrypted_dir/file$i
	if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> $tmp.out; then
		if ! grep -q 'No space left on device' $tmp.out; then
			echo "FAIL: unexpected pwrite failure"
			cat $tmp.out
		elif [ -e $file ]; then
			total_file_size=$((total_file_size + $(stat -c %s $file)))
		fi
		break
	fi
	total_file_size=$((total_file_size + $(stat -c %s $file)))
	i=$((i + 1))
	if [ $i -gt $fs_size_in_mb ]; then
		echo "FAIL: filesystem never filled up!"
		break
	fi
done
----------------8<--------snip--------8<------------------------------

What happens with ext4 is that the xfs_io command gives a nonzero exit 
value not when the pwrite command fails with ENOSPC but during the 
*next* iteration when opening the file fails with ENOSPC. Turns out the 
pwrite command failing does not cause xfs_io to give a nonzero exit value.

With one of our filesystems, pwrite fails considerably earlier than we 
become unable to create new files, making this test case misbehave as 
the pwrite failure is basically ignored while we keep creating new empty 
files.

While I understand that supporting out-of-tree filesystems is not what 
is done in fstests land, this issue looks like it is generic enough to 
at least warrant some discussion. It is not inconceivable at all that an 
  in-tree filesystem could have something else than this specific ext4 
behavior.

The issue itself could either be fixed in xfsprogs, allowing the pwrite 
failure to propagate to the exit value in some manner, or in fstests by 
having an alternate/additional mechanism for detecting the ENOSPC (we do 
have some simple, nonintrusive ideas, if there is interest).

Thanks,
Ari Sundholm
ari@tuxera.com
