Received: from LGEAMRELO12.lge.com ([156.147.23.52]:42138 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdLHBvK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Dec 2017 20:51:10 -0500
Subject: Re: False lockdep completion splats with loop device
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org> <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <CAOQ4uxi76Er-a4-oejA894ws4t5w1OvLFBofJG03Tf6Ot+Usdg@mail.gmail.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <d05eef4a-a77f-808e-f98f-9e7f779c4b20@lge.com>
Date: Fri, 8 Dec 2017 10:51:07 +0900
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi76Er-a4-oejA894ws4t5w1OvLFBofJG03Tf6Ot+Usdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On 12/7/2017 1:18 PM, Amir Goldstein wrote:
> On Thu, Dec 7, 2017 at 4:46 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>> On Wed, Dec 6, 2017 at 9:01 AM, Byungchul Park <byungchul.park@lge.com> wrote:
>>> On 12/6/2017 3:31 PM, Amir Goldstein wrote:
>>>>
>>>> On Wed, Dec 6, 2017 at 7:01 AM, Byungchul Park <byungchul.park@lge.com>
>>>> wrote:
>>>>>
>>>>> On 12/6/2017 6:09 AM, Dave Chinner wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, Dec 05, 2017 at 10:07:41AM -0500, Theodore Ts'o wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Dec 05, 2017 at 02:16:45PM +0900, Byungchul Park wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I believe that the commit e319e1fbd9d42 "block, locking/lockdep:
>>>>>>>> Assign
>>>>>>>> a lock_class per gendisk used for wait_for_completion()" solved the
>>>>>>>> false positive.
>>>>>>>>
>>>>>>>> Could you tell me if it doesn't handle it, with the report? Then, I
>>>>>>>> will follow up and try to solve it.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> No, it doesn't handle it.  And there was some discussion in the linked
>>>>>>> thread on the xfs mailing list that seemed to indicate that it was not
>>>>>>> a complete fix.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Well, it uses a static key hidden inside the macro
>>>>>> alloc_disk_node(), so every disk allocated from the same callsite
>>>>>> points to the same static lockdep map. IOWs, every caller of
>>>>>> alloc_disk() (i.e. the vast majority of storage devices) are
>>>>>> configured to point at the same static lockdep map, regardless of
>>>>>> their location in the storage stack.
>>>>>>
>>>>>> The loop device uses alloc_disk().
>>>>>>
>>>>>> IOWs, it doesn't address the problem of false positives due to
>>>>>> layering in the IO stack at all because we can still have
>>>>>> filesystems both above and below the lockdep map that has been
>>>>>> attached to the devices...
>>>>>
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> What if we assign different classes to different loop devices? Do
>>>>> you think it helps to avoid such false positives?
>>>>>
>>>>> I'm not sure since I'm unfamiliar with the stacking stuff. It would
>>>>> be appriciated if you let me know your opinion about it.
>>>>>
>>>
>>> Hello Amir,
>>>
>>> Thanks a lot for your opinion! See the below.
>>>
>>>> I believe the problem in the tests is that loop is mistaken for the same
>>>> class/key as another (underlying) blockdev, where the fs of the loop file
>>>> resides.
>>>>
>>>> For the first order of resolution, it would be enough to assign a
>>>> different
>>>> key to different types of block devices, similar to the struct
>>>> file_system_type
>>>> lock class keys.
>>>>
>>>> This would be enough to cover to common case of ext4 over loop inside
>>>> ext4 over real disk (at least for the completion lockdep warnings).
>>>
>>>
>>> This was already done by the commit e319e1fbd9d42 "block,
>>> locking/lockdep: Assign a lock_class per gendisk used for
>>> wait_for_completion()".
>>>
>>
>> Right...
>>
>>>> For the second order of resolution it may be desired to assign a different
>>>> key/class to an instance of loop devices and other stackable block devices
>>>> (e.g. dm, nbd)  to cover the case of a deeper nested blockdev stack,
>>>> such as: ext4 over loop inside ext4 over loop inside ext4 over real disk.
>>>
>>>
>>> This is what I should do.
>>>
>>
>> But that won't help Ted. The test use case doesn't include doubly nested loop,
>> very few setups will do that. Maybe xfstests running within a container over
>> loop image. I doubt it that setup is common, so until there are nested container
>> implementations out there that are using loop image mount, this use case
>> is not very interesting.
>>
>>>
>>>> That should be enough to cover the completion lockdep validation,
>>>> but it still leaves to problem of the file_system_type lock key, which
>>>> is still the same for the 2 instances of ext4 in the stack above.
>>>> For that I suggested a solution similar to
>>>> b1eaa950f7e9 ovl: lockdep annotate of nested stacked overlayfs inode lock
>>>> but that will require propagating a "bdev_stack_depth" throughout the
>>>> block and fs stack and increment it when creating loop or nbd device.
>>>>
>>
>> So this in the problem Ted is reporting and it needs to be solved inside
>> ext4 and any other fs that can be loop mounted on a file inside same fs type.
>>
>> The lockdep chain is: ext4/loop -> loop completion -> ext4/real
>> but all the internal ext4 locks (i.e. &meta_group_info[i]->alloc_sem) are
>> annotated statically for the ext4 fs type, so to fix that need:
>> 1. ext4 to know it is mounted over loop/nbd
>> 2. ext4 to annotate all internal locks that surround blockdev I/O as
>>      "loop nested"/"not loop nested" like overlayfs does with the vfs locks
>> 3. if multi nested looped fs is important (not really) then loop/nbd will
>>      need to know if its file is on a looped fs and propagate nesting level
>>      to ext4
>>
> 
> So maybe a macro for filesystems to annotate internal locks with
> underlying blockdev's gendisk lockdep_map?
> 
> Does that make sense?

Hello,

I think it can be a way. But I'm thinking about a more general way..

Thanks for the proposal.

-- 
Thanks,
Byungchul
