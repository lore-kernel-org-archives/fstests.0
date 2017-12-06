Received: from mail-yb0-f182.google.com ([209.85.213.182]:45055 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbdLFGbw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Dec 2017 01:31:52 -0500
MIME-Version: 1.0
In-Reply-To: <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org> <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org> <20171205210956.GZ5858@dastard> <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Dec 2017 08:31:51 +0200
Message-ID: <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
Subject: Re: False lockdep completion splats with loop device
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Byungchul Park <byungchul.park@lge.com>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 6, 2017 at 7:01 AM, Byungchul Park <byungchul.park@lge.com> wrote:
> On 12/6/2017 6:09 AM, Dave Chinner wrote:
>>
>> On Tue, Dec 05, 2017 at 10:07:41AM -0500, Theodore Ts'o wrote:
>>>
>>> On Tue, Dec 05, 2017 at 02:16:45PM +0900, Byungchul Park wrote:
>>>>
>>>>
>>>> Hello,
>>>>
>>>> I believe that the commit e319e1fbd9d42 "block, locking/lockdep: Assign
>>>> a lock_class per gendisk used for wait_for_completion()" solved the
>>>> false positive.
>>>>
>>>> Could you tell me if it doesn't handle it, with the report? Then, I
>>>> will follow up and try to solve it.
>>>
>>>
>>> No, it doesn't handle it.  And there was some discussion in the linked
>>> thread on the xfs mailing list that seemed to indicate that it was not
>>> a complete fix.
>>
>>
>> Well, it uses a static key hidden inside the macro
>> alloc_disk_node(), so every disk allocated from the same callsite
>> points to the same static lockdep map. IOWs, every caller of
>> alloc_disk() (i.e. the vast majority of storage devices) are
>> configured to point at the same static lockdep map, regardless of
>> their location in the storage stack.
>>
>> The loop device uses alloc_disk().
>>
>> IOWs, it doesn't address the problem of false positives due to
>> layering in the IO stack at all because we can still have
>> filesystems both above and below the lockdep map that has been
>> attached to the devices...
>
>
> Hello,
>
> What if we assign different classes to different loop devices? Do
> you think it helps to avoid such false positives?
>
> I'm not sure since I'm unfamiliar with the stacking stuff. It would
> be appriciated if you let me know your opinion about it.
>

I believe the problem in the tests is that loop is mistaken for the same
class/key as another (underlying) blockdev, where the fs of the loop file
resides.

For the first order of resolution, it would be enough to assign a different
key to different types of block devices, similar to the struct file_system_type
lock class keys.

This would be enough to cover to common case of ext4 over loop inside
ext4 over real disk (at least for the completion lockdep warnings).

For the second order of resolution it may be desired to assign a different
key/class to an instance of loop devices and other stackable block devices
(e.g. dm, nbd)  to cover the case of a deeper nested blockdev stack,
such as: ext4 over loop inside ext4 over loop inside ext4 over real disk.

That should be enough to cover the completion lockdep validation,
but it still leaves to problem of the file_system_type lock key, which
is still the same for the 2 instances of ext4 in the stack above.
For that I suggested a solution similar to
b1eaa950f7e9 ovl: lockdep annotate of nested stacked overlayfs inode lock
but that will require propagating a "bdev_stack_depth" throughout the
block and fs stack and increment it when creating loop or nbd device.

Cheers,
Amir.
