Received: from cn.fujitsu.com ([59.151.112.132]:13064 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752007AbcLZAXY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Dec 2016 19:23:24 -0500
Subject: Re: [PATCH] fstests: btrfs: Test scrub and replace race for RAID56
References: <20161222020251.12272-1-quwenruo@cn.fujitsu.com>
 <20161224094525.GR1859@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <7c3f647d-9851-ce4a-f8f8-33b9c90e53e9@cn.fujitsu.com>
Date: Mon, 26 Dec 2016 08:23:18 +0800
MIME-Version: 1.0
In-Reply-To: <20161224094525.GR1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 12/24/2016 05:45 PM, Eryu Guan wrote:
> On Thu, Dec 22, 2016 at 10:02:51AM +0800, Qu Wenruo wrote:
>> Although by design, btrfs scrub and replace share the same code path, so
>> they are exclusive to each other.
>>
>> But the fact is, there is still some critical region not protected well,
>> so we can have the following kernel panic, especially easy to trigger on
>> RAID5/6 profiles.
>
> Could btrfs/069 reproduce the panic? It also races scrub and replace,
> but with fsstress running in background, raid5/6 profiles are part of
> the default test configs.

Yes, but the possibility is very low and depends on the test machine.
I never reproduced it with btrfs/069 on all my VMs, but can produce it 
on my physical machines.

Nor btrfs/069 supports TIME_FACTOR to improve the possibility.
>
> Also, is there a known fix available in Linus tree or btrfs tree? If
> not, I'd push this new test after there's a known fix (if it's worth a
> new test).

Not yet, still WIP.

I'll CC you as the fix is submitted.

Thanks,
Qu
>
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


