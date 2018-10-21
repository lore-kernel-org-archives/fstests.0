Received: from aserp2120.oracle.com ([141.146.126.78]:54700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUW2H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Oct 2018 18:28:07 -0400
Subject: Re: [PATCH] btrfs/154: test for device dynamic rescan
References: <20171113022541.7413-1-anand.jain@oracle.com>
 <CAL3q7H41dQpiVaCyre3sCgAaVXd19-cWbLO68z4ovJz2F1E2-g@mail.gmail.com>
 <a83fb0ce-dff8-9389-2371-f2e7a5164153@suse.com>
 <CAL3q7H7inq5UCgihaP8i+9NOGiSvDGc6ndphMyuONc6OTJFtiw@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <184cb50c-1504-039b-6792-b5a710296ded@oracle.com>
Date: Sun, 21 Oct 2018 22:13:03 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7inq5UCgihaP8i+9NOGiSvDGc6ndphMyuONc6OTJFtiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Nikolay Borisov <nborisov@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 10/21/2018 05:31 PM, Filipe Manana wrote:
> On Sun, Oct 21, 2018 at 10:20 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 21.10.2018 10:16, Filipe Manana wrote:
>>> On Mon, Nov 13, 2017 at 2:26 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> Make sure missing device is included in the alloc list when it is
>>>> scanned on a mounted FS.
>>>>
>>>> This test case needs btrfs kernel patch which is in the ML
>>>>    [PATCH] btrfs: handle dynamically reappearing missing device
>>>> Without the kernel patch, the test will run, but reports as
>>>> failed, as the device scanned won't appear in the alloc_list.
>>>
>>> So that patch was never merged, at least not with that subject.
>>> What happened?

  The contending patch at V5 (with fixed comments as received) was
  working fine at the then latest kernel version, now its out dated,
  and I am not sure where to invest my time, it will be better to
  have David's comment, if he has any concern on the idea/approach
  in general. I am ok to revive the patch.

>> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/154
>>
>> In my testing of misc-next this test has been failing for me.

  Don't bother about that patch I am sure its not good on the current
  kernel.

>  recent hole punch
> test, that doesn't have a corresponding kernel fix.

  Hole punching kernel patch, fixes a corner case, I tried but failed.
  Until my current priority list recedes I won't be able to look into
  it again. If you would like to pick this up pls go ahead. I think it
  will easy for you.

  Lastly, I think its a good idea to record the current known limitation
  as a test cases, even if it fails, in that way it gets documented.

Thanks, Anand
