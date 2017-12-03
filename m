Received: from mail-yb0-f194.google.com ([209.85.213.194]:35429 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdLCGpy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Dec 2017 01:45:54 -0500
Received: by mail-yb0-f194.google.com with SMTP id a13so2149549ybj.2
        for <fstests@vger.kernel.org>; Sat, 02 Dec 2017 22:45:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171202214030.GW4094@dastard>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net> <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net> <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard> <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
 <20171202214030.GW4094@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Dec 2017 08:45:53 +0200
Message-ID: <CAOQ4uxj4kBygrqA44OPCoJ4qRFFF_hPSeY8DL=Y8DA_eTa=p4Q@mail.gmail.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Chengguang Xu <cgxu@mykernel.net>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 2, 2017 at 11:40 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Sat, Dec 02, 2017 at 12:43:18PM +0200, Amir Goldstein wrote:
>> On Fri, Dec 1, 2017 at 11:43 PM, Dave Chinner <david@fromorbit.com> wrote:
[...]

>
> Implement FS_IOC_SHUTDOWN on overlay, then you can test it via
> software controlled shutdown. i.e. make overlay return true for
> _require_scratch_shutdown() and implement what is needed to shut it
> all down and prevent further writes of dirty inodes. Thens do
> data/metadata checks after a shutdown/unmount/mount cycle. Then
> what you have on disk after the mount cycle is what was written by
> sync/fsync/syncfs...
>
> We've only been using this shutdown mechanism to test fsync/sync
> mechanisms on XFS for ~20 years.
>

All right.
We don't need to implement FS_IOC_SHUTDOWN on overlay, we
only need to shutdown upper fs if upper fs supports shutdown.
Doing that would be the equivalent of a dm-flakey test for a blokdev fs,
because upper fs is the only persistent storage of overlayfs.
Thanks for the advice.

Chengguang,

I propose that you teach _require_scratch_shutdown about
OVL_BASE_SCRATCH_MNT and write and overlay/* test
that tests syncfs by shutting down upper fs if upper fs supports shutdown.

It doesn't matter much that the test won't run on all underlying fs as long
as a regression will be caught by someone running overlay tests over
xfs/ext4.

Cheers,
Amir.
