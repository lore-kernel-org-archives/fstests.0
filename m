Received: from mail-yw0-f172.google.com ([209.85.161.172]:33332 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdIDGtm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2017 02:49:42 -0400
Received: by mail-yw0-f172.google.com with SMTP id c85so15211008ywa.0
        for <fstests@vger.kernel.org>; Sun, 03 Sep 2017 23:49:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170904064214.GI17782@dastard>
References: <CAOQ4uxh8av5H87SHdFw92BDTvCtYgd9chS2Nfv5fA4=upoqRfA@mail.gmail.com>
 <20170830152326.vil3fhsrecp2ccql@destiny> <CAOQ4uxjE20+vY4OPWM3Z=FU-+4oC1KrYtJ5e7-rQDW4xx5t4RA@mail.gmail.com>
 <20170830185512.7q5mnh5ja6o4mpds@destiny> <CAOQ4uxipsvjjMF6YRJbN62tBrPNWOFjHztoDJ7CrsFfjNxRQBQ@mail.gmail.com>
 <CAOQ4uxjt-zZ7_iE7ZYUcp8qWYUH=aDLSum70Dmbnth-5smFQ+A@mail.gmail.com>
 <20170831134320.lnyu4jibsm3amuk7@destiny> <CAOQ4uxhgOYDfRxZ74RNd=omOMHxF2MgP+wLe0O6HO7+emnrMfA@mail.gmail.com>
 <20170831205403.2tene34ccvw55yo7@destiny> <CAOQ4uxgbyd1FgF9GsjEwhf+KC-CMd=1QK-F=tevBpq5YByW=Zg@mail.gmail.com>
 <20170904064214.GI17782@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Sep 2017 09:49:41 +0300
Message-ID: <CAOQ4uxg6cg_L1sxDnUtZQXvyda802rB+dUrQUg3iM5=JEjJMyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Crash consistency xfstest using dm-log-writes
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests <fstests@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 4, 2017 at 9:42 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Sep 01, 2017 at 09:52:18AM +0300, Amir Goldstein wrote:
>> [CC list, Ted]
>>
>> ...
>> >>
>> >
>> > Alright I tested it and it's working fine for me.  I'm creating three lv's and
>> > then doing
>> >
>> > -drive file=/dev/mapper/whatever,format=raw,cache=none,if=virtio,aio=native
>> >
>> > And I get /dev/vd[bcd] which I use for my test/scratch/log dev and it works out
>> > fine.  What is your -drive option line and I'll duplicate what you are doing.
>> > Thanks,
>> >
>>
>> I am using Ted's kvm-xfstests, so this is the qemu command line:
>> https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/kvm-xfstests#L104
>>
>> The only difference in -drive command is no aio=native.
>> BINGO! when I add aio-native there are no more log corruptions :)
>> Please try to use aio=threads to see if you also get log corruptions.
>>
>> Thing is we cannot change kvm-xfstests to always use aio=native because
>> it is not recommended for sparse images:
>> https://access.redhat.com/articles/41313
>
> Hmmmm. I think you're looking at an article that's at least 6 years
> out of date. It was last updated at:
>
>         Updated September 16 2012 at 2:04 AM
>
> Looking at the bug it references there was a heap of problems in the
> DIO code, the AIO code and the filesystem code that we fixed in
> upstream kernels in late 2010/early 2011. e.g
>
> http://oss.sgi.com/archives/xfs/2011-01/msg00156.html
>
> Those took some time to get back into vendor kernels, but the
> aio=native kvm problems described in that kbase article were fixed
> in a RHEL 6.1 point release in May 2011.
>
> IOWs, if qemu w/ aio=native doesn't work these days, the article
> you've quoted is not the reason.
>
>

In that case, I'll post a patch to have kvm-xfstests use aio=native.
I suppose it is the proper way to run xfstests inside kvm anyway.

Thanks,
Amir.
