Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:39978 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751949AbdIDGmS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2017 02:42:18 -0400
Date: Mon, 4 Sep 2017 16:42:14 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 00/14] Crash consistency xfstest using dm-log-writes
Message-ID: <20170904064214.GI17782@dastard>
References: <CAOQ4uxh8av5H87SHdFw92BDTvCtYgd9chS2Nfv5fA4=upoqRfA@mail.gmail.com>
 <20170830152326.vil3fhsrecp2ccql@destiny>
 <CAOQ4uxjE20+vY4OPWM3Z=FU-+4oC1KrYtJ5e7-rQDW4xx5t4RA@mail.gmail.com>
 <20170830185512.7q5mnh5ja6o4mpds@destiny>
 <CAOQ4uxipsvjjMF6YRJbN62tBrPNWOFjHztoDJ7CrsFfjNxRQBQ@mail.gmail.com>
 <CAOQ4uxjt-zZ7_iE7ZYUcp8qWYUH=aDLSum70Dmbnth-5smFQ+A@mail.gmail.com>
 <20170831134320.lnyu4jibsm3amuk7@destiny>
 <CAOQ4uxhgOYDfRxZ74RNd=omOMHxF2MgP+wLe0O6HO7+emnrMfA@mail.gmail.com>
 <20170831205403.2tene34ccvw55yo7@destiny>
 <CAOQ4uxgbyd1FgF9GsjEwhf+KC-CMd=1QK-F=tevBpq5YByW=Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgbyd1FgF9GsjEwhf+KC-CMd=1QK-F=tevBpq5YByW=Zg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests <fstests@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 01, 2017 at 09:52:18AM +0300, Amir Goldstein wrote:
> [CC list, Ted]
> 
> On Thu, Aug 31, 2017 at 11:54 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> > On Thu, Aug 31, 2017 at 05:02:46PM +0300, Amir Goldstein wrote:
> >> On Thu, Aug 31, 2017 at 4:43 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> >> > On Thu, Aug 31, 2017 at 03:48:44PM +0300, Amir Goldstein wrote:
> >> >>
> >> >> Josef,
> >> >>
> >> >> I am at lost with these log corruptions.
> >> >> I see log entry bios submitted and log_end_io report success,
> >> >> but then in the log I see old data on disk where that entry should be.
> >> >> This happens quite randomly and I assume it also happens on
> >> >> logged data, because tests sometime fail on checksum on ext4.
> >> >>
> >> >> Mean while I added some more log entry sanity checks and debug
> >> >> prints to replay-log to debug the corruption:
> >> >> https://github.com/amir73il/xfstests/commit/bb946deb0dc285867be394613ddb19ce281392cc
> >> >>
> >> >> This only happens to me when running in kvm, so maybe something
> >> >> with the virtio devices is fishy.
> >> >>
> >> >> Anyway, I ran out of time to work on this for now, so if you have
> >> >> any ideas and/or time to test this issue, let me know.
> >> >>
> >> >
> ...
> >>
> >
> > Alright I tested it and it's working fine for me.  I'm creating three lv's and
> > then doing
> >
> > -drive file=/dev/mapper/whatever,format=raw,cache=none,if=virtio,aio=native
> >
> > And I get /dev/vd[bcd] which I use for my test/scratch/log dev and it works out
> > fine.  What is your -drive option line and I'll duplicate what you are doing.
> > Thanks,
> >
> 
> I am using Ted's kvm-xfstests, so this is the qemu command line:
> https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/kvm-xfstests#L104
> 
> The only difference in -drive command is no aio=native.
> BINGO! when I add aio-native there are no more log corruptions :)
> Please try to use aio=threads to see if you also get log corruptions.
> 
> Thing is we cannot change kvm-xfstests to always use aio=native because
> it is not recommended for sparse images:
> https://access.redhat.com/articles/41313

Hmmmm. I think you're looking at an article that's at least 6 years
out of date. It was last updated at:

	Updated September 16 2012 at 2:04 AM

Looking at the bug it references there was a heap of problems in the
DIO code, the AIO code and the filesystem code that we fixed in
upstream kernels in late 2010/early 2011. e.g

http://oss.sgi.com/archives/xfs/2011-01/msg00156.html

Those took some time to get back into vendor kernels, but the
aio=native kvm problems described in that kbase article were fixed
in a RHEL 6.1 point release in May 2011.

IOWs, if qemu w/ aio=native doesn't work these days, the article
you've quoted is not the reason.


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
