Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752228AbdLGKDW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Dec 2017 05:03:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB79xqpL078595
        for <fstests@vger.kernel.org>; Thu, 7 Dec 2017 05:03:22 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2epyhjhskq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 07 Dec 2017 05:03:21 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <harish@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 10:03:17 -0000
Subject: Re: [PATCH] btrfs/057: Fix test case to work on 64K page size
References: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
 <20171206073516.GQ2749@eguan.usersys.redhat.com>
 <ce94337e-2c4d-6b16-1a7d-076a3dccc5b2@gmx.com>
From: Harish <harish@linux.vnet.ibm.com>
Date: Thu, 7 Dec 2017 15:33:11 +0530
MIME-Version: 1.0
In-Reply-To: <ce94337e-2c4d-6b16-1a7d-076a3dccc5b2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d69429c5-83b3-0027-31ee-44da5bfa5da1@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Sure will work on this. Thanks.

Harish

On 12/06/2017 01:16 PM, Qu Wenruo wrote:
>
>
> On 2017=E5=B9=B412=E6=9C=8806=E6=97=A5 15:35, Eryu Guan wrote:
>> On Wed, Dec 06, 2017 at 12:15:45PM +0530, Harish wrote:
>>> On platforms with a page size greater than 4Kb, at the moment btrfs
>>> doesn't support a node/leaf size smaller than the page size, but it
>>> supports a larger one. So use the max supported node size (64Kb) so
>>> that the test runs on any platform currently supported by Linux.
>>>
>>> Signed-off-by: Harish <harish@linux.vnet.ibm.com>
>>
>> Looks fine to me. Also cc btrfs list for review.
>>
>> Thanks,
>> Eryu
>>
>>> ---
>>>  tests/btrfs/057     | 7 +++++--
>>>  tests/btrfs/057.out | 4 ++--
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/btrfs/057 b/tests/btrfs/057
>>> index 8d35579..06b2be9 100755
>>> --- a/tests/btrfs/057
>>> +++ b/tests/btrfs/057
>>> @@ -48,8 +48,11 @@ _require_scratch
>>>
>>>  rm -f $seqres.full
>>>
>>> -# use small leaf size to get higher btree height.
>>> -run_check _scratch_mkfs "-b 1g --nodesize 4096"
>>> +# Currently in btrfs the node/leaf size can not be smaller than the =
page
>>> +# size (but it can be greater than the page size). So use the larges=
t
>>> +# supported node/leaf size (64Kb) so that the test can run on any pl=
atform
>>> +# that Linux supports.
>>> +run_check _scratch_mkfs "-b 1g --nodesize 65536"
>
> Personally speaking, the test doesn't really need super high tree heigh=
t.
> So I think it's OK to use a different node size.
>
> But I prefer default mkfs.btrfs, which will choose valid nodesize.
> So for 4K system, it will use default 16K other than always using the
> 64K nodesize.
>
>
> And further more, the test case is quite old, from the old days when we
> did even have btrfs check support for qgroup.
>
> With new btrfs check support, we don't really need to do anything to
> check qgroup numbers in test cases, just let fstests post test routines
> to handle it.
>
> If qgroup is corrupted, fstests will report something inconsistent
> filesystem at post test fsck.
> Just like what we do in btrfs/126. (so no need to use any magic number
> in 057.out)
>
> So would you please also update the test case to get benefit from the
> newer btrfs-progs?
>
> Thanks,
> Qu
>
>>>
>>>  # inode cache is saved in the FS tree itself for every
>>>  # individual FS tree,that affects the sizes reported by qgroup show
>>> diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
>>> index 60cb92d..f2d9e9c 100644
>>> --- a/tests/btrfs/057.out
>>> +++ b/tests/btrfs/057.out
>>> @@ -1,3 +1,3 @@
>>>  QA output created by 057
>>> -4096 4096
>>> -4096 4096
>>> +65536 65536
>>> +65536 65536
>>> --
>>> 2.7.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

