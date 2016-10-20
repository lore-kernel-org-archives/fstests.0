Received: from mail-lf0-f68.google.com ([209.85.215.68]:34925 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbcJTRg4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Oct 2016 13:36:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id x79so1203992lff.2
        for <fstests@vger.kernel.org>; Thu, 20 Oct 2016 10:36:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020143559.GK27776@eguan.usersys.redhat.com>
References: <1476689014-384-1-git-send-email-amir73il@gmail.com>
 <1476689014-384-2-git-send-email-amir73il@gmail.com> <20161020143559.GK27776@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Oct 2016 20:36:54 +0300
Message-ID: <CAOQ4uxg6OJeHqdm7d+N38r3-ZtXCC5SAQMaTWy2EivAUEMMeOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fstests: strip quotes from "$XFS_IO_PROG" call sites
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 20, 2016 at 5:35 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Oct 17, 2016 at 10:23:33AM +0300, Amir Goldstein wrote:
>> The value of "$XFS_IO_PROG" may contain extra flags after the
>> binary path (e.g. -F), so it is wrong to use the variable inside
>> quotes in xfs_io execution call sites.
>>
>> This bug surfaced while testing the new xfs_io -M flag.
>                                                 ^^^ should be -i now? :)

indeed
Thanks.

>
> I can fix it at commit time.
>
> Thanks,
> Eryu
