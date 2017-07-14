Received: from sandeen.net ([63.231.237.45]:36180 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdGNVnh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Jul 2017 17:43:37 -0400
Subject: Re: [PATCH] xfs/424: test xfs_db to ensure type size taken into
 account with new type
References: <20170712183112.5255-1-billodo@redhat.com>
 <20170714142733.7386-1-billodo@redhat.com>
 <75d5ddb1-dca8-c96c-f395-e4c213cd5cf0@sandeen.net>
 <20170714164723.GA8033@redhat.com>
 <3de7ad6b-6756-4555-e1ac-142926016524@sandeen.net>
 <20170714191101.GA28897@redhat.com> <20170714195836.GA12339@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <13978f55-d973-be92-7b81-fc1f8615f5af@sandeen.net>
Date: Fri, 14 Jul 2017 16:43:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170714195836.GA12339@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Bill O'Donnell <billodo@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 07/14/2017 02:58 PM, Bill O'Donnell wrote:
> On Fri, Jul 14, 2017 at 02:11:01PM -0500, Bill O'Donnell wrote:
>> On Fri, Jul 14, 2017 at 02:01:31PM -0500, Eric Sandeen wrote:
>>>
>>>
>>> On 07/14/2017 11:47 AM, Bill O'Donnell wrote:
>>>> On Fri, Jul 14, 2017 at 10:42:57AM -0500, Eric Sandeen wrote:
>>>
>>>
>>>>>> +# for different sector sizes, ensure no CRC errors are falsely reported
>>>>>> +
>>>>>> +# Supported types include: agf, agfl, agi, attr3, bmapbta,
>>>>>> +# bmapbtd, bnobt, cntbt, data, dir3, dqblk, inobt, inodata,
>>>>>> +# inode, log, rtbitmap, rtsummary, sb, symlink, text, finobt.
>>>>>
>>>>> This leaves me wondering why we don't test most of the above ;)
>>>>>
>>>>>> +# For various sector sizes, test some types that involve type size.
>>>>>> +for SECTOR_SIZE in 512 1024 2048 4096; do
>>>>>> +    $MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
>>>>>> +    for TYPE in agf agi agfl sb; do
>>>>>> +	DADDR=`$XFS_DB_PROG -c "$TYPE" -c "daddr" $SCRATCH_DEV | _filter_dbval`
>>>>>> +	$XFS_DB_PROG -c "$TYPE" -c "daddr 42" -c "daddr $DADDR" -c "type $TYPE" $SCRATCH_DEV
>>>>>
>>>>> Hm is there a reason for the first "-c $TYPE" or even the "daddr 42" in the line just above?
>>>> It's drawn from the reproducer test case.
>>>> The first "-c $TYPE" sets the object, "daddr 42" is an arbitrary address set. Without
>>>> the daddr change and change-back, the test will pass even without the recent xfs_db
>>>> xfsprogs change.
>>>
>>> Really?  Not here, xfsprogs-4.5.0 :
>>>
>>> # xfs_db -c "daddr 2" -c "type agi" fsfile
>>> Metadata CRC error detected at xfs_agi block 0x2/0x200
>>
>> Ahh, ok, you're correct - I'll modify the test accordingly.
> 
> Wait. I still think the object has to get set with "-c $TYPE". If not
> the crc error occurs even with the new xfs_db code:
> # xfs_db -V
> xfs_db version 4.12.0-rc2
> # xfs_db /dev/sda6
> xfs_db> daddr
> current daddr is 0
> xfs_db> daddr 2
> xfs_db> type agi
> Metadata CRC error detected at xfs_agi block 0x2/0x1000
> Metadata CRC error detected at xfs_agi block 0x2/0x1000

You've set daddr to 2... presumably on a 4k sector fs ...

> 
> And error is gone when the object is set and the daddr gets
> set to the correct value.
> [root@localhost xfsprogs-dev3]# xfs_db /dev/sda6
> xfs_db> agi
> xfs_db> daddr
> current daddr is 16

... but the agi is at daddr 16, not 2.

IOWS, you've told it the wrong type for daddr 2 (which is halfway through
the first superblock; daddr 2 is not the beginning of any on-disk structure)
so if you ask it to tell you about that block as an
AGI, it'll tell you that it's corrupted, because it's /not/ an agi.

> xfs_db> daddr 2
> xfs_db> daddr 16

If you correctly tell it to show you block 16 as an AGI...

> xfs_db> type agi

... it works.

-Eric
