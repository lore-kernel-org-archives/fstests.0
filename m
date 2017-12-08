Received: from mail-yb0-f195.google.com ([209.85.213.195]:39681 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdLHIPI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Dec 2017 03:15:08 -0500
MIME-Version: 1.0
In-Reply-To: <20171208001302.GK21978@ZenIV.linux.org.uk>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org> <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org> <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com> <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com> <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard> <20171208001302.GK21978@ZenIV.linux.org.uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Dec 2017 10:15:07 +0200
Message-ID: <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com>
Subject: Re: False lockdep completion splats with loop device
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>, Byungchul Park <byungchul.park@lge.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 8, 2017 at 2:13 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Dec 08, 2017 at 10:59:22AM +1100, Dave Chinner wrote:
>
>> > 3. if multi nested looped fs is important (not really) then loop/nbd will
>> >     need to know if its file is on a looped fs and propagate nesting level
>> >     to ext4
>>
>> This functionality is definitely used and needs to be supported by
>> the annotations.
>
> FWIW, in addition to loop, there's md.

Do you mean md can sit on a file directly without loop/nbd?
I am referring to loop/nbd, because those are the only ones I know
of that can be used to nest (non stackable) fs over fs.

> So should loop need to know if its
> backing file lives on a filesystem that does, for example, have an extrnal
> journal sitting on RAID1 with one of the components hosted in a file on
> some other fs, brought into the array via another loop device?
>

The nested depth accounting scheme I proposed is unneeded.
I think it should be enough to use a macro to annotate locks that
can go from fs into io for underlying blockdev,
e.g. (for Ted's lockdep splat):
    init_rwsem(&meta_group_info[i]->alloc_sem);
    lockdep_fsio(&meta_group_info[i]->alloc_sem, sb);

That can help isolate the annotation to a lockdep map attached
to the underlying blockdev/gendisk.

As you pointed out, this does not cover all the cases of fs that uses
multi blockdev for external journal or whatever, but even if we isolate
lockdep by the main (or any) blockdev of a filesystem, assuming this
blockdev is used exclusively by that fs instance, this would be enough
to mitigate the false positives from loop nested setups.

> Oh, and to make life even more fun, backing file can be flipped under
> configured /dev/loop.  IOW, those nesting depths are not static at all.

In that case, lockdep would have been very right to warn us, because
we can actually create a deadlock by looping loop into a file that sits
inside fs on the loop device.

Amir.
