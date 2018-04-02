Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbeDBOY4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 2 Apr 2018 10:24:56 -0400
MIME-Version: 1.0
In-Reply-To: <CA+EzBbBOZ3vtTPHMXCfU5ONADc1Hn-Ur3OTRpR4Vn+Qwa1u3aA@mail.gmail.com>
References: <20180326225921.10096-1-fdmanana@kernel.org> <20180328021753.GE30836@localhost.localdomain>
 <CAL3q7H4FqvoVs69mfWFh1M=8bDZ5FSHcq0KKg+g0C5HcjLuXwg@mail.gmail.com>
 <20180328103358.GG30836@localhost.localdomain> <CAL3q7H7f8gVSitTudAopognpru9LRtoTJfm+8D-N0SYtiWeZpA@mail.gmail.com>
 <CA+EzBbBOZ3vtTPHMXCfU5ONADc1Hn-Ur3OTRpR4Vn+Qwa1u3aA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Apr 2018 15:24:54 +0100
Message-ID: <CAL3q7H5ChFX-92CrNE7fOiTcVWLCxZ9=MQOFHc0WFNdVbUwSQQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: test btrfs fsync after hole punching with
 no-holes mode
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 29, 2018 at 7:55 PM, Jayashree Mohan
<jayashree2912@gmail.com> wrote:
> Hi Filipe,
>
> I tried running the xfstest above on kernel 4.15.0 and I haven't been
> able to hit the bug. The xfstest passes clean for me. I compared the
> btrfs-debug-tree in my case with the one attached by Eryu, and I see I
> do not have any xattr as he does. However, for every run of the
> xfstest, the extent tree info that I get from btrfs-debug-tree has
> varying number of items in the first leaf node. (I have attached two
> dump files for your reference.)
>
> I also tried changing the offset at which fpunch is performed to match
> the offset of the last extent in the first leaf of the extent tree -
> however the md5 before and after crash was the same.
>
> Could you give more details on this?

You are getting extents smaller then 256Kb, because writeback is being
triggered by the kernel (likely due to memory pressure).
The second version of the test uses direct IO instead to avoid that.
Thanks.

>
> https://friendpaste.com/1wVAz7hG0U5SgYtZavbJhL
> https://friendpaste.com/1wVAz7hG0U5SgYtZavxALg
>
> Thanks,
> Jayashree Mohan
>
>
>
> On Thu, Mar 29, 2018 at 8:45 AM, Filipe Manana <fdmanana@kernel.org> wrote:
>> On Wed, Mar 28, 2018 at 11:33 AM, Eryu Guan <guaneryu@gmail.com> wrote:
>>> On Wed, Mar 28, 2018 at 09:48:17AM +0100, Filipe Manana wrote:
>>>> On Wed, Mar 28, 2018 at 3:17 AM, Eryu Guan <guaneryu@gmail.com> wrote:
>>>> > On Mon, Mar 26, 2018 at 11:59:21PM +0100, fdmanana@kernel.org wrote:
>>>> >> From: Filipe Manana <fdmanana@suse.com>
>>>> >>
>>>> >> Test that when we have the no-holes mode enabled and a specific metadata
>>>> >> layout, if we punch a hole and fsync the file, at replay time the whole
>>>> >> hole was preserved.
>>>> >>
>>>> >> This issue is fixed by the following btrfs patch for the linux kernel:
>>>> >>
>>>> >>   "Btrfs: fix fsync after hole punching when using no-holes feature"
>>>> >
>>>> > I'd expect a test failure with 4.16-rc6 kernel, as the mentioned fix
>>>> > above is not there. But test always passes for me. Did I miss anything?
>>>> > btrfs-progs version is btrfs-progs-4.11.1-3.fc27.
>>>>
>>>> It should fail on any kernel, with any btrfs-progs version (which
>>>> should be irrelevant).
>>>> Somehow on your system we are not getting the specific metadata layout
>>>> needed to trigger the issue.
>>>>
>>>> Can you apply the following patch on top of the test and provide the
>>>> result 159.full file?
>>>>
>>>> https://friendpaste.com/6xAuLeN4xl1AGjO9Qc5I8L
>>>>
>>>> So that I can see what metadata layout you are getting.
>>>> Thanks!
>>>
>>> Sure, please see attachment.
>>
>> Thanks!
>> So you indeed get a different metadata layout, and that is because you
>> have SELinux enabled which causes some xattr to be added to the test
>> file (foobar):
>>
>>         item 6 key (257 XATTR_ITEM 3817753667) itemoff 64932 itemsize 83
>>                 location key (0 UNKNOWN.0 0) type XATTR
>>                 transid 7 data_len 37 name_len 16
>>                 name: security.selinux
>>                 data unconfined_u:object_r:unlabeled_t:s0
>>
>> I can make the test work with and without selinux enabled (by punching
>> holes on a few extents that are candidates to be at leaf boundaries).
>> Is it worth it? (I assume most people run the tests without selinux)
>>
>> thanks
>>
>>>
>>> Thanks,
>>> Eryu
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
