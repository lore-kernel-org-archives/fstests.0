Received: from mail-it0-f43.google.com ([209.85.214.43]:37574 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeBUK1C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Feb 2018 05:27:02 -0500
Received: by mail-it0-f43.google.com with SMTP id d10so1715996itj.2
        for <fstests@vger.kernel.org>; Wed, 21 Feb 2018 02:27:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180218124457.28597-1-eguan@redhat.com>
References: <20180218124457.28597-1-eguan@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 21 Feb 2018 11:27:01 +0100
Message-ID: <CAHc6FU46AetuDG42ymogfPwz2j5j60Fw=urxd14wcfyaWb+9fw@mail.gmail.com>
Subject: Re: [PATCH] fstests: _fail test by default when _scratch_mount fails
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On 18 February 2018 at 13:44, Eryu Guan <eguan@redhat.com> wrote:
> Previously _scratch_mount didn't check the mount status and most
> tests continue to run even if the mount failed (unless test checks
> for the mount status explicitly). This would result in running tests
> on the underlying filesystem (usually rootfs) and implicit test
> failures, and such failures can be annoying and are usually hard to
> debug.
>
> Now _fail test by default if _scratch_mount failed and introduce
> _try_scratch_mount for tests that need to check mount results
> themselves. Also introduce a new _try_scratch_mount helper that does
> scratch mount without checking mount status for tests that do the
> check themselves.

The message above doesn't look quite right, but the patch looks good.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas
