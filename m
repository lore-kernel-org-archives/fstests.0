Received: from mail-io0-f172.google.com ([209.85.223.172]:49343 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdJLHTW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2017 03:19:22 -0400
Received: by mail-io0-f172.google.com with SMTP id n137so4486029iod.6
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2017 00:19:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012042515.GY10593@eguan.usersys.redhat.com>
References: <1507647298-9971-1-git-send-email-idryomov@gmail.com> <20171012042515.GY10593@eguan.usersys.redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 12 Oct 2017 09:19:21 +0200
Message-ID: <CAOi1vP978u=bqcwN2L861Y-Uveg-MGBi+CB_oTRpDJVA05kb0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] generalize AIO/DIO dmesg filter
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 12, 2017 at 6:25 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Oct 10, 2017 at 04:54:55PM +0200, Ilya Dryomov wrote:
>> With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
>> when mixing buffered and AIO DIO"), we need to whitelist dio_complete()
>> for ext4 pretty much everywhere iomap_dio_complete() and friends are
>> whitelisted for xfs.
>
> Thanks for fixing this! I agreed with Dave that we should move the
> filter to common/filter file, but that's easy to do and I can fix it up
> at commit time.

I already fixed it -- just waiting for more comments before reposting.

>
> I was thinking adding this filter to _check_dmesg unconditionally, so we
> don't have to the filter case by case. But I guess it's better to be
> more careful, in case we miss any real bug.

Definitely!

Thanks,

                Ilya
