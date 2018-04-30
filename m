Received: from mail-pf0-f193.google.com ([209.85.192.193]:36990 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753482AbeD3TNq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Apr 2018 15:13:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id e9so3487578pfi.4
        for <fstests@vger.kernel.org>; Mon, 30 Apr 2018 12:13:46 -0700 (PDT)
Date: Mon, 30 Apr 2018 12:13:44 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH 1/2] test-appliance: fix specifying f2fs
 mount options in config file
Message-ID: <20180430191344.GA193968@gmail.com>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419205020.16868-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 19, 2018 at 01:50:19PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> setup_mount_opts() is supposed to prepend "-o " to the mount options,
> but it failed to do so in the case where mount options are specified in
> a config file rather than on the command line.  Fix it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> index b0c2196..94c402b 100644
> --- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> +++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
> @@ -31,12 +31,9 @@ function format_filesystem()
>  function setup_mount_opts()
>  {
>      if test -n "$MNTOPTS" ; then
> -	if test -n "$F2FS_MOUNT_OPTIONS" ; then
> -	    export F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
> -	else
> -	    export F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
> -	fi
> +	F2FS_MOUNT_OPTIONS+="${F2FS_MOUNT_OPTIONS:+,}$MNTOPTS"
>      fi
> +    export F2FS_MOUNT_OPTIONS="${F2FS_MOUNT_OPTIONS:+-o }$F2FS_MOUNT_OPTIONS"
>  }
>  
>  function get_mkfs_opts()
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

Ping.
