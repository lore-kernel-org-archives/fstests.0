Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:11307 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbfAOGIF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Jan 2019 01:08:05 -0500
Date: Tue, 15 Jan 2019 17:08:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/scsi_debug: make sure scsi_debug been removed
 correctly
Message-ID: <20190115060800.GA2135@dastard>
References: <20190109054845.93810-1-yangerkun@huawei.com>
 <20190109210243.GG27534@dastard>
 <a91e3234-9a4a-27b4-2382-683f773e892c@huawei.com>
 <20190115034743.GS27534@dastard>
 <edf7a7c5-0ed2-7810-5acc-2aeed65db5d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edf7a7c5-0ed2-7810-5acc-2aeed65db5d4@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: yangerkun <yangerkun@huawei.com>
Cc: guaneryu@gmail.com, houtao1@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 15, 2019 at 01:31:24PM +0800, yangerkun wrote:
> 
> 
> Dave Chinner wrote on 2019/1/15 11:47:
> >On Sat, Jan 12, 2019 at 10:20:26AM +0800, yangerkun wrote:
> >>
> >>
> >>Dave Chinner wrote on 2019/1/10 5:02:
> >>>On Wed, Jan 09, 2019 at 01:48:45PM +0800, yangerkun wrote:
> >>>>Case generic/108 sometimes will fail while testing ext2, and the reson
> >>>>is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
> >>>>add the loop to do rmmod to make sure scsi_debug can be removed
> >>>>correctly.
> >>>
> >>>Why does 'rmmod scsi_debug' randomly fail?
> >>>
> >>>What bug does ext2 have that prevents the scsi debug module from
> >>>being released and hence removed?
> >>
> >>It's not a bug with ext2, ever been existing in ext4 too. This patch
> >>is a reference to 'https://gitlab.com/cryptsetup/cryptsetup.git'
> >>commit d7b9ed05f0931b416c33c8eb2ff1e6efa39270ff, and the reason why
> >>need this is that the behavior of udev cannot be speculated, so
> >>scsi_debug may rmmod failed since udev scan open the device and take
> >>the reference of module scsi_debug.
> >
> >IOWs, you copied a hack from cryptsetup tests because you didn't
> >know about $UDEV_SETTLE_PROG and didn't think to ask if anyone knew
> >a solution to this problem?
> 
> I have test to add udev settle before really do 'rmmod scsi_debug',
> and the result is the same, sometimes 'rmmod scsi_debug' may failed
> too.i

So what is generating the events that udev is running that pins the
scsi debug device given that it is no longer in use?

> For this question, i have ask Ondrej Konzina, the question and
> answer are as follow:
> 
> Question:
> "Hi,
> 
> While we are testing fs with xfstests, generic/108 will fail at some
> times with the reson that rmmod find the refcnt of scsi_debug module
> isn't 0 by checking /proc/modules. And this your patch is really
> describe the same thing. But, i am confusing about the scene as you said:
>    cleanup() {
>           if [ -d "$MNT_DIR" ] ; then
>               umount -f $MNT_DIR 2>/dev/null
>               rmdir $MNT_DIR 2>/dev/null
>           fi
>           rm -f $LOCAL_FILE 2> /dev/null
> -       udevadm settle >/dev/null 2>&1
> -       rmmod scsi_debug 2> /dev/null
> +       scsi_debug_teardown "$DEV" || exit 100
>    }
> 
> After the settle, all the event has been finish, so who will trigger the
> scan, and how to scan? Can you help to explain this? Thanks a lot!
> "
> Answer:
> "Well, almost true. But by our experience udev settle command
> behaviour is not strictly defined (and also discouraged from using
> even by udev maintainers themselves IIRC). For example it will not
> synchronize you against events coming after you trigger the settle
> command.

So, in summary:

We used to have wait loops like you are proposing, then the udevadm
settle command was added and we replaced all the wait loops with
settles because that worked reliably.

Now we're at the stage where udevadm settle doesn't work any more,
the maintainers have effectively deprecated it without a
replacement, and so we have to go back to hard coding hacky wait
loops everywhere to retry until udev releases whatever random
devices it holds references to?

Forget I said anything, I'm rapidly coming to the conclusion that I
have far too high standards for writing "working" software these
days.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
