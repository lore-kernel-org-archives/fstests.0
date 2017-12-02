Received: from mail-yb0-f196.google.com ([209.85.213.196]:36707 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdLBLhi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Dec 2017 06:37:38 -0500
Received: by mail-yb0-f196.google.com with SMTP id j7so359214ybl.3
        for <fstests@vger.kernel.org>; Sat, 02 Dec 2017 03:37:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net> <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net> <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard> <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 2 Dec 2017 13:37:36 +0200
Message-ID: <CAOQ4uxgR5HaLOc-HYVS-VHmEtrYrMsn6W4W3sE+rFreS4u=-gQ@mail.gmail.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>
Cc: Chengguang Xu <cgxu@mykernel.net>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 2, 2017 at 12:43 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Fri, Dec 1, 2017 at 11:43 PM, Dave Chinner <david@fromorbit.com> wrote:
>> On Fri, Dec 01, 2017 at 09:21:15AM +0200, Amir Goldstein wrote:
> [...]
>>>
>>> Anyway, I see people are not so fond of the delalloc "canary test".
>>> Perhaps a still simple and quick test would be to do small buffered
>>> write; sync; small direct io read?
>>
>> No, because the direct IO read can flush dirty buffers across the
>> range the IO is being done on. IOWs, you don't know if the sync
>> actually flushed it, the direct IO read flushed it, or the direct IO
>> read fell back to buffered IO and simply read the in memory copy.
>>
>> Let's step back a moment: What bug/regression are you actually
>> trying to expose/reproduce here?
>
>
> The overlayfs bug (not regression) that Chengguang reported and posted
> a fix for - syncfs on overlayfs doesn't flush dirty inodes:
> https://marc.info/?l=linux-unionfs&m=151192099131198&w=2
>
>> Why is it not already covered by at
>> least one of the other generic sync/fsync tests we already have?
>>
>
> Because there are zero "syncfs" tests.
>
> AFAIK, "fsync" is not broken on overlayfs, because it operated on
> the real underlying inode and "sync" is not a problem, because
> dirty underlying inodes will be flushed by sync_filesystem() of the
> underlying fs.
>
> Still, I recommended that Chengguang's test, whichever method
> is chosen, will be generic and cover all those sync variants.
>
> If I would to write a generic syncfs test for a blockdev fs, I would have
> chosen to _mount_flakey, call _flakey_drop_and_remount after syncfs
> and examine compare md5sum of the written file.
>
> Alas, overlayfs is not a blockdev fs, so using the flakey helpers as is
> the generic test won't run on overlayfs.
>
> It is possible to write an overlayfs specific test, which sets up a
> dm-flakey target over a loop device and uses that fs as the overlayfs
> upper fs, but then the test won't be generic. If you think we should go
> for non-generic overlayfs test, that is fine by me.
>
> If you have a clever idea how to write a generic "syncfs" test that
> would also apply to non blockdev fs, please do share it, because *that*
> was the requirement that lead me to the "delalloc canary" test.
>

Another option is to start a new class of tests - "overlay group" tests.
Instead of writing an "overlay fs" test with "_supported_fs overlay", we
can write a "generic" test or even fs specific test and add it to "overlay"
group with "_require_overlay_mount $SCRATCH_MNT" which checks that
fs can be used as underlying fs for overlay mount.
_overlay_mount_dirs() helper can be used in those generic tests.

The discussed syncfs test would be in group generic/overlay and will use
both _mount_flakey and _overlay_mount_dirs.

A tester interested in overlayfs would have to invoke two different
xfstest runs:
./check -overlay -g auto
AND
./check -g overlay

This may look strange, but it would be a *lot* simpler than teaching
_require_dm_target and all the common/dm* helpers about
OVL_BASE_SCRATCH_DEV and all the _overlay_scratch* helpers.

Eryu,

How do you feel about this option?

Amir.
