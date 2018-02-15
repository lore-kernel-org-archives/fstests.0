Received: from mail-yw0-f179.google.com ([209.85.161.179]:40800 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755090AbeBOIdo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Feb 2018 03:33:44 -0500
Received: by mail-yw0-f179.google.com with SMTP id y186so8737743ywf.7
        for <fstests@vger.kernel.org>; Thu, 15 Feb 2018 00:33:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214150343.GN18267@eguan.usersys.redhat.com>
References: <20180212053822.whuqpncgddzm3l6n@XZHOUW.usersys.redhat.com>
 <1518414408-23149-1-git-send-email-xzhou@redhat.com> <20180214110331.ojgyabcta34lzo4s@quack2.suse.cz>
 <CAOQ4uxhUv0Wy+v_i8mzhx5y7NA88VyULxWniJ-HXCLg_Pq7bUw@mail.gmail.com> <20180214150343.GN18267@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Feb 2018 10:33:42 +0200
Message-ID: <CAOQ4uxhNQ9aURKbkSTOBjXiAfrxJ61Jo0HAe0rLKh8i8OfW0hg@mail.gmail.com>
Subject: Re: [PATCH v4] generic: add stress test for fanotify and inotify
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Xiong Zhou <xzhou@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 14, 2018 at 5:03 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 01:22:06PM +0200, Amir Goldstein wrote:
>> On Wed, Feb 14, 2018 at 1:03 PM, Jan Kara <jack@suse.cz> wrote:
>> > On Mon 12-02-18 13:46:48, Xiong Zhou wrote:
>> >> Stress test for fanotify and inotify. Exercise fanotify and
>> >> inotify user interfaces in loop while other stress tests going
>> >> on in the watched test directory.
>> >>
>> >> Watching slab object inotify_inode_mark size, report fail
>> >> it increases too fast. This may lead to a crash if OOM killer
>> >> invoked.
>> >>
>> >> kernel commit related to the fixes in v4.15-rc1:
>> >> 0d6ec07 fsnotify: pin both inode and vfsmount mark
>> >>
>> >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> >
>> > I'm sorry for chiming in so late but I was on vacation. Just one question:
>> > Currently, all inotify and fanotify tests are part of LTP. Is there any
>> > good reason for putting this particular test to fstests and not LTP?
>> > Specifically I've refrained from putting notification framework tests to
>> > fstests because there's practically no relation of it to implementation of
>> > any particular filesystem. Also I'd prefer not to have fanotify / inotify
>> > tests in two different frameworks...
>> >
>>
>> I second that.
>> Also, Eryu did not chime in yet (and Dave probably did not look closely),
>> but I think fstests in general try to refrain from single purpose test
>> programs such as fsnotify_stress.
>
> I have no problem with committing fsnotify tests in fstests, we do have
> tests that exercise the vfs level infrastructure purely, e.g. the shared
> subtree operations tests.
>
> But if both fanotify subsystem maintainer and main reviewer suggest
> putting this test to LTP, I have no problem with that too :)
>

Clarification:
Although I am siding Jan on LTP being an appropriate place for this
test I have no objection for merging this test to fstests and you can also
add Reviewed-by: Amir Goldstein <amir73il@gmail.com> for v4.

Also, the statement that "there's practically no relation of [notification
framework] to implementation of any particular filesystem" is not accurate.
It would have been more accurate to say that the regression that this test
checks for has no relation to any particular filesystem and therefore the
test belongs to LTP, which tests the kernel inotify/fanotify syscalls.

As I wrote, I just posted 2 LTP inotify tests which are generic, but only fail
on overlayfs: https://github.com/linux-test-project/ltp/pull/246.
I would have preferred to write those tests as generic fsnotify tests for
fstests and let the tests pass on all filesystems and fail on overlayfs.

The reason I did not do that is because it would mean one of two things:
1. Add 2 single purpose C programs to src - This is the standard practice in
    LTP, but LTP provides a nice library to make the C test program minimal
    and fstests does not.
2. Write a multi purpose C program (e.g. fsnotify_expect) that could be
    invoked from bash tests to verify expected events.

Option #1 I ruled out.
Option #2 is on my wish/TODO list.
I envision feeding the output of fsstress into fsnotiy_expect.
I am not aware of any test coverage for fsnotify that does something like that.

Thanks,
Amir.
