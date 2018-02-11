Received: from mail-yw0-f181.google.com ([209.85.161.181]:42463 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbeBKUDS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Feb 2018 15:03:18 -0500
Received: by mail-yw0-f181.google.com with SMTP id e65so32893ywh.9
        for <fstests@vger.kernel.org>; Sun, 11 Feb 2018 12:03:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518332344-4772-1-git-send-email-xzhou@redhat.com>
References: <CCAOQ4uxh2ZmEJi8gbiDRsYefV+XC20TNLjW9OFOZM0=j0_0yf+Q@mail.gmail.com>
 <1518332344-4772-1-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 11 Feb 2018 22:03:17 +0200
Message-ID: <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
Subject: Re: [PATCH v3] generic: add stress test for fanotify and inotify
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 11, 2018 at 8:59 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Stress test for fanotify and inotify. Exercise fanotify and
> inotify user interfaces in loop while other stress tests going
> on in the watched test directory.
>
> Watching slab object inotify_inode_mark size, report fail
> it increases too fast. This may lead to a crash if OOM killer
> invoked. Fixed by this series:
>
> ab97f87 fsnotify: convert fsnotify_mark.refcnt from atomic_t to ref..
> 6685df3 fanotify: clean up CONFIG_FANOTIFY_ACCESS_PERMISSIONS ifdefs
> 3427ce7 fsnotify: clean up fsnotify()
> f37650f fanotify: fix fsnotify_prepare_user_wait() failure
> 9a31d7a fsnotify: fix pinning group in fsnotify_prepare_user_wait()

That's a bit much. This commit below is the actual fix.
The rest are cleanups and other bug fixes.
It could also help testers to know the upstream kernel version
where the fix landed:

0d6ec07 fsnotify: pin both inode and vfsmount mark

Otherwise, looks good.

Amir.
