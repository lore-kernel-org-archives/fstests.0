Received: from mail-pl0-f67.google.com ([209.85.160.67]:46775 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPWIk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 18:08:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id 59-v6so10789843plc.13
        for <fstests@vger.kernel.org>; Mon, 16 Apr 2018 15:08:39 -0700 (PDT)
Date: Mon, 16 Apr 2018 15:08:37 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH] gen-image: exclude packages for other
 architectures
Message-ID: <20180416220837.GD10051@gmail.com>
References: <20180404001512.81876-1-ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404001512.81876-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 03, 2018 at 05:15:12PM -0700, Eric Biggers wrote:
> Now that gen-image is run with '-e', it fails if the debs/ directory
> contains packages for multiple architectures.  Fix it by installing just
> the packages for the needed architecture or for "all" architectures.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kvm-xfstests/test-appliance/gen-image | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
> index 8d4bebb..2755cb5 100755
> --- a/kvm-xfstests/test-appliance/gen-image
> +++ b/kvm-xfstests/test-appliance/gen-image
> @@ -283,7 +283,8 @@ if test -f "backport-packages-$SUITE" ; then
>      fi
>      rm -rf "$ROOTDIR/debootstrap"
>  fi
> -DEBS=$(find debs -name \*.deb)
> +DEBIAN_ARCH="$(dpkg --print-architecture)"
> +DEBS="$(find debs -name "*_${DEBIAN_ARCH}.deb" -o -name "*_all.deb")"
>  if test -n "$DEBS"
>  then
>      run_in_chroot "dpkg --ignore-depends=e2fsprogs --auto-deconfigure -i $(echo $DEBS)"
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

Ping.
