Received: from mail-yb1-f193.google.com ([209.85.219.193]:37494 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeJRMnW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Oct 2018 08:43:22 -0400
Received: by mail-yb1-f193.google.com with SMTP id h1-v6so11336931ybm.4
        for <fstests@vger.kernel.org>; Wed, 17 Oct 2018 21:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-3-yi.zhang@huawei.com>
 <CAOQ4uxhJRxMqMzMn_zm+1LyaAUuRmMmr=YNPshX7U2MAUTtmYw@mail.gmail.com> <c3b4ba3b-001d-ad70-445f-f0c1ce5d17f0@huawei.com>
In-Reply-To: <c3b4ba3b-001d-ad70-445f-f0c1ce5d17f0@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Oct 2018 07:44:07 +0300
Message-ID: <CAOQ4uxgZCWFR5qr-6z4DH=UrtqX+Q2aY=XiX2bEpFNpeDvN2OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: fix exit code for some fsck.overlay valid cases
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 18, 2018 at 6:43 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> On 2018/10/16 17:26, Amir Goldstein Wrote:
> > On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrot=
e:
> >>
> >> Some valid test cases about fsck.overlay may be not valid enough now,
> >> they lose the impure xattr on the parent directory of the simluated
> >> redirect directory, and lose the whiteout which use to cover the origi=
n
> >> lower object. Then fsck.overlay will fix these two inconsistency which
> >> are not those test cases want to cover, thus it will lead to
> >> fsck.overlay return FSCK_NONDESTRUCT instead of FSCK_OK. Fix these by
> >> complement the missing overlay related features.
> >>
> >> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> >> ---
> >
> > Ok. I think it's fine if we merge this fix now, but this way it is goin=
g
> > to be quite hard to maintain this test.
> >
> > Imagine every time that you add another feature to fsck.overlay,
> > say "add overlay features xattr", fsck will start returning FSCK_NONDES=
TRUCT
> > and break this test.
> >
> > Perhaps it would have been better to construct the test cases by:
> > - mount overlay
> > - create some copied up/ redirected  dirs and whiteouts
> > - umount overlay
> > - make minor modifications to upper/lower layer
> > - run fsck
> >
> > Then you wouldn't need to worry about things like impure parent dir
> > and future overlay features.
> >
> > I will leave it to you to decide if you want to fix this now or the
> > next time around...
> >
>
> Indeed, I thought about this choice. If we create overlay on-disk feature=
s
> (xattrs=EF=BC=8Cwhiteouts...) through overlayfs, the fsck tests results b=
ecomes
> non-independent. It will depends on the kernel (overlayfs module) user ar=
e
> running the test. Imaging if user want to test the latest fsck.overlay
> on the old kernel which contains a compatible feature xattr fsck.overlay
> know but the kernel don't, we will get the unexpected result. Or maybe
> we can add some _require_xxx_feature() helper to enforce user doing test
> on the kernel which supports the specified feature?
>

I think the only sane choice is for this test to relax the expectation of 0
exit code to "correct" exit code (i.e. _overlay_repair_dirs()) for the "Val=
id"
test cases.

Maybe the only fsck run that we are fine with expecting 0 exit code is
-n run. As you can see this is common practice for e2fsck:
e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not =
fail"

Thanks,
Amir.
