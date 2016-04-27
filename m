Received: from cn.fujitsu.com ([59.151.112.132]:8231 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751920AbcD0FQU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2016 01:16:20 -0400
Message-ID: <5720462B.4050900@cn.fujitsu.com>
Date: Wed, 27 Apr 2016 12:55:07 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] fstests: xfs: add necessary version check for xfs/122
References: <1458549088-468-1-git-send-email-wangxg.fnst@cn.fujitsu.com> <20160322225614.GW11812@dastard>
In-Reply-To: <20160322225614.GW11812@dastard>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hello,

On 03/23/2016 06:56 AM, Dave Chinner wrote:
> On Mon, Mar 21, 2016 at 04:31:28PM +0800, Xiaoguang Wang wrote:
>> From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>>
>> Since commit c0cfa5651f2d ("xfs/122: update against xfsprogs 4.3"), xfs/122
>> has been updated against xfsprogs 4.3, so add necessary version check.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> 
> This sort of version test belongs in autoconf, not the tests
> themselves.
Would you please give me some hints about how to add version test
in autoconf, also in xfs/188, I see similar usage:
    if [ $XFSPROGS_VERSION -lt 21000 ]; then
        _notrun "this test requires case-insensitive support"
    fi

Regards,
Xiaoguang Wang

> 
> Cheers,
> 
> Dave.
> 



