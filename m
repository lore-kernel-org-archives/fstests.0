Received: from mail-yw1-f67.google.com ([209.85.161.67]:34560 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEKwL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Mar 2019 05:52:11 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <CAL3q7H6ceptNOyf65jbzojbZV5Nq3d0iKvYOvvE=pLaVnpgO2w@mail.gmail.com>
 <CAOQ4uxhno=ORXpLgLC2O7KoJJXm2sVEtZ8DgiHZi-4p_HmfEwg@mail.gmail.com>
 <CAL3q7H6XDTkp+wHmM9+ON+smcqk6fR5fL3Bf1OmVFE06BRnEjw@mail.gmail.com>
 <CAOQ4uxg_D0r2L=6zg4yxN1AfzkK8aHkWwOQPKEaKt8Z7WtVf2w@mail.gmail.com> <CAL3q7H7F8tuczjCXCUOewuJu3CKLq+MgYv-B2mbLA8qep7+xyA@mail.gmail.com>
In-Reply-To: <CAL3q7H7F8tuczjCXCUOewuJu3CKLq+MgYv-B2mbLA8qep7+xyA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2019 12:51:59 +0200
Message-ID: <CAOQ4uxjMh-Nh2-spNCVUR07mYkuDNfJozVm8dTUmOtZxF+eSCQ@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

> > As I wrote to Dave, if file is not "metadata dirty" before rename,
> > then whether or not rename dirties to file for fsync is a filesystem
> > specific implementation detail that is not in any standard.
> >
> > Since filesystems tend to try to optimize out unneeded journal
> > commits, so the observation about what filesystems do today
> > empirically is not a sufficiently strong argument.
>
> Even if the strictly ordered metadata guarantees Dave explained so
> many time before is not formally defined anywhere,
> I think it's a behavior that shouldn't change, as not only it makes
> sense, but applications might be relying on it and therefore
> useful to make sure no regressions happen. If such tests should be
> shared (and run only filesystems known to support
> the strictly ordered metadata) or require something special, is
> another question.
>

I agree with you that it is good to test and verify those semantics.
I was not arguing against assuming strictly ordered metadata.
I was arguing against assuming that rename marks the inode dirty.
If rename does not mark the inode dirty, then fsync(file) may be optimized
away by filesystem and will not require persisting anything, without
breaking strictly ordered metadata semantics.


> >
> > Again, if your test can afford to do fsync of file and parent dir
> > it is best to be on the safe side (please audit other similar tests
> > that you know about). If your test cannot afford to fsync parent
> > dir, then at least a fat comment about this issue is worth about
> > the expected (but not guaranteed) effects of fsync of file.
>
> I'm sending a v2 with the fsync against the parent directory, despite
> not being needed for any fs I could
> run the tests against, because it's a generic test.

ACK.

Thanks,
Amir.
