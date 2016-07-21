Received: from cn.fujitsu.com ([59.151.112.132]:46655 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970AbcGUH1O (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 03:27:14 -0400
Subject: Re: [PATCH] btrfs: test whether fallocate(2) can preallocate half of
 the whole fs space
References: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
 <20160720190009.GA13348@infradead.org>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <579078B6.2020604@cn.fujitsu.com>
Date: Thu, 21 Jul 2016 15:24:38 +0800
MIME-Version: 1.0
In-Reply-To: <20160720190009.GA13348@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hello,

On 07/21/2016 03:00 AM, Christoph Hellwig wrote:
> On Wed, Jul 20, 2016 at 03:34:50PM +0800, Wang Xiaoguang wrote:
>> Currently in btrfs, there is something wrong with data space reservation.
>> For example, if we try to preallocate more than haf of whole fs space,
>> ENOSPC will occur, but indeed fs still has free space to satisfy this
>> request.
>>
>> To easily reproduce this bug, this test case needs fs is mixed mode(btrfs
>> specific), so put this test case in btrfs group, not generic group.
> But the actual test isn't btrfs specific, and other file systems might
> have issues in this area as well.  Please add it to the generic group
> instead.
OK, new version will be sent soon.
ext4 & xfs pass the test, btrfs fails.

Regards,
Xiaoguang Wang

>



