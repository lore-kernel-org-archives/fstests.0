Received: from mail-yw1-f67.google.com ([209.85.161.67]:33872 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEII7n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 May 2019 04:59:43 -0400
Received: by mail-yw1-f67.google.com with SMTP id n76so1307942ywd.1
        for <fstests@vger.kernel.org>; Thu, 09 May 2019 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com>
In-Reply-To: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2019 11:59:31 +0300
Message-ID: <CAOQ4uxjaBQR63pWY7+M9YD5qV3wBkeRBZxv7nW0AW==BR=nDjg@mail.gmail.com>
Subject: Re: [PATCH] generic/530: fix shutdown failure of generic/530 in overlay
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Chengguang Xu <cgxu519@gmx.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 9, 2019 at 8:29 AM Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> We got "shutdown: Inappropriate ioctl for device" when running
> "./check -overlay generic/530". The error message is due to the
> XFS_IOC_GOINGDOWN ioctl used in generic/530.
>
> Though _require_scratch_shutdown() is called to test whether the
> tested filesystem supports XFS_IOC_GOINGDOWN ioctl or not, a piece
> of C code snippet in src/t_open_tmpfiles.c is used to shutdown the
> filesysetm, rather than calling the corresponding helper function
> _scratch_shutdown().
>
> Let me explain it clearly:
>
> 1. suppose the config is
>
> ```
> export TEST_DEV=/dev/vdb
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/vdc
> export SCRATCH_MNT=/mnt/scratch
> ```
>
> 2. When running "./check -overlay generic/530", the scratch device,
> /dev/vdc is mounted on /mnt/scratch, and the overlay filesystem is
> mounted on /mnt/scratch/mnt using the follwing command
>
> ```
> mount -t overlay -o lowerdir=/mnt/scratch/ovl-lower \
> -o upperdir=/mnt/scratch/ovl-upper/ -o workdir=/mnt/scratch/ovl-work/ \
> overlay /mnt/scratch/ovl-mnt
> ```
>
> 3. In this case, _require_scratch_shutdown() will inspect whether the
> underlying upper system, that is **/mnt/scratch/**, supports shutdown
> feature or not. In my test, the underlying system of overlay (that is
> /dev/vdc) is ext4, and thus it passes the _require_scratch_shutdown
> test.
>
> 4. However, the C code executing the shutdown action in t_open_tmpfiles.c
> actually execute XFS_IOC_GOINGDOWN ioctl on the mount point of overlay
> filesystem, that is **/mnt/scratch/ovl-mnt**. Since overlay doesn't support
> XFS_IOC_GOINGDOWN ioctl, it fails naturally.
>
> 5. So we should use _scratch_shutdown() to shutdown if we have used
> _require_scratch_shutdown
>
> As for the solution to fix the failure, I temporarily move the shutdown
> action from t_open_tmpfiles into generic/530 as the workaround. How would
> you think @Darrick? Maybe there is a better solution but I'm not sure.
>

I think this is the correct solution (and not a workaround)
FWIW there are other operations (e.g. umount) when done directly and
not via common helpers would not have the same result when running
check -overlay.

I suggest that you remove the option 'shutdown' from t_open_tmpfiles
if shutdown can be done by test, so future tests won't use it.

There are 2 generic tests that use src/godown directly and not via
common shutdown helper. Those tests are skipped with -overlay due
to other unmet requirements, but as a general practice, using src/godown
directly should be avoided if possible.

Thanks,
Amir.
