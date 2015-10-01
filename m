Received: from tbjjbihbhebab.turbo-smtp.net ([199.187.174.101]:22184 "HELO
	tbjjbihbhebab.turbo-smtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750954AbbJAIs1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 1 Oct 2015 04:48:27 -0400
Message-ID: <560CF355.7050200@sysam.it>
Date: Thu, 01 Oct 2015 10:48:21 +0200
From: Angelo Dureghello <angelo@sysam.it>
MIME-Version: 1.0
Subject: Re: help on xfs test results
References: <560C69D9.6020807@sysam.it>
In-Reply-To: <560C69D9.6020807@sysam.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

many thanks

On 30/09/2015 01:28, Dave Chinner wrote:
> On Wed, Sep 30, 2015 at 01:03:36AM +0200, Angelo Dureghello wrote:
>> Hi all,
>>
>> thanks for all the great support until now.
>>
>> I finally completed all the tests in my arm 32 bit target platform,
>> and have still 4 hopefully false positives. Below my comments:
>>
>>
>>
>> generic tests
>>
>> *** 256
>> /media/p6/fill.161/3.bin: No space left on device
>>
>>   - output mismatch (see
>> /home/angelo/xfstests/results//./generic/256.out.bad)
>>      --- tests/./generic/256.out	2015-09-17 10:54:06.815078834 +0000
>>      +++
>> /home/angelo/xfstests/results//./generic/256.out.bad	2000-01-01
>> 00:42:13.822058816 +0000
>>      @@ -1 +1,2229 @@
>>       QA output created by 256
>>      +wrote 1073741824/1073741824 bytes at offset 0
>>      +1 GiB, 262144 ops; 0:02:35.00 (6.602 MiB/sec and 1690.0353 ops/sec)
>>      +pwrite64: No space left on device
>>      +pwrite64: No space left on device
>>      +pwrite64: No space left on device
>>      +pwrite64: No space left on device
>>      ...
>
> There should be ENOSPC being reported during the test but they
> should all be redirected to /dev/null. Perhaps shomething wrong with
> redirection?

Well, this is generic/256,
the expected output is null,
my output btw is full of failed and also non-failed operations.
Sounds quite strange.

QA output created by 256
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 262144 ops; 0:01:58.00 (8.653 MiB/sec and 2215.1991 ops/sec)
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
pwrite64: No space left on device
/media/p6/fill/13.bin: No space left on device
/media/p6/fill/14.bin: No space left on device
/media/p6/fill/15.bin: No space left on device
/media/p6/fill/16.bin: No space left on device
/media/p6/fill/17.bin: No space left on device
/media/p6/fill/18.bin: No space left on device
/media/p6/fill/19.bin: No space left on device
/media/p6/fill/20.bin: No space left on device
wrote 8192/8192 bytes at offset 0
8 KiB, 2 ops; 0.0000 sec (2.031 MiB/sec and 519.8856 ops/sec)
pwrite64: No space left on device
pwrite64: No space left on device
wrote 8192/8192 bytes at offset 0
8 KiB, 2 ops; 0.0000 sec (427.122 KiB/sec and 106.7806 ops/sec)
pwrite64: No space left on device
pwrite64: No space left on device
wrote 8192/8192 bytes at offset 0
8 KiB, 2 ops; 0.0000 sec (49.019 KiB/sec and 12.2548 ops/sec)
pwrite64: No space left on device
pwrite64: No space left on device
wrote 8192/8192 bytes at offset 0
.....



>
>> xfs tests
>> **** 020
>
> You need to be more explicit about the test description. Does "020"
> mean generic/020, xfs/020, btrfs/020, etc?
>
>> creates a 60t, fails if > 16t (Growing the data section failed),
>> could be normal in 32bit arch ?
>
> 32 bit system can't use a 60TB block device or file, so this needs
> a "_requires_64bit_blockdev" type of check.
>

ack, thanks.

>> **** 080
>> Looks like not XFS issue. mmap() failed, no more memory after 2,5G
>
> various tests will fail if you don't have enough memory or address
> space. Expunge them from your normal testing if it's just memory
> allocation that is the problem.

ack, thanks.


>
>> **** 136
>> very long test, output similar but different values
>
> xfs/136 shouldn't run your machine out of memory. If it does, then
> you probably should start looking for a memory leak...
>

Sorry, was not precise in explaining this.
This is xfs/136,
Test is very long and full of differences compared to the expected
.out. Strange thing is that the the messages are very similar, but
values displayed are different.

xfs/136	 - output mismatch (see
/home/angelo/xfstests/results//xfs/136.out.bad)
      --- tests/xfs/136.out	2015-09-17 10:54:06.984088997 +0000
      +++ /home/angelo/xfstests/results//xfs/136.out.bad	2015-09-20


# diff 136.out.bad ../../tests/xfs/136.out
17c17
< core.forkoff = 47 (376 bytes)
---
 > core.forkoff = 24 (192 bytes)
34c34
< core.forkoff = 47 (376 bytes)
---
 > core.forkoff = 24 (192 bytes)
57c57
< core.forkoff = 44 (352 bytes)
---
 > core.forkoff = 24 (192 bytes)
92c92
< core.forkoff = 37 (296 bytes)
---
 > core.forkoff = 24 (192 bytes)
150,250c150,153
< core.naextents = 0
< core.forkoff = 22 (176 bytes)
< core.aformat = 1 (local)
< a.sfattr.hdr.totsize = 235
< a.sfattr.hdr.count = 16
< a.sfattr.list[0].namelen = 6
< a.sfattr.list[0].valuelen = 5
< a.sfattr.list[0].root = 0
< a.sfattr.list[0].secure = 0
< a.sfattr.list[0].name = "name.1"
< a.sfattr.list[0].value = "value"
< a.sfattr.list[1].namelen = 6
< a.sfattr.list[1].valuelen = 5
< a.sfattr.list[1].root = 0
< a.sfattr.list[1].secure = 0
< a.sfattr.list[1].name = "name.2"
< a.sfattr.list[1].value = "value"
< a.sfattr.list[2].namelen = 6
< a.sfattr.list[2].valuelen = 5
< a.sfattr.list[2].root = 0
< a.sfattr.list[2].secure = 0
< a.sfattr.list[2].name = "name.3"
< a.sfattr.list[2].value = "value"
< a.sfattr.list[3].namelen = 6
< a.sfattr.list[3].valuelen = 5
< a.sfattr.list[3].root = 0
< a.sfattr.list[3].secure = 0
< a.sfattr.list[3].name = "name.4"
< a.sfattr.list[3].value = "value"
< a.sfattr.list[4].namelen = 6
< a.sfattr.list[4].valuelen = 5
< a.sfattr.list[4].root = 0
< a.sfattr.list[4].secure = 0
< a.sfattr.list[4].name = "name.5"
< a.sfattr.list[4].value = "value"
< a.sfattr.list[5].namelen = 6
< a.sfattr.list[5].valuelen = 5
< a.sfattr.list[5].root = 0
< a.sfattr.list[5].secure = 0
< a.sfattr.list[5].name = "name.6"
< a.sfattr.list[5].value = "value"
< a.sfattr.list[6].namelen = 6
< a.sfattr.list[6].valuelen = 5
< a.sfattr.list[6].root = 0
< a.sfattr.list[6].secure = 0
< a.sfattr.list[6].name = "name.7"
< a.sfattr.list[6].value = "value"
< a.sfattr.list[7].namelen = 6
< a.sfattr.list[7].valuelen = 5
< a.sfattr.list[7].root = 0
< a.sfattr.list[7].secure = 0
< a.sfattr.list[7].name = "name.8"
< a.sfattr.list[7].value = "value"
< a.sfattr.list[8].namelen = 6
< a.sfattr.list[8].valuelen = 5
< a.sfattr.list[8].root = 0
< a.sfattr.list[8].secure = 0
< a.sfattr.list[8].name = "name.9"
< a.sfattr.list[8].value = "value"
< a.sfattr.list[9].namelen = 7
< a.sfattr.list[9].valuelen = 5
< a.sfattr.list[9].root = 0
< a.sfattr.list[9].secure = 0
< a.sfattr.list[9].name = "name.10"
< a.sfattr.list[9].value = "value"
< a.sfattr.list[10].namelen = 7
< a.sfattr.list[10].valuelen = 5
< a.sfattr.list[10].root = 0
< a.sfattr.list[10].secure = 0
< a.sfattr.list[10].name = "name.11"
< a.sfattr.list[10].value = "value"
< a.sfattr.list[11].namelen = 7
< a.sfattr.list[11].valuelen = 5
< a.sfattr.list[11].root = 0
< a.sfattr.list[11].secure = 0
< a.sfattr.list[11].name = "name.12"
< a.sfattr.list[11].value = "value"
< a.sfattr.list[12].namelen = 7
< a.sfattr.list[12].valuelen = 5
< a.sfattr.list[12].root = 0
< a.sfattr.list[12].secure = 0
< a.sfattr.list[12].name = "name.13"
< a.sfattr.list[12].value = "value"
< a.sfattr.list[13].namelen = 7
< a.sfattr.list[13].valuelen = 5
< a.sfattr.list[13].root = 0
< a.sfattr.list[13].secure = 0
< a.sfattr.list[13].name = "name.14"
< a.sfattr.list[13].value = "value"
< a.sfattr.list[14].namelen = 7
< a.sfattr.list[14].valuelen = 5
< a.sfattr.list[14].root = 0
< a.sfattr.list[14].secure = 0
< a.sfattr.list[14].name = "name.15"
< a.sfattr.list[14].value = "value"
< a.sfattr.list[15].namelen = 7
< a.sfattr.list[15].valuelen = 5
< a.sfattr.list[15].root = 0
< a.sfattr.list[15].secure = 0
< a.sfattr.list[15].name = "name.16"
< a.sfattr.list[15].value = "value"
---
 > core.naextents = 1
 > core.forkoff = 24 (192 bytes)
 > core.aformat = 2 (extents)
 > a.bmx[0] = [startoff,startblock,blockcount,extentflag] 0:[0,16,1,0]
.....




Regards,
Angelo




