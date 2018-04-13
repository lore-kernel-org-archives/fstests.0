Received: from aserp2130.oracle.com ([141.146.126.79]:50352 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDMWlp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Apr 2018 18:41:45 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3] fstests: btrfs/159 superblock corruption test case
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180409052830.4772-1-anand.jain@oracle.com> <20180413044335.GG2932@desktop>
Message-ID: <a4195afb-60cd-0183-3ce2-d99338bc0d51@oracle.com>
Date: Sat, 14 Apr 2018 06:43:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180413044335.GG2932@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


>> +# Test if the superblock corruption is handled correctly:
>> +# 	- Test fsid miss-match (csum ok) between primary and copy superblock
>> +#	Fixed by the ML patch:
>> +#	btrfs: check if the fsid in the primary sb and copy sb are same
>> +# 	- Test if the mount fails if the primary superblock csum is
>> +#		corrupted on any disk
>> +# 	- Test if the mount does not fail if the copy1 sb csum is corrupted
>> +#	Fixed by the ML patches:
>> +#	btrfs: verify superblock checksum during scan
>> +#	btrfs: verify checksum for all devices in mount context
> 
> Do you have a tree that I can pull from? I want to make sure the test
> does pass on patched kernel, but the patchset doesn't apply on v4.16
> kernel.

We have new discussions on whether to check for the alien-superblock and
the superblock-checksum at the mount and scan time respectively. And
depending on its outcome this test-case should be modified as well. So
can you please defer this fstest patch, for now, I shall send a revised
fstest patch when kernel patches gets integrated.

In any case, if you want to give a try, those patches are base on kdave 
repo at [1].
  [1]
  https://github.com/kdave/btrfs-devel.git misc-next

Thanks, Anand

> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
