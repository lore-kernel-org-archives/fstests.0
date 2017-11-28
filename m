Received: from mail-qk0-f194.google.com ([209.85.220.194]:38259 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbdK1UAi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Nov 2017 15:00:38 -0500
Received: by mail-qk0-f194.google.com with SMTP id z203so1462140qkb.5
        for <fstests@vger.kernel.org>; Tue, 28 Nov 2017 12:00:38 -0800 (PST)
Date: Tue, 28 Nov 2017 15:00:36 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 10/13] fstests: crash consistency fsx test using
 dm-log-writes
Message-ID: <20171128200035.26kqhetxtemnm7z4@destiny>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-11-git-send-email-amir73il@gmail.com>
 <CAOQ4uxi_SjKCJ97Knvh4S6UiD3jskHEqDja7wwc+-mXp4CNbEw@mail.gmail.com>
 <20171127150439.i4tpt4yhooxnoaiz@destiny>
 <CAOQ4uxiGryFy7GLZUa0EWcbT+50cMfBb8a2dYa1mZ7tEf+UURg@mail.gmail.com>
 <20171128172152.ktvpnwv233govfwl@destiny>
 <CAOQ4uxgeKdZnxXcvt10MG2kT4PTZ4eZH+-v2R0zPJXTcRvONeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgeKdZnxXcvt10MG2kT4PTZ4eZH+-v2R0zPJXTcRvONeQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 28, 2017 at 09:32:59PM +0200, Amir Goldstein wrote:
> On Tue, Nov 28, 2017 at 7:21 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> > On Tue, Nov 28, 2017 at 06:48:43PM +0200, Amir Goldstein wrote:
> >> On Mon, Nov 27, 2017 at 5:04 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> >> > On Mon, Nov 27, 2017 at 11:56:58AM +0200, Amir Goldstein wrote:
> >> >> On Tue, Sep 5, 2017 at 10:11 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> >> >> > Cherry-picked the test from commit 70d41e17164b
> >> >> > in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
> >> >> > Quoting from Josef's commit message:
> >> >> >
> >> >> >   The test just runs some ops and exits, then finds all of the good buffers
> >> >> >   in the directory we provided and:
> >> >> >   - replays up to the mark given
> >> >> >   - mounts the file system and compares the md5sum
> >> >> >   - unmounts and fsck's to check for metadata integrity
> >> >> >
> >> >> >   dm-log-writes will pretend to do discard and the replay-log tool will
> >> >> >   replay it properly depending on the underlying device, either by writing
> >> >> >   0's or actually calling the discard ioctl, so I've enabled discard in the
> >> >> >   test for maximum fun.
> >> >> >
> >> >> > [Amir:]
> >> >> > - Removed unneeded _test_falloc_support dynamic FSX_OPTS
> >> >> > - Fold repetitions into for loops
> >> >> > - Added place holders for using constant random seeds
> >> >> > - Add pre umount checkpint
> >> >> > - Add test to new 'replay' group
> >> >> > - Address review comments by Eryu Guan
> >> >> >
> >> >> > Cc: Josef Bacik <jbacik@fb.com>
> >> >> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> >>
> >> >>
> >> >> Josef,
> >> >>
> >> >> As you know, this test is now merged to xfstest as generic/455.
> >> >> I have been running the test for a while on xfs and it occasionally
> >> >> reports inconsistencies which I try to investigate.
> >> >>
> >> >> In some of the reports, it appears that dm-log-writes may be exhibiting
> >> >> a reliability issue (see below).
> >> >>
> >> >
> >> > It's not a reliability issue, its a caching issue.  dm-log-writes is just
> >> > issuing bio's to the log device, and our destructor waits for all pending io
> >> > blocks to complete before exiting, so unless I've missed how dm is destroying
> >> > devices everything should be on disk.
> >> >
> >> > However since we replay in userspace we are going through the blockdevice's
> >> > pagecache, so we could have stale pages left in place which is screwing us up.
> >> > Will you try this patch and see if it fixes the problem?  Thanks,
> >> >
> >> > Josef
> >> >
> >> >
> >> > diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> >> > index 8b80a9ce9ea9..1c502930af5e 100644
> >> > --- a/drivers/md/dm-log-writes.c
> >> > +++ b/drivers/md/dm-log-writes.c
> >> > @@ -545,6 +545,8 @@ static void log_writes_dtr(struct dm_target *ti)
> >> >                    !atomic_read(&lc->pending_blocks));
> >> >         kthread_stop(lc->log_kthread);
> >> >
> >> > +       invalidate_bdev(lc->logdev->bdev);
> >> > +       invalidate_bdev(lc->dev->bdev);
> >> >         WARN_ON(!list_empty(&lc->logging_blocks));
> >> >         WARN_ON(!list_empty(&lc->unflushed_blocks));
> >> >         dm_put_device(ti, lc->dev);
> >>
> >> Josef,
> >>
> >> With your patch OR with my xfstest patch that adds "sync" I did not yet see
> >> another problem of garbage fs after _log_writes_remove.
> >>
> >> I did however, encounter this error (failure to verify read data during fsx)
> >> from scratch/log-writes device (see attached full log).
> >>
> >> I will keep running the test to collect more information.
> >>
> >
> > That failure I'll lay at the feet of whatever fs you are testing ;).  I'm glad
> > my patch fixed the replay problem, I'll send that up.  Thanks,
> >
> 
> O oh!. You are implying that xfs fails plain fsx and nobody noticed.
> That is not where I would place my bet.
> 

Why not?  This is one of the only tests that runs multiple threads of fsx at the
same time.  dm-log-writes does nothing special with the actual target disk, it
just clones the bio's as it gets them, sets the bdev for the normal device and
sends them on their way, there's no reason to think we're breaking that.
Furthermore fsx is in normal page cache mode, not O_DIRECT, so it's more likely
something else is going wrong and not dm-log-writes, unless there is so little
memory on the system that we are constantly reading cold-cache.  Thanks,

Josef
