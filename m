Received: from mail-wm0-f67.google.com ([74.125.82.67]:33574 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbcJOPNb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Oct 2016 11:13:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id 191so2828652wmr.0
        for <fstests@vger.kernel.org>; Sat, 15 Oct 2016 08:13:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161015091126.GA9631@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com> <20161015091126.GA9631@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Oct 2016 18:13:29 +0300
Message-ID: <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 15, 2016 at 12:11 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Oct 14, 2016 at 11:43:30PM +0300, Amir Goldstein wrote:
>> Try to run xfs_io in all tests with command line option -M
>> which starts an idle thread before performing any io.
>>
>> The purpose of this idle thread is to test io from a multi threaded
>> process. With single threaded process, the file table is not shared
>> and file structs are not reference counted.
>>
>> So in order to improve the change of detecting file struct reference
>> leaks, all xfs_io commands in tests will try to run with this option.
>
> I like the idea behing the -M command, but I'm not sure if we should
> always use it.  For one this means we won't test the fget fastpath
> any more,

Indeed, I gave this some thought and decided to post as use always
and discuss the other options here.
Random use of the flag - inconsistent results - I don't like it.
Optional use of the flag - doubles the test matrix and rarely people
will use the
non default.
Consistent pseudo random - say only for odd test numbers, unless test specifies
explicitly use of mutli/single threaded xfs_io - I don't like it as well.
Make the flag default according to some half-related kernel config option
(say XFS_DEBUG?). it stincks a bit, but at least it's got the advantage of
large group of people running xfstests with and without it.

Please cast your votes and suggest better options if you have any.

> and second I'd like to know what the impact on xfstests
> runtime is.

On which tests or setups would you expect that this change would make most
difference?

I can't say that I have made a statistics analysis of the affect of the flag
on xfstests runtime, but for the -g quick group on small SSD partition,
I did not observe any noticable difference in runtime.

I will try to run some micro benchmarks or look for specific tests that
do many file opens and little io, to get more performance numbers.

Amir.
