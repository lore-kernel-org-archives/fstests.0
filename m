Received: from mx1.redhat.com ([209.132.183.28]:34930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201AbbKSDkr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Nov 2015 22:40:47 -0500
Date: Thu, 19 Nov 2015 11:40:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] fstests: Make generic/081 run in old version of lvm
Message-ID: <20151119034042.GN2535@eguan.usersys.redhat.com>
References: <06bb2b60251a0897a9b16b3f5d003b8749a36406.1447841971.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06bb2b60251a0897a9b16b3f5d003b8749a36406.1447841971.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 18, 2015 at 06:19:49PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> generic/081 failed in RHEL 6.3:
>  # ./check generic/081
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 kerneldev 4.2.0-rc5_HEAD_d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754_+
>  MKFS_OPTIONS  -- /dev/vdd
>  MOUNT_OPTIONS -- /dev/vdd /var/ltf/tester/scratch_mnt
> 
>  generic/081
>  [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/081.out.bad)
>     --- tests/generic/081.out   2015-07-13 17:07:03.000000000 +0800
>     +++ /var/lib/xfstests/results//generic/081.out.bad  2015-10-28 12:20:49.000000000 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 081
>      Silence is golden
>     +ERROR: checking status of /dev/mapper/vg_081-base_081: No such file or directory
>  Ran: generic/081
>  Failures: generic/081
>  Failed 1 of 1 tests
> 
> Reason:
>  Command of "lvm lvcreate --yes" failed because lvm in RHEL 6.3
>  don't support '--yes' option.
> 
>  RHEL 6.3(without --yes option):
>  # lvm version
>    LVM version:     2.02.95(2)-RHEL6 (2012-05-16)
>    Library version: 1.02.74-RHEL6 (2012-05-16)
>    Driver version:  4.32.0
>  # lvm lvcreate --yes --version
>  lvcreate: unrecognized option '--yes'
>    Error during parsing of command line.
>  # echo $?
>  3
>  #
> 
>  RHEL 7.1(with --yes option):
>  # lvm version
>    LVM version:     2.02.115(2)-RHEL7 (2015-01-28)
>    Library version: 1.02.93-RHEL7 (2015-01-28)
>    Driver version:  4.33.0
>  # lvm lvcreate --yes --version
>    LVM version:     2.02.115(2)-RHEL7 (2015-01-28)
>    Library version: 1.02.93-RHEL7 (2015-01-28)
>    Driver version:  4.33.0
>  # echo $?
>  0
>  #
> 
>  Fedora release 20(with --yes option):
>  (Support --yes like RHEL 7.1, omit logs)
>  lvm version: 2.02.106(2) (2014-04-10)
> 
> Fix:
>  Add a condition to to check if current lvm support --yes option,
>  Tested in above RHEL 6.3 platform.

This "Fix" needs update too.

And generic/108 uses "--yes" too, can you please fix it all together?
Thanks!

Eryu

> 
> Changelog v2->v3:
>  Use unique way for old and new version of lvm, suggested-by:
>  Dave Chinner <david@fromorbit.com>
> 
> Changelog v1->v2:
>  Use yes pipe, suggested by: Eryu Guan <eguan@redhat.com>
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Suggested-by: Eryu Guan <eguan@redhat.com>
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> ---
>  tests/generic/081 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 8334ec9..54e7c3c 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -65,7 +65,7 @@ mkdir -p $mnt
>  # lvm uses some space for metadata
>  _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
>  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> -$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
>  # wait for lvcreation to fully complete
>  $UDEV_SETTLE_PROG >>$seqres.full 2>&1
>  
> -- 
> 1.8.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
