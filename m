Received: from mx1.redhat.com ([209.132.183.28]:55807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463AbbJ1MJV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 28 Oct 2015 08:09:21 -0400
Date: Wed, 28 Oct 2015 20:09:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: Make generic/081 run in old version of lvm
Message-ID: <20151028120918.GL3558@dhcp-13-216.nay.redhat.com>
References: <b713ea025856d6540e7b9c1c42c04c1770d34fd8.1446020458.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b713ea025856d6540e7b9c1c42c04c1770d34fd8.1446020458.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 28, 2015 at 04:21:13PM +0800, Zhaolei wrote:
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

I don't have a rhel6.3 host around so I cannot do the test at the
moment(lvm shipped with RHEL6.7 has --yes support), but in my test (with
RHEL6.7) generic/081 hangs when testing on xfs without --yes option. So
I don't think simply removing --yes is a good idea.

I tested "yes | lvm lvcreate ..." and it works fine on my host. Also
generic/108 has the same issue.

Thanks,
Eryu
