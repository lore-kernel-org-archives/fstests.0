Received: from mail-it0-f65.google.com ([209.85.214.65]:52876 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964954AbeBMOPa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Feb 2018 09:15:30 -0500
Received: by mail-it0-f65.google.com with SMTP id o13so11244930ito.2
        for <fstests@vger.kernel.org>; Tue, 13 Feb 2018 06:15:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213091203.22909-1-eguan@redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 13 Feb 2018 15:15:28 +0100
Message-ID: <CAHc6FU5ersubjo5-F0k6-A2KWEWYyci54eRSeRSL67SUXCeg0g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] _fail test by default if _scratch_mount fails
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

 On 13 February 2018 at 10:12, Eryu Guan <eguan@redhat.com> wrote:
> Hi all,
>
> This is an RFC patchset that follows Andreas Gruenbacher's recent post
> "Failing scratch mounts"[1]. It changes _scratch_mount to call _fail on
> mount failure by default, so that when the mount fails, the tests won't
> write to the underlying filesystem and fail in implicit way, which
> sometimes makes debugging harder to do.
>
> Also introduce a new _scratch_mount_nocheck helper, which mount scratch
> device and doesn't check the mount status, for tests that need to check
> mount status themselves.
>
> This two-patch patchset should really be one patch, but for easy review,
> I split the patch into two pieces, the first patch introduce the new
> _scratch_mount_nocheck helper and converts _scratch_mount usages in
> common dir, the second patch converts all the tests (which can be
> tedious).
>
> I've tested it by running full '-g auto' tests against xfs/xfs with
> reflink/ext4/btrfs and I didn't see any new failures.
>
> (Note that I based this patchset against fstests release on Feb. 4th, so
> I didn't convert the new tests release on Feb. 11th. And as this is an
> RFC, I didn't write detailed commit log in each patch.)

These patches do fix the scratch mount problems I've been seeing on gfs2.

Thanks,
Andreas
