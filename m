Received: from mail-ot0-f193.google.com ([74.125.82.193]:36360 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755057AbdBQHoz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 02:44:55 -0500
Received: by mail-ot0-f193.google.com with SMTP id l26so3881557ota.3
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 23:44:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170217042746.s26i6j4x4veydje4@XZHOUW.usersys.redhat.com>
References: <1487236435-6222-1-git-send-email-xzhou@redhat.com>
 <1487236435-6222-5-git-send-email-xzhou@redhat.com> <CAOQ4uxif0Z_xnxOr_jKqwYeVF4rHbX78X5hYY=wrGUOq_eA6ag@mail.gmail.com>
 <20170217042746.s26i6j4x4veydje4@XZHOUW.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Feb 2017 09:44:54 +0200
Message-ID: <CAOQ4uxhJ1V=-vSyjnUCKx9_pCfb+kemrVZMAdj=oqj-nCPa1XQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] overlay: filter out xattr starts with "trusted.overlay."
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 6:27 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> On Thu, Feb 16, 2017 at 02:41:16PM +0200, Amir Goldstein wrote:
>> On Thu, Feb 16, 2017 at 11:13 AM, Xiong Zhou <xzhou@redhat.com> wrote:
>> > Not "trusted.overlay".
>> >   "trusted.overlayxxx" is allowed.
>> >   "trusted.overlay.xxx" is not allowed.
>> >
>> > CC: Miklos Szeredi <mszeredi@redhat.com>
>> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> > ---
...
>
> Thanks all for the comments. I'm sending v2 based on them and
> my test results on RHEL/upstream kernels.
>

You're welcome. Those are some good tests!

I suggest that you CC linux-unionfs next time
I don't know how many subscribers it has that are not on fstests,
but that's the official overlayfs mailing list, so it seems in order.

Cheers,
Amir.
