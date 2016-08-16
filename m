Received: from sandeen.net ([63.231.237.45]:39507 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbcHPCsI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 22:48:08 -0400
Subject: Re: [PATCH] xfs/263: test xfs_quota "state" command
References: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
 <20160815053626.GF27776@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5efd2e7f-5cd9-2a01-4a8f-b9308f3bd13d@sandeen.net>
Date: Mon, 15 Aug 2016 21:48:06 -0500
MIME-Version: 1.0
In-Reply-To: <20160815053626.GF27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 8/15/16 12:36 AM, Eryu Guan wrote:
> On Fri, Aug 12, 2016 at 05:53:04PM -0500, Eric Sandeen wrote:
>> This exercises the xfs_quota "state" command for every
>> combination of user, group, and project quota enablement
>> on both crc (with project quota inode on disk) and non-crc
>> (where project quota overlaps group quota on disk) filesystems.
>>
>> It currently requires patches to the upstream kernel
>> ("quota: fill in Q_XGETQSTAT inode information for inactive quotas")
>> and to xfsprogs ("xfs_quota: wire up XFS_GETQSTATV") to pass.
> 
> I've applied these patches to kernel (4.8-rc1 based) and xfsprogs
> (4.7-rc1 based), and the quota filter fix to xfstests, but I still saw
> failures on this, did I miss anything?
> 
> [root@dhcp-66-86-11 xfstests]# diff -u tests/xfs/263.out /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad
> --- tests/xfs/263.out   2016-08-15 10:56:23.973000000 +0800
> +++ /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad        2016-08-15 13:29:48.934000000 +0800
> @@ -9,11 +9,11 @@
>  Group quota state on SCRATCH_MNT (SCRATCH_DEV)
>    Accounting: OFF
>    Enforcement: OFF
> -  Inode: N/A
> +  Inode: #0 (0 blocks, 0 extents)
>  Project quota state on SCRATCH_MNT (SCRATCH_DEV)
>    Accounting: OFF
>    Enforcement: OFF
> -  Inode: N/A
> +  Inode: #0 (0 blocks, 0 extents)

strange, that's the kind of thing the kernel patch was intended to fix.

I meant to retest from scratch on bleeding-edge upstream, but too many
things got in the way today.  Will try again tomorrow...

-Eric
