Received: from mail-yw0-f196.google.com ([209.85.161.196]:45288 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdLIUIO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 9 Dec 2017 15:08:14 -0500
MIME-Version: 1.0
In-Reply-To: <20171209160219.ax3jc3n5fmuxnwvz@thunk.org>
References: <20171205210956.GZ5858@dastard> <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com> <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard> <20171208001302.GK21978@ZenIV.linux.org.uk>
 <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com>
 <20171208225757.GP4094@dastard> <CAOQ4uxjNiC1YKvfr1c_2eyUhpwHHU1zFnpSerKmxw5Y5B0aLCA@mail.gmail.com>
 <20171209160219.ax3jc3n5fmuxnwvz@thunk.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Dec 2017 22:08:13 +0200
Message-ID: <CAOQ4uxgHkfrRMrK1NW8RqDSf7MAvn-ARWtOMvK3FxOu7DAi56A@mail.gmail.com>
Subject: Re: False lockdep completion splats with loop device
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>, Byungchul Park <byungchul.park@lge.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 9, 2017 at 6:02 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Sat, Dec 09, 2017 at 10:44:33AM +0200, Amir Goldstein wrote:
>> The honest truth is that loop nested fs can *really* cause a
>> deadlock with silly setups.  completion lockdep is the unlucky
>> messenger that was trying to bring that to our attention.
>
> What is the "silly setup" (I'm not saying kernel bugs, but rather
> things which a sysadmin might want to set up) that would cause
> deadlock?  In the example you gave, the block allocation is happenig
> in two different file system instances, so if lockdep whinges, that's
> another example of a false positive.
>

The "silly setup" is not something that any sane admin will do,
but there a lot of crazy stuff you can do with loop, like:
- create a file in FS1 on VG1/LV1
- setup loop dev
- add the loop dev to VG1
- extend LV1 onto loopdev
- extend FS1 onto loopdev

That setup is possible. That setup can deadlock.

I am not trying to defend lockdep developers regressing our tests
and "forcing" the burden of annotations on fs developers. That is wrong.
The burden of proof should be on lockdep developers and IMO is was
premature to force completion lockdep.

But for full disclosure, I am stating a fact that lockdep is not meant to
tell us that we hit a deadlock. lockdep is meant to tell us that a deadlock
is possible with current code.
And what do you know - deadlock is possible, just not with your setup.
It has always been possible - completion lockdep just exposed that.

Going forward, it is clear that with completion lockdep, the static lockdep
annotations for fs locks are not sufficient. We need to have a very simple
way of annotating a lock that is associated with an fs instance rather
than an fs type.

Amir.
