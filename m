Received: from mail-yw0-f172.google.com ([209.85.161.172]:42342 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBLGsw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Feb 2018 01:48:52 -0500
Received: by mail-yw0-f172.google.com with SMTP id e65so656158ywh.9
        for <fstests@vger.kernel.org>; Sun, 11 Feb 2018 22:48:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212051755.5n56bcfv5xuyjhhw@XZHOUW.usersys.redhat.com>
References: <CCAOQ4uxh2ZmEJi8gbiDRsYefV+XC20TNLjW9OFOZM0=j0_0yf+Q@mail.gmail.com>
 <1518332344-4772-1-git-send-email-xzhou@redhat.com> <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
 <20180212004126.w6tg2ohcrbt7qhdv@XZHOUW.usersys.redhat.com>
 <CAOQ4uxht-TkTiH+=9gp29XtCPv9=QR0v5FGFFvL+Ag9Nvshaww@mail.gmail.com>
 <20180212043357.x6dhq67wghzgafrw@XZHOUW.usersys.redhat.com> <20180212051755.5n56bcfv5xuyjhhw@XZHOUW.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Feb 2018 08:48:50 +0200
Message-ID: <CAOQ4uxi61AEx9YhuHEBLwAMXoKwgGAQWPeGc6OZFVoyt=P=fNQ@mail.gmail.com>
Subject: Re: [PATCH v3] generic: add stress test for fanotify and inotify
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 12, 2018 at 7:17 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> On Mon, Feb 12, 2018 at 12:33:57PM +0800, Xiong Zhou wrote:
>> On Mon, Feb 12, 2018 at 05:50:21AM +0200, Amir Goldstein wrote:
>> > On Mon, Feb 12, 2018 at 2:41 AM, Xiong Zhou <xzhou@redhat.com> wrote:
>> > > On Sun, Feb 11, 2018 at 10:03:17PM +0200, Amir Goldstein wrote:
>> > >> On Sun, Feb 11, 2018 at 8:59 AM, Xiong Zhou <xzhou@redhat.com> wrote:
>> > >> > Stress test for fanotify and inotify. Exercise fanotify and
>> > >> > inotify user interfaces in loop while other stress tests going
>> > >> > on in the watched test directory.
>> > >> >
>> > >> > Watching slab object inotify_inode_mark size, report fail
>> > >> > it increases too fast. This may lead to a crash if OOM killer
>> > >> > invoked. Fixed by this series:
>> > >> >
>> > >> > ab97f87 fsnotify: convert fsnotify_mark.refcnt from atomic_t to ref..
>> > >> > 6685df3 fanotify: clean up CONFIG_FANOTIFY_ACCESS_PERMISSIONS ifdefs
>> > >> > 3427ce7 fsnotify: clean up fsnotify()
>> > >> > f37650f fanotify: fix fsnotify_prepare_user_wait() failure
>> > >> > 9a31d7a fsnotify: fix pinning group in fsnotify_prepare_user_wait()
>> > >>
>> > >> That's a bit much. This commit below is the actual fix.
>> > >> The rest are cleanups and other bug fixes.
>> > >
>> > > Cleanups are preparing for the fix.
>> >
>> > No they are not. They are general cleanups and other bug fixed *after*
>> > the fix. heck, 3 of the patches you listed are not from Miklos' patchset
>> > at all.
>>
>> Ya. I messed up, I did not check all the details well enough, just
>> confirmed there was dependency.
>
> Initially I was checking email and saw
> http://lkml.iu.edu/hypermail/linux/kernel/1710.3/01317.html
> So I grabbed some commits from git log.
>
> I am not sure which specific commit fixes that issue, or all of them is
> needed, so I listed the series for accuracy(lazy).
>

Your confusion is understandable.
The cover letter says that with "the patch" applied, your reproducer does
not fail. However, with v2 "the patch" (which was the first patch of v1) was
split into 3 patches, i.e.:
fsnotify: clean up fsnotify_prepare/finish_user_wait()
fsnotify: pin both inode and vfsmount mark
fsnotify: fix pinning group in fsnotify_prepare_user_wait()

Out of these 3, listing the last 2 would have been informative enough.

Anyway, I find your wording in V4 informative and concise to the right level.

While we are being prudent about associating a fix with the test, can anyone
explain why the fixed bugs cause a memory leak, which is what this
test checks for?
because both relevant fixes claim to fix use after free.

Thanks,
Amir.
