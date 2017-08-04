Received: from sandeen.net ([63.231.237.45]:39408 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbdHDOha (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Aug 2017 10:37:30 -0400
Subject: Re: [PATCH] xfs/424: add check for crc and finobt
References: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
 <59842020.9070908@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <f6dd5a90-4179-d4df-cf33-5a62b7c1aa26@sandeen.net>
Date: Fri, 4 Aug 2017 09:37:29 -0500
MIME-Version: 1.0
In-Reply-To: <59842020.9070908@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/4/17 2:20 AM, Xiao Yang wrote:
> Hi Eric,
> 
> When finobt is disabled, xfs_db gets double crc errors on upstream xfsporgs-dev.
> as below(e.g. block size is 4096):
> ...
> xfs_db -c "daddr 16" -c "type finobt" /dev/sda11
> Metadata corruption detected at xfs_inobt block 0x10/0x1000
> Metadata corruption detected at xfs_inobt block 0x10/0x1000
> 
> Is this expected behavor?  Because xfs_db gets one crc error on v4.5 xfsprogs-dev.
> as below(e.g. block size is 4096):
> ...
> xfs_db -c "daddr 16" -c "type finobt" /dev/sda11
> Metadata CRC error detected at xfs_inobt block 0x10/0x200

So, errors is expected because you finobt is disabled, and you are asking
it to print a not-finobt block as a finobt.

I think the double printing is because upstream the code actually sets
the cursor twice after the commit which tried to fix the type-setting,
it's on my list to fix.

Thanks,
-Eric

> Thanks,
> Xiao Yang.
