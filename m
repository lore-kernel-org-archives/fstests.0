Received: from mail-yw1-f67.google.com ([209.85.161.67]:40525 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIJHk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 May 2019 05:07:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so1290948ywe.7
        for <fstests@vger.kernel.org>; Thu, 09 May 2019 02:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <1557379616-13850-1-git-send-email-jefflexu@linux.alibaba.com> <20190509054435.GG5352@magnolia>
In-Reply-To: <20190509054435.GG5352@magnolia>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2019 12:07:28 +0300
Message-ID: <CAOQ4uxj+tc9ed7GxnLbrf9hBq4kMVK_Fwoec10uMGX2yBAZLEg@mail.gmail.com>
Subject: Re: [PATCH] generic/530: fix shutdown failure of generic/530 in overlay
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Chengguang Xu <cgxu519@gmx.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 9, 2019 at 8:45 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, May 09, 2019 at 01:26:56PM +0800, Jeffle Xu wrote:
> > We got "shutdown: Inappropriate ioctl for device" when running
> > "./check -overlay generic/530". The error message is due to the
> > XFS_IOC_GOINGDOWN ioctl used in generic/530.
> >
> > Though _require_scratch_shutdown() is called to test whether the
> > tested filesystem supports XFS_IOC_GOINGDOWN ioctl or not, a piece
> > of C code snippet in src/t_open_tmpfiles.c is used to shutdown the
> > filesysetm, rather than calling the corresponding helper function
> > _scratch_shutdown().
> >
> > Let me explain it clearly:
> >
> > 1. suppose the config is
> >
> > ```
> > export TEST_DEV=/dev/vdb
> > export TEST_DIR=/mnt/test
> > export SCRATCH_DEV=/dev/vdc
> > export SCRATCH_MNT=/mnt/scratch
> > ```
> >
> > 2. When running "./check -overlay generic/530", the scratch device,
> > /dev/vdc is mounted on /mnt/scratch, and the overlay filesystem is
> > mounted on /mnt/scratch/mnt using the follwing command
> >
> > ```
> > mount -t overlay -o lowerdir=/mnt/scratch/ovl-lower \
> > -o upperdir=/mnt/scratch/ovl-upper/ -o workdir=/mnt/scratch/ovl-work/ \
> > overlay /mnt/scratch/ovl-mnt
> > ```
> >
> > 3. In this case, _require_scratch_shutdown() will inspect whether the
> > underlying upper system, that is **/mnt/scratch/**, supports shutdown
> > feature or not. In my test, the underlying system of overlay (that is
> > /dev/vdc) is ext4, and thus it passes the _require_scratch_shutdown
> > test.
> >
> > 4. However, the C code executing the shutdown action in t_open_tmpfiles.c
> > actually execute XFS_IOC_GOINGDOWN ioctl on the mount point of overlay
> > filesystem, that is **/mnt/scratch/ovl-mnt**. Since overlay doesn't support
> > XFS_IOC_GOINGDOWN ioctl, it fails naturally.
> >
> > 5. So we should use _scratch_shutdown() to shutdown if we have used
> > _require_scratch_shutdown
> >
> > As for the solution to fix the failure, I temporarily move the shutdown
> > action from t_open_tmpfiles into generic/530 as the workaround. How would
> > you think @Darrick? Maybe there is a better solution but I'm not sure.
>
> *OH*, it escaped my notice that _require_scratch_shutdown tests shutting
> down the legs that overlayfs stands on, without testing the overlayfs
> mount itself.  Sorry about that, and thanks for pointing that out.
>
> Hmm, well, this test is really about creating a bunch of temp files on
> SCRATCH_MNT and then shutting down the *SCRATCH_MNT* to see how it deals
> with that.  I'm not sure why the _require helper special-cases overlayfs
> to test something other than SCRATCH_MNT, so I think we (or I) need
> clarification about why the helper does that, or possibly just a new
> _require helper that actually checks SCRATCH_MNT itself.
>

The helper is doing the right thing as far as the tests that use the common
shutdown helpers are concerned.
When you yank the cord out of underlying fs, you effectively yank the cord
out of overlayfs, so shutdown tests can be run on overlay thanks to the fixes
made by Chengguang, helping with crash test coverage for overlayfs.

>From quick grep I found only 3 generic tests that issue goingdown via
binaries and not via common helper. This patch fixes one of them and the
other 2 tests (using src/godown) do not run on overlays, so it is low
priority to fix them.

Cheers,
Amir.
