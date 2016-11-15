Received: from cn.fujitsu.com ([59.151.112.132]:36539 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S941286AbcKOJPm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2016 04:15:42 -0500
Subject: Re: [PATCH] fstests: Block btrfs from test case generic/372
References: <20161115081410.6779-1-quwenruo@cn.fujitsu.com>
 <20161115085741.GA25495@infradead.org>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <6c9569ed-44bd-af62-bbe0-92ddd4e65a92@cn.fujitsu.com>
Date: Tue, 15 Nov 2016 17:15:28 +0800
MIME-Version: 1.0
In-Reply-To: <20161115085741.GA25495@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/15/2016 04:57 PM, Christoph Hellwig wrote:
> On Tue, Nov 15, 2016 at 04:14:10PM +0800, Qu Wenruo wrote:
>> Since btrfs always return the whole extent even part of it is shared
>> with other files, so the hole/extent counts differs for "file1" in this
>> test case.
>
> This would need an extremly detailed comment in the test case on why
> btrfs is skipped IFF we decide to apply it.  That being siad I think
> reporing shared extents incorrectly is a bug independent of how they
> are implemented internally.
>
>
I don't think it's a bug.

It's just the different granularity on SHARED flag.

SHARED flag returned by btrfs has its meaning, since it is shared by 
other files/subvolumes.

And further more, due to the extent booking mechanism in btrfs, one 
extent won't be modified/removed until all its referencer got removed.

This quite lazy behavior co-operates with the lazy SHARED flag well.
So IMHO it's just granularity difference not a bug.


Not to mention that, fiemap bytenr returned from btrfs doesn't makes 
sense at all, unless you know how to map it into device.
 From this aspect, btrfs fiemap is already a so-called "bug" compared to 
xfs/ext*.

Thanks,
Qu


