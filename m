Received: from userp1040.oracle.com ([156.151.31.81]:34239 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759009AbcLBBMp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Dec 2016 20:12:45 -0500
Subject: Re: [PATCH] fstests: btrfs, add missing umount for raid5 tests 124
 and 125
References: <1479968719-10713-1-git-send-email-fdmanana@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <baee4697-7fee-e739-ad34-c4d8a45c453f@oracle.com>
Date: Fri, 2 Dec 2016 09:14:47 +0800
MIME-Version: 1.0
In-Reply-To: <1479968719-10713-1-git-send-email-fdmanana@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>


Hi,

I didn't add umount at end of the test because...
_check_btrfs_filesystem() does it, which gets called as this test does 
not specify _require_scratch_nocheck

----------------
  _check_btrfs_filesystem()
{
     device=$1

     # If type is set, we're mounted
     type=`_fs_type $device`
     ok=1

     if [ "$type" = "$FSTYP" ]
     then
         # mounted ...
         mountpoint=`_umount_or_remount_ro $device`  <----
     fi

     btrfsck $device >$tmp.fsck 2>&1
----------------


I faced the similar problem on some other tests and I found
adding the delay is the right approach. for eg:

--------------------------
diff --git a/tests/generic/298 b/tests/generic/298
index e85db1266fa9..4092efa6b961 100755
--- a/tests/generic/298
+++ b/tests/generic/298
@@ -92,7 +92,7 @@ echo "reflink of $n bytes took $delta seconds" >> 
$seqres.full
  test $delta -gt $timeout && _fail "reflink didn't stop in time, n=$n 
t=$delta"

  echo "Check scratch fs"
-sleep 2		# give it a few seconds to actually die...
+sleep 40		# give it a few seconds to actually die...

  # success, all done
  status=0
--------------------------


HTH
-Anand



On 11/24/16 14:25, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The tests mount the second device in the device pool but never unmount
> it, causing the next test to fail.
>
> Example:
>
> $ cat local.config
> export TEST_DEV=/dev/sdb
> export TEST_DIR=/home/fdmanana/btrfs-tests/dev
> export SCRATCH_MNT="/home/fdmanana/btrfs-tests/scratch_1"
> export SCRATCH_DEV_POOL="/dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg"
> export FSTYP=btrfs
>
> $ ./check btrfs/125 btrfs/126
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian3 4.8.0-rc8-btrfs-next-35+
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
> btrfs/125 23s ... 22s
> btrfs/126 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad)
>     --- tests/btrfs/126.out	2016-11-24 06:11:42.048372385 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad	2016-11-24 06:16:35.987988895 +0000
>     @@ -1,2 +1,5 @@
>      QA output created by 126
>     -pwrite: Disk quota exceeded
>     +ERROR: /dev/sdc is mounted
>     +mount: /dev/sdc is already mounted or /home/fdmanana/btrfs-tests/scratch_1 busy
>     +       /dev/sdc is already mounted on /home/fdmanana/btrfs-tests/scratch_1
>     +/home/fdmanana/btrfs-tests/scratch_1/test_file: Disk quota exceeded
>     ...
>     (Run 'diff -u tests/btrfs/126.out /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad'  to see the entire diff)
> Ran: btrfs/125 btrfs/126
> Failures: btrfs/126
> Failed 1 of 2 tests
>
> So just make sure those test unmount the device before they finish.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/124 | 1 +
>  tests/btrfs/125 | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index 2618a26..7206094 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -159,6 +159,7 @@ if [ "$checkpoint1" != "$checkpoint3" ]; then
>  	echo "Inital sum does not match with data on dev2 written by balance"
>  fi
>
> +$UMOUNT_PROG $dev2
>  _scratch_dev_pool_put
>  _test_mount
>
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 1062b87..91aa8d8 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -175,6 +175,7 @@ if [ "$checkpoint1" != "$checkpoint3" ]; then
>  	echo "Inital sum does not match with data on dev2 written by balance"
>  fi
>
> +$UMOUNT_PROG $dev2
>  _scratch_dev_pool_put
>  _test_mount
>
>
