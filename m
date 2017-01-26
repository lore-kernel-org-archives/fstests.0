Received: from mx1.redhat.com ([209.132.183.28]:49990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdAZFOv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Jan 2017 00:14:51 -0500
Date: Thu, 26 Jan 2017 13:14:49 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: xfstest and chromeos
Message-ID: <20170126051449.GO1859@eguan.usersys.redhat.com>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org, Mike Frysinger <vapier@chromium.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
> I am adding xfstest to chromeos test image, to improve chromeos
> filesystems test coverage.
> Doing so, I encountered to issues, documented in
> https://chromium-review.googlesource.com/#/c/424372
> and
> https://chromium-review.googlesource.com/#/c/424191
> 
> https://chromium-review.googlesource.com/#/c/424372
> - To circuvent SELinux protection we add a mount context option,
> requesting to use nfs_t context. However on chromeos, we have no nfs
> security context - we are not expecting usings nfs - leading to a
> mount error. Shall we try to use another context or check beforehand
> if a context is needed for mount?

The selinux context is there because without it some quota or xattr
tests will fail due to extra xattr set by selinux.

I'm not sure what context works for chromeos, but I think we can make
SELINUX_MOUNT_OPTIONS configurable, and it defaults to current value. So
that chromeos could use any context that works for it.

> 
> https://chromium-review.googlesource.com/#/c/424191
> - Chromeos needs libtool to (cross-)compile packages and put them at
> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
> Does it make sense to require aclocal to run to compile xfstests?

Sorry, I'm not that familiar with all the autotools build system.. I may
need some time to look into it. Or someone else who is familiar with it
could provide some inputs here?

Thanks,
Eryu
