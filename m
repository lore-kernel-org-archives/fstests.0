Received: from mail-lf0-f66.google.com ([209.85.215.66]:34662 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934899AbcJQVt6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2016 17:49:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id x23so23178625lfi.1
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2016 14:49:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com> <20161016214608.GC14023@dastard>
 <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Oct 2016 00:49:56 +0300
Message-ID: <CAOQ4uxiGUeJUWYg=_j6cww9Y+Z7aMX9aRi3+AbivGFSiAe2LWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick' tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 17, 2016 at 10:01 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Oct 17, 2016 at 12:46 AM, Dave Chinner <david@fromorbit.com> wrote:
>> On Sun, Oct 16, 2016 at 01:53:42PM +0300, Amir Goldstein wrote:
>>> Try to run xfs_io for tests in group quick with command line
>>> option -M which starts an idle thread before performing any io.
>>>
>>> The purpose of this idle thread is to test io from a multi threaded
>>> process. With single threaded process, the file table is not shared
>>> and file structs are not reference counted.
>>>
>>> In order to improve the chance of detecting file struct reference
>>> leaks, we should run xfs_io commands with this option as much as
>>> possible.
>>>
>>> Analysis of the effect of xfs_io -M on tests runtime showed that
>>> it may lead to slightly longer run times in extreme cases (e.g +3s
>>> for generic/132), but has a negligable effect on runtime of tests
>>> among the 'quick' group (worst case +0.3s for generic/130).
>>>
>>> Therefore, we automatically add the -M flags only to tests in the
>>> 'quick' group.
>>>
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>> ---

...

>> A couple of seconds of
>> extra runtime here and there means nothing for a typical auto test
>> run which can take hours to run....
>>
>

Just to follow up on the extra runtime.
I did one auto test run at 1h42m without -i flag
and then auto test run at 1h45m with -i flag
I did not repeat several runs to reduce noise.
If anyone thinks that difference is too expensive please shout.

Amir.
