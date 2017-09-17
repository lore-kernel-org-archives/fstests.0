Received: from mail-pg0-f46.google.com ([74.125.83.46]:51396 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdIQRIc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Sep 2017 13:08:32 -0400
Received: by mail-pg0-f46.google.com with SMTP id k193so3842376pgc.8
        for <fstests@vger.kernel.org>; Sun, 17 Sep 2017 10:08:32 -0700 (PDT)
Date: Sun, 17 Sep 2017 10:08:28 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] kvm-xfstests: use aio=native for test drives
Message-ID: <20170917170828.GA564@zzz.localdomain>
References: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <eguan@redhat.com>, Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 04, 2017 at 03:15:28PM +0300, Amir Goldstein wrote:
> Lost IOs have been observed with the default aio=threads with
> QEMU 2.5.0 when running crash consistency tests.
> The issue has not been observed with QEMU 2.9.0.
> Native AIO is probably better for our goal which is test proofing
> production systems.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just for reference, if you don't have CONFIG_AIO enabled in your kernel, QEMU
will segfault when passed aio=native (rather than falling back to aio=threads as
expected).  I guess that will need to be fixed as well...

Eric
