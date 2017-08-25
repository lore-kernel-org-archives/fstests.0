Received: from mail-vk0-f67.google.com ([209.85.213.67]:36327 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdHYG3H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2017 02:29:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id d124so630747vkf.3
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2017 23:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825053113.GR31418@eguan.usersys.redhat.com>
References: <1503578906-11387-1-git-send-email-idryomov@gmail.com> <20170825053113.GR31418@eguan.usersys.redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 25 Aug 2017 08:29:06 +0200
Message-ID: <CAOi1vP9F6rmEuZ-EBKGsdmw4-WfS-9ovhHS9tC2oD3Drb0dcAA@mail.gmail.com>
Subject: Re: [PATCH] generic/108: tolerate old lvm utility versions
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 25, 2017 at 7:31 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Aug 24, 2017 at 02:48:26PM +0200, Ilya Dryomov wrote:
>> lvm utility in Ubuntu 14.04 LTS treats -l 100%FREE as a hard number and
>> not as an approximate upper limit.  With ~5G scratch partition and ~128M
>
> I just looked for an Ubuntu 14.04 LTS box and confirmed lvcreate does
> support '-l 100%FREE'. Even on distributions as old as RHEL6 support
> this usage too. Perpahs there were other things went wrong in your test
> environment?

The syntax is supported, but the semantics are different.  Compare
lvcreate(8) man pages on Ubuntu 14.04 LTS and something more recent:

"When expressed as a percentage, the number is treated as an
approximate upper  limit  for the total  number  of  physical  extents
to be allocated (including extents used by any mirrors, for example)."

In the example I gave, '-l 100%FREE' translates to 1310 PEs on Trusty
vs ~60 PEs on a recent Fedora.

Thanks,

                Ilya
