Received: from mail-pf0-f195.google.com ([209.85.192.195]:35066 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdHPDkQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2017 23:40:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id j68so211579pfc.2
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2017 20:40:16 -0700 (PDT)
Date: Tue, 15 Aug 2017 20:40:13 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstest-bld PATCH 1/2] test-appliance: add safety check for
 "gen-image --out-tar"
Message-ID: <20170816034013.GB1417@zzz.localdomain>
References: <20170813173224.28900-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170813173224.28900-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 13, 2017 at 01:32:23PM -0400, Theodore Ts'o wrote:
> The gen-image script must not be run as root when generating a tar
> file.  This is because it uses fakechroot and fakeroot, and if run as
> root, the debootstrap script will end up damaging a large number of
> devices in the /dev directory.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  kvm-xfstests/test-appliance/gen-image | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
> index dbd9b84..e7bdb35 100755
> --- a/kvm-xfstests/test-appliance/gen-image
> +++ b/kvm-xfstests/test-appliance/gen-image
> @@ -76,6 +76,10 @@ fi
>  
>  if test -n "$OUT_TAR" ; then
>      if test "$FAKECHROOT" != "true" ; then
> +	if test "$EUID" -eq 0 ; then
> +	    echo "This script MUST NOT be run as root with --out_tar"
> +	    exit 1;
> +	fi
>  	set -- "${SAVE_ARGS[@]}"
>  	exec fakechroot $0 "$@"
>      fi
> -- 
> 2.11.0.rc0.7.gbe5a750

Reviewed-by: Eric Biggers <ebiggers@google.com>
