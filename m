Received: from mail-wm0-f43.google.com ([74.125.82.43]:38017 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbcJOU7o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Oct 2016 16:59:44 -0400
Received: by mail-wm0-f43.google.com with SMTP id d128so41374338wmf.1
        for <fstests@vger.kernel.org>; Sat, 15 Oct 2016 13:59:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161015170441.GA23090@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com> <20161015091126.GA9631@infradead.org>
 <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com> <20161015170441.GA23090@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Oct 2016 23:59:22 +0300
Message-ID: <CAOQ4uxjumg_VO3LV7rgtHbO=yTmxUp6KdpmrCh8ASEjG6tG3XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 15, 2016 at 8:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 15, 2016 at 06:13:29PM +0300, Amir Goldstein wrote:
>> I can't say that I have made a statistics analysis of the affect of the flag
>> on xfstests runtime, but for the -g quick group on small SSD partition,
>> I did not observe any noticable difference in runtime.
>>
>> I will try to run some micro benchmarks or look for specific tests that
>> do many file opens and little io, to get more performance numbers.
>

Here goes.
I ran a simple micro benchmark of running 'xfs_io -c quit' 1000 times
with and without -M flag and the -M flags adds 0.1sec (pthread_ctreate
I suppose)

Looked for a test that runs a lot of xfs_io. found generic/032, which runs
xfs_io 1700 times, mostly for pwrite. This is not a CPU intensive
test, but there is
an avg. runtime difference of +0.2sec for -M flag (out of 8sec).

Taking a look at the runtime difference of entire -g quick did not yield any
obvious changes, all reported runtimes were within the +/-1sec margin,
some were clearly noise as the tests where not running xfs_io at all.

Still I looked closer for tests that do a lot of small read/writes and I found
generic/130, which does many small preads, but from few xfs_io runs.
This is a more CPU intensive test.
There is an avg. runtime difference of +0.3sec for -M flag (out of 4sec).

So far so good, but then I looked closer at its sister test
generic/132, which is
an even more CPU intensive test, also of many small reads and writes
from few xfs_io runs.
This is not a 'quick' group test.
Here the runtime difference was significant 17sec without -M and 20sec
with -M flag.

So without looking much closer into other non quick tests, I think
that perhaps the
best value option is to turn on -M flag for all the quick tests.

What do you think?


> Yes, if there is no effect at least that's not a problem.  I'd just want
> confirmation for that.  In the end we probably don't use xfs_io heavily
> parallel on the same fd a lot.

So there is an effect on specific tests that end up calling fdget() a
lot compared
to the amount of io they generate, but I don't think that we have to
use xfs_io in
parallel on the same fd to see the regression.
The fast path optimization for single threaded process avoids the
rcu_read_lock()
in __fget() altogether and with multi threaded process we take the
rcu_read_lock()
and other stuff even though we are the only process using this fd.

This is just my speculation as I did not run perf analysis on those
fdget intensive tests.
