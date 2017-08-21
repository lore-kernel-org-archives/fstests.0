Received: from mail-wr0-f195.google.com ([209.85.128.195]:36382 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHUKwt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2017 06:52:49 -0400
MIME-Version: 1.0
In-Reply-To: <CADxRZqz_m69YL214tiimqCQ-+pYAvc1UFO_HgvTdKKok0_LzXw@mail.gmail.com>
References: <CADxRZqykqGycgPh5O9C1F_Eq0J_rP-95zxesDkSDbkLD=04uYA@mail.gmail.com>
 <CADxRZqz_m69YL214tiimqCQ-+pYAvc1UFO_HgvTdKKok0_LzXw@mail.gmail.com>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 21 Aug 2017 13:52:47 +0300
Message-ID: <CADxRZqyHkwT+HVTQopDZYiAwkCAkBDvPM0eY-Cqw6e5XuzcZ5Q@mail.gmail.com>
Subject: Re: [xfstests, sparc64] git kernel OOPS 4.13.0-rc5+
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: lvm-devel@redhat.com
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 21, 2017 at 1:26 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Sun, Aug 20, 2017 at 1:02 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>>  Hello!
>>
>> Running xfstests (git) suite , I'm getting git kernel OOPS :
>
> Just tested on debian kernel
>
> Linux ttip 4.12.0-1-sparc64-smp #1 SMP Debian 4.12.6-1 (2017-08-12)
> sparc64 GNU/Linux
>
> it does not trigger OOPS, but ends in other way:

well, just compiled v4.12 with gcc-7, it triggers OOPS... going to
check with gcc-6 now...
