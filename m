Received: from mail-wm0-f44.google.com ([74.125.82.44]:34946 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbcJPIwA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 04:52:00 -0400
Received: by mail-wm0-f44.google.com with SMTP id c78so56963428wme.0
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2016 01:51:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161016071458.GA17675@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com> <20161015091126.GA9631@infradead.org>
 <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com>
 <20161015170441.GA23090@infradead.org> <CAOQ4uxjumg_VO3LV7rgtHbO=yTmxUp6KdpmrCh8ASEjG6tG3XA@mail.gmail.com>
 <20161016071458.GA17675@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Oct 2016 11:51:58 +0300
Message-ID: <CAOQ4uxgU_Z2W8w8HJ5Y9BMT=3bOZnfpphwi7gzjhWZUJGqSHzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 16, 2016 at 10:14 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 15, 2016 at 11:59:22PM +0300, Amir Goldstein wrote:
>> So far so good, but then I looked closer at its sister test
>> generic/132, which is
>> an even more CPU intensive test, also of many small reads and writes
>> from few xfs_io runs.
>> This is not a 'quick' group test.
>> Here the runtime difference was significant 17sec without -M and 20sec
>> with -M flag.
>>
>> So without looking much closer into other non quick tests, I think
>> that perhaps the
>> best value option is to turn on -M flag for all the quick tests.
>>
>> What do you think?
>
> Sounds like a good idea, now how do we find out in the xfs_io
> helper if it's a quick test?

See answer in posted v2

Thanks for review!
