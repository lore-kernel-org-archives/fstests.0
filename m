Received: from cn.fujitsu.com ([59.151.112.132]:6236 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbcGAB0r (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 21:26:47 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 1D13D41C0B8A
	for <fstests@vger.kernel.org>; Fri,  1 Jul 2016 09:26:43 +0800 (CST)
Subject: Re: [PATCH v2] geceric/362: check truncate can update file size
 correctly when truncate fails
References: <20160623082718.GF3226@eguan.usersys.redhat.com>
 <20160630082549.27201-1-wangxg.fnst@cn.fujitsu.com>
 <20160630135237.GG23649@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <5775C670.3060502@cn.fujitsu.com>
Date: Fri, 1 Jul 2016 09:25:04 +0800
MIME-Version: 1.0
In-Reply-To: <20160630135237.GG23649@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hello,

On 06/30/2016 09:52 PM, Eryu Guan wrote:
> On Thu, Jun 30, 2016 at 04:25:49PM +0800, Wang Xiaoguang wrote:
>> In btrfs, when truncate operation fails for enospc reason, file may still
>> have some disk blocks, but it will fail to update filesize accordingly.
>>
>> Kernel commit c0d2f61 has fixed this bug for btrfs:
>>      btrfs: fix disk_i_size update bug when ftruncate() fails
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>> v2: move this test to generic test and add comments why testcase
>> use reflink.
> Thanks for the updated version. Did it fail for you when testing on
> unpatched kernel? I ran the test more than 10 times on 4.6 kernel (which
> doesn't have the fix) and all passed, as well as RHEL7 kernel.
>
> Can you please confirm?
OK, please wait a while :)

Regards,
Xiaoguang Wang
>
> Thanks,
> Eryu
>
>



