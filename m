Received: from imap.thunk.org ([74.207.234.97]:50762 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdJAVE2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Oct 2017 17:04:28 -0400
Date: Sun, 1 Oct 2017 17:04:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] kernel-configs: enable namespace support
Message-ID: <20171001210424.3fd3wltac427vrrl@thunk.org>
References: <1506682417-8701-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506682417-8701-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>, Eryu Guan <eguan@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 29, 2017 at 01:53:37PM +0300, Amir Goldstein wrote:
> At this time there is only one xfstest that requires namespaces
> support (overlay/020) and it requires user namespace support.
> This test fails with default kvm-xfstests configs.
> 
> Recently, a regression with overlayfs was reported relating
> to mount ns, so tests that require only mount ns may be needed too.
> 
> This change re-enables the kernel default namespace support for all
> kernel configurations and enables user ns support for stable kernels
> v3.18 and above, where user ns is considered stable and maintained.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks, applied.

					- Ted
