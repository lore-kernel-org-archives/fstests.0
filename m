Received: from mail-yw0-f196.google.com ([209.85.161.196]:39443 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdLBKnU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Dec 2017 05:43:20 -0500
Received: by mail-yw0-f196.google.com with SMTP id y187so5024049ywg.6
        for <fstests@vger.kernel.org>; Sat, 02 Dec 2017 02:43:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171201214320.GU4094@dastard>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net> <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net> <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 2 Dec 2017 12:43:18 +0200
Message-ID: <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Chengguang Xu <cgxu@mykernel.net>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 1, 2017 at 11:43 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Dec 01, 2017 at 09:21:15AM +0200, Amir Goldstein wrote:
[...]
>>
>> Anyway, I see people are not so fond of the delalloc "canary test".
>> Perhaps a still simple and quick test would be to do small buffered
>> write; sync; small direct io read?
>
> No, because the direct IO read can flush dirty buffers across the
> range the IO is being done on. IOWs, you don't know if the sync
> actually flushed it, the direct IO read flushed it, or the direct IO
> read fell back to buffered IO and simply read the in memory copy.
>
> Let's step back a moment: What bug/regression are you actually
> trying to expose/reproduce here?


The overlayfs bug (not regression) that Chengguang reported and posted
a fix for - syncfs on overlayfs doesn't flush dirty inodes:
https://marc.info/?l=linux-unionfs&m=151192099131198&w=2

> Why is it not already covered by at
> least one of the other generic sync/fsync tests we already have?
>

Because there are zero "syncfs" tests.

AFAIK, "fsync" is not broken on overlayfs, because it operated on
the real underlying inode and "sync" is not a problem, because
dirty underlying inodes will be flushed by sync_filesystem() of the
underlying fs.

Still, I recommended that Chengguang's test, whichever method
is chosen, will be generic and cover all those sync variants.

If I would to write a generic syncfs test for a blockdev fs, I would have
chosen to _mount_flakey, call _flakey_drop_and_remount after syncfs
and examine compare md5sum of the written file.

Alas, overlayfs is not a blockdev fs, so using the flakey helpers as is
the generic test won't run on overlayfs.

It is possible to write an overlayfs specific test, which sets up a
dm-flakey target over a loop device and uses that fs as the overlayfs
upper fs, but then the test won't be generic. If you think we should go
for non-generic overlayfs test, that is fine by me.

If you have a clever idea how to write a generic "syncfs" test that
would also apply to non blockdev fs, please do share it, because *that*
was the requirement that lead me to the "delalloc canary" test.

Thanks,
Amir.
