Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeJ1XRq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 28 Oct 2018 19:17:46 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C3220664
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 14:32:59 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id 185so1406259vkv.13
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181027084858.1953-1-fdmanana@kernel.org> <20181028131921.GC3876@desktop>
In-Reply-To: <20181028131921.GC3876@desktop>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 28 Oct 2018 14:32:47 +0000
Message-ID: <CAL3q7H62=nZtfNbs5xjFPMfx1cjwVLwdE67XzamDrtmjdKab=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: add some tests to the 'log' group that use dmflakey
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 28, 2018 at 1:19 PM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Sat, Oct 27, 2018 at 09:48:58AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Some tests that use dmflakey to test filesystem consistency after a power
> > failure are in the 'log' group while others are not. So fix the
> > incosistency and put them all under the 'log' group.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/group   | 14 +++++++-------
> >  tests/generic/group | 48 ++++++++++++++++++++++++------------------------
> >  tests/shared/group  |  2 +-
> >  3 files changed, 32 insertions(+), 32 deletions(-)
> >  mode change 100644 => 100755 tests/btrfs/group
> >  mode change 100644 => 100755 tests/generic/group
>
> I assume the file mode changes are made by mistake, will fix the mode on
> commit.

Indeed, they are a mistake.
Thanks Eryu!

>
> Thanks,
> Eryu
