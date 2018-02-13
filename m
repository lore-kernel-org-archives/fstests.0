Received: from mail-io0-f195.google.com ([209.85.223.195]:42473 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933865AbeBMKhb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Feb 2018 05:37:31 -0500
Received: by mail-io0-f195.google.com with SMTP id g14so14560871iob.9
        for <fstests@vger.kernel.org>; Tue, 13 Feb 2018 02:37:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213100902.GK18267@eguan.usersys.redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com> <20180213091203.22909-3-eguan@redhat.com>
 <CAOQ4uxjqiutLKnYj4FhU9pT516bv-OVqfiwdjVcV5OMq_FNN4w@mail.gmail.com> <20180213100902.GK18267@eguan.usersys.redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 13 Feb 2018 11:37:30 +0100
Message-ID: <CAHc6FU6N3vZYsNornxgZo3MrsAc-fshcBFc7EMCaeEOvcWJP=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: use _scratch_mount_nocheck where appropriate
 in tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On 13 February 2018 at 11:09, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Feb 13, 2018 at 11:58:48AM +0200, Amir Goldstein wrote:
>> On Tue, Feb 13, 2018 at 11:12 AM, Eryu Guan <eguan@redhat.com> wrote:
>> > Also remove redundant status checks of _scratch_mount.
>>
>> Is there any correlation between tests that need to use _scratch_mount_nocheck
>> tests which _require_scratch_nocheck that could make some of these annotations
>> automatic?
>
> No, they have totally different meanings. _require_scratch_nocheck means
> don't do filesystem check after test, and _scratch_mount_nocheck means
> don't check mount status.
>
> Perhaps it's just badly named, I can follow Andreas's suggestion to name
> it as _try_scratch_mount or similar names.

To me, "nocheck" tends to indicate that the result isn't checked
because it doesn't matter, so _try_scratch_mount seems much better.

Thanks,
Andreas
