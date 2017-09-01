Received: from mail-qt0-f178.google.com ([209.85.216.178]:35120 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdIAUHD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Sep 2017 16:07:03 -0400
Received: by mail-qt0-f178.google.com with SMTP id x36so5563068qtx.2
        for <fstests@vger.kernel.org>; Fri, 01 Sep 2017 13:07:03 -0700 (PDT)
Date: Fri, 1 Sep 2017 16:07:01 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 00/14] Crash consistency xfstest using dm-log-writes
Message-ID: <20170901200658.txwbtntrtqwqdvcq@destiny>
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
> I will try to work something out so that kvm-xfstest will use aio=native
> when using the recommended (by not default) LV setup.
> 
> However, why would aio=threads cause log corruption?
> Does it indicate a bug in kvm-qemu or in dm-log-writes??

So I've been running this in a loop all day with aio=threads and it's not
blowing up.  This is my qemu version

QEMU emulator version 2.9.0(qemu-2.9.0-1.fb1)

Maybe it has to do with the version of qemu?  Thanks,

Josef
