Received: from mail-yw0-f179.google.com ([209.85.161.179]:45879 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdLIIof (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 9 Dec 2017 03:44:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171208225757.GP4094@dastard>
References: <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com> <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard> <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com> <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard> <20171208001302.GK21978@ZenIV.linux.org.uk>
 <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com> <20171208225757.GP4094@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Dec 2017 10:44:33 +0200
Message-ID: <CAOQ4uxjNiC1YKvfr1c_2eyUhpwHHU1zFnpSerKmxw5Y5B0aLCA@mail.gmail.com>
Subject: Re: False lockdep completion splats with loop device
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Byungchul Park <byungchul.park@lge.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 9, 2017 at 12:57 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Dec 08, 2017 at 10:15:07AM +0200, Amir Goldstein wrote:
>> On Fri, Dec 8, 2017 at 2:13 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > On Fri, Dec 08, 2017 at 10:59:22AM +1100, Dave Chinner wrote:
>> >
>> >> > 3. if multi nested looped fs is important (not really) then loop/nbd will
>> >> >     need to know if its file is on a looped fs and propagate nesting level
>> >> >     to ext4
>> >>
>> >> This functionality is definitely used and needs to be supported by
>> >> the annotations.
>> >
>> > FWIW, in addition to loop, there's md.
>>
>> Do you mean md can sit on a file directly without loop/nbd?
>> I am referring to loop/nbd, because those are the only ones I know
>> of that can be used to nest (non stackable) fs over fs.
>
> The problem is one of stacked completions, not loop/nbd devices. The
> loop and nbd devices are just the simplest way to stack completions.
> MD can sit on MD and other devices in complex stacks, so if there's
> completion in MD, we have the same completion layering problem.
>
> i.e. this is *not specifically a filesystem problem*. This is a
> completion stacking problem, and lots of different layers in the
> storage stack use completions and can be layered in arbitrary
> orders. MD and DM are jsut two more virtual block devices that can
> stack in random orders.
>

The way I see it, there are two different stacking problems, one is
specifically a fs problem, the other is not.

1. completion stacking annotation problem.

commit e319e1fbd9d42 "block, locking/lockdep: Assign
a lock_class per gendisk used for wait_for_completion()"
is a partial solution, because it solves only case of stacking different
types of gendisk. It should probably be extended to assign a lock_class
per gendisk instance.

2. loop nested fs stacking annotation problem

This depends on a specific fs and a specific lock.
In the ext4 example, IIUC, IO is submitted inside meta_group_info[i]->alloc_sem
of loop mounted fs.
If backing loop file is not pre-allocated, that IO can lead to block
allocation in
underlying ext4 and take meta_group_info[i]->alloc_sem.
That lock is in a different fs instance, but uses the same static allocation.

If solution to problem 1 above is acceptable, then going the same route for
problem 2 could be solved by assigning a lock class for sb instance for
locks of that sort.

The honest truth is that loop nested fs can *really* cause a deadlock with
silly setups.
completion lockdep is the unlucky messenger that was trying to bring that to
our attention.
We told completion lockdep that we are aware of that potential deadlock and
that our setup is not silly and beheaded the messenger.

Byungchul,

Seeing how your changes to lockdep completion has caused pain to fs developers,
I recommend that when checking your changes you run Ted's kvm-xfstests to
verify it is not causing any regressions w.r.t. false positive lockdep warnings.
This test VM is specifically designed for other subsystem developers to
easily run the fs subsystem testsuite.

Specifically, when working on a fix for the problem Ted reported, you
should at least
run the test shared/298 on ext4 and you should also run the test
xfs/073 on xfs, where
Dave indicated there is a nested loop fs setup.

Cheers,
Amir.
