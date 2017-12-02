Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:10380 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752232AbdLBVke (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Dec 2017 16:40:34 -0500
Date: Sun, 3 Dec 2017 08:40:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
Message-ID: <20171202214030.GW4094@dastard>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
 <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
 <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard>
 <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chengguang Xu <cgxu@mykernel.net>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 02, 2017 at 12:43:18PM +0200, Amir Goldstein wrote:
> On Fri, Dec 1, 2017 at 11:43 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Dec 01, 2017 at 09:21:15AM +0200, Amir Goldstein wrote:
> [...]
> >>
> >> Anyway, I see people are not so fond of the delalloc "canary test".
> >> Perhaps a still simple and quick test would be to do small buffered
> >> write; sync; small direct io read?
> >
> > No, because the direct IO read can flush dirty buffers across the
> > range the IO is being done on. IOWs, you don't know if the sync
> > actually flushed it, the direct IO read flushed it, or the direct IO
> > read fell back to buffered IO and simply read the in memory copy.
> >
> > Let's step back a moment: What bug/regression are you actually
> > trying to expose/reproduce here?
> 
> 
> The overlayfs bug (not regression) that Chengguang reported and posted
> a fix for - syncfs on overlayfs doesn't flush dirty inodes:
> https://marc.info/?l=linux-unionfs&m=151192099131198&w=2
> 
> > Why is it not already covered by at
> > least one of the other generic sync/fsync tests we already have?
> >
> 
> Because there are zero "syncfs" tests.

It uses the same code as sync, so all the sync tests are testing
syncfs, too. If syncfs is broken, then sync was also broken on
overlay.

> AFAIK, "fsync" is not broken on overlayfs, because it operated on
> the real underlying inode and "sync" is not a problem, because
> dirty underlying inodes will be flushed by sync_filesystem() of the
> underlying fs.

Which means nobody had tested a setup where the order of syncing
inodes in different overlay layers exposed crash inconsistencies....

> Still, I recommended that Chengguang's test, whichever method
> is chosen, will be generic and cover all those sync variants.
> 
> If I would to write a generic syncfs test for a blockdev fs, I would have
> chosen to _mount_flakey, call _flakey_drop_and_remount after syncfs
> and examine compare md5sum of the written file.
> 
> Alas, overlayfs is not a blockdev fs, so using the flakey helpers as is
> the generic test won't run on overlayfs.

That doesn't make stuffing about with the extent state of underlying
filesytems any less hacky.

> It is possible to write an overlayfs specific test, which sets up a
> dm-flakey target over a loop device and uses that fs as the overlayfs
> upper fs, but then the test won't be generic. If you think we should go
> for non-generic overlayfs test, that is fine by me.

That's precisely what the per-filesystem test directories are for.
Put tests that are overlay specific or too dodgy to reliably run on all
filesystems into tests/overlay. I don't care what you put in their
because those tests then don't affect my XFS testing, or anyone
else's non-overlay testing.

> If you have a clever idea how to write a generic "syncfs" test
> that would also apply to non blockdev fs, please do share it,
> because *that* was the requirement that lead me to the "delalloc
> canary" test.

Implement FS_IOC_SHUTDOWN on overlay, then you can test it via
software controlled shutdown. i.e. make overlay return true for
_require_scratch_shutdown() and implement what is needed to shut it
all down and prevent further writes of dirty inodes. Thens do
data/metadata checks after a shutdown/unmount/mount cycle. Then
what you have on disk after the mount cycle is what was written by
sync/fsync/syncfs...

We've only been using this shutdown mechanism to test fsync/sync
mechanisms on XFS for ~20 years.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
