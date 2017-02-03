Received: from mail-oi0-f54.google.com ([209.85.218.54]:32826 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbdBCKmV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 05:42:21 -0500
Received: by mail-oi0-f54.google.com with SMTP id w204so8846474oiw.0
        for <fstests@vger.kernel.org>; Fri, 03 Feb 2017 02:42:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170203093527.GB1859@eguan.usersys.redhat.com>
References: <1485513589-7416-1-git-send-email-amir73il@gmail.com> <20170203093527.GB1859@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Feb 2017 12:42:19 +0200
Message-ID: <CAOQ4uxhd_ijbFm9e0o01+Z=-2z0dMaONRBKm8jM3kN808hSGeQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: cleanup $TEST_DIR/$seq* files
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 3, 2017 at 11:35 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Jan 27, 2017 at 12:39:49PM +0200, Amir Goldstein wrote:
>> Test generic/007 was failing after running test overlay/007,
>> because the latter left behind a directory named 007 in test dir
>> and the former failed to mkdir a directory with the same name.
>>
>> Greping the tests for the pattern $TEST_DIR/$seq* found some more
>> files/dirs of this sort that were not being cleaned up.
>>
>> Clean those files/dir on _cleanup trap to fix the 007 tests collision
>> and avoid similar collisions in future tests.
>>
>> Left the directories $TEST_DIR/$seq.mnt in tact, because they are
>> always empty and created with mkdir -p.
>>
>> There are more files left behind as can be seen in any aged test dir.
>
> TEST_DIR is supposed to be aged over multiple runs, so leaving test
> files in it should be just fine, unless these files are consuming a lot
> of free space and would block subsequent tests.
>

Good point, but aging doesn't mean that the files need to stay there
create + delete is perfectly good aging.
As a matter of fact, all these test take care of removing the test
files *before* running the test, so why not cleanup *after* the test as well?
I can understand why it makes sense to leave behind $seq.$$ files to
fill up TEST_DIR with junk over time, but I cannot understand the reasoning
to leave behind $seq.<const> files, which are going to be removed before
next run anyway.


> For tests that need an empty dir or a newly created file in TEST_DIR,
> they could just remove the dir or file in test setup phase before doing
> any actual setups.
>
> So I think adding "-p" to mkdir command in generic/007 looks sufficient.
>

Fair enough, but please give this cleanup issue a second thought.

> Thanks,
> Eryu
