Received: from mail-pg0-f65.google.com ([74.125.83.65]:40775 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPWIF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 18:08:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id e9so3355818pgr.7
        for <fstests@vger.kernel.org>; Mon, 16 Apr 2018 15:08:05 -0700 (PDT)
Date: Mon, 16 Apr 2018 15:08:03 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH] gen-image: fix running in a foreign build
 chroot
Message-ID: <20180416220803.GC10051@gmail.com>
References: <20180404001421.81698-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404001421.81698-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 03, 2018 at 05:14:21PM -0700, Eric Biggers wrote:
> Building an android-xfstests test appliance on x86_64 with the
> documented command (e.g. './do-all --chroot=stretch-arm64 --out-tar') no
> longer works.  The problem is that when the gen-image script is run in a
> foreign build chroot, it incorrectly considers the root_fs's chroot to
> be a "native" chroot and doesn't copy the needed /usr/bin/qemu-*-static
> binary into it.  This is because both 'uname -m' and 'dpkg
> --print-architecture' will return the same architecture (the foreign
> one), so is_native_chroot() returns true.
> 
> This did used to work, but I think it stopped working with 5c76a88c0e57
> ("test-appliance: improve image generation for chroot tar files")
> because previously it was using 'fakechroot' which doesn't actually
> change the real root directory, so the /usr/bin directory stayed the
> same from the kernel's perspective.  But now it uses real chroot.
> 
> Fix this by detecting a foreign build chroot by instead mounting
> binfmt_misc and checking whether there is an entry for qemu-$(uname -m).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kvm-xfstests/test-appliance/gen-image | 58 +++++++++++++++------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 

Ping.
