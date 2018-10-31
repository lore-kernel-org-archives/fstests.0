Received: from mail-io1-f65.google.com ([209.85.166.65]:34197 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbeJaTXi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Oct 2018 15:23:38 -0400
Received: by mail-io1-f65.google.com with SMTP id d80-v6so9283204iof.1
        for <fstests@vger.kernel.org>; Wed, 31 Oct 2018 03:26:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi9YX23C7NLQ2yqsz1Ur4nwMZFbQta=nBU=6bvYPU2YGg@mail.gmail.com>
References: <20181031095502.12504-1-mszeredi@redhat.com> <CAOQ4uxi9YX23C7NLQ2yqsz1Ur4nwMZFbQta=nBU=6bvYPU2YGg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 31 Oct 2018 11:26:06 +0100
Message-ID: <CAJfpegtOzh9Z3xPJi6aFgzGazCVr5WHXaHw1s6mXMhpav0xT7A@mail.gmail.com>
Subject: Re: [PATCH] overlay: create directory over deleted whiteout
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 31, 2018 at 11:17 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Oct 31, 2018 at 11:55 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>>
>> There's a bug in the overlayfs implementation starting from the very first
>> merged version that may cause an Oops of various forms if a directory is created
>> over a whiteout dentry, but the actual whiteout on the upper layer was removed
>> to the directory creation.
>>
>> Reported by: kaixuxia <xiakaixu1987@gmail.com>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>
> Looks good. A bit of commentary could be useful...

Okay.

>> +
>> +# unmount overlayfs
>> +$UMOUNT_PROG $SCRATCH_MNT
>
> Umount of scratch is not needed at the end of the test.

It's not strictly needed, but gives additional assurance that things
hadn't gone bad (after the oops umount returns with EBUSY).

Thanks,
Miklos
