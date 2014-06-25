Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:61760 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752771AbaFYKG0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 25 Jun 2014 06:06:26 -0400
Message-ID: <53AA9EDE.8020001@cn.fujitsu.com>
Date: Wed, 25 Jun 2014 18:05:18 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfstests: add test for ext4 fallocate collapse range
 check
References: <1403157004-25112-1-git-send-email-gux.fnst@cn.fujitsu.com> <20140619065644.GL4453@dastard>
In-Reply-To: <20140619065644.GL4453@dastard>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 06/19/2014 02:56 PM, Dave Chinner wrote:
> On Thu, Jun 19, 2014 at 01:50:04PM +0800, Xing Gu wrote:
>> This is a test to verify the procedure which checks whether
>> offset + len is bigger than i_size is removed from do_fallocate
>> in collapse range to the file system, and ensure that i_size is
>> not going to change.
>>
>> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
>
> Does the test really need 3 minutes?

Actually, this case can easily reproduce the issue below 30s.

>
> We can't keep adding tests that take minutes to *maybe* hit a
> regression. This isn't even testing a regression - the
> COLLAPSE_RANGE feature was introduced in 3.15-rc1 and this bug fixed
> in 3.15-rc3, so there are no kernels out there that have this
> bug in them.
>
> IOWs, I really don't think we should be the runtime of a typical
> test cycle by 5% to exercise this non-bug. Maybe 30s at most, but a
> shorter, directly targeted test would be better.
>
> And FWIW, there's nothing ext4 specific about this test - it should
> be in the generic group if we are going to add it.

Indeed, it's not ext4 specific.

What about modifying this case according to Lukas's comment?

Thanks!

Regards,
Xing Gu

>
> Cheers,
>
> Dave.
>
