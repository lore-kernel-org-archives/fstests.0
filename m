Received: from mail-pf0-f195.google.com ([209.85.192.195]:38038 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDPMg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 11:12:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id o76so17672199pfi.5
        for <fstests@vger.kernel.org>; Fri, 04 May 2018 08:12:36 -0700 (PDT)
Date: Fri, 4 May 2018 23:12:32 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] Use the original install-sh file from SGI
Message-ID: <20180504151232.GD8373@desktop>
References: <20180503050728.25779-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503050728.25779-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 03, 2018 at 01:07:28AM -0400, Theodore Ts'o wrote:
> The install-sh file is much more efficient than the libtool version
> (50% faster wall clock time; much more than that when running in a
> qemu emulation build environment).  There doesn't seem to be any real
> need for the libtool version, so bring back the original install-sh
> script.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> A very large amount of time when running "make install" in a build
> chroot using qemu emulation, such as constructed by running "sudo
> setup-buildchroot --arch-armhf" using the script found here[1] is in
> running the install-sh provided by libtool, which is amazing bloated
> and forks a crazy number of processes to do something very simple.
> 
> As near as I can tell there is zero benefit in using the install-sh
> provided by libtool, so restore the version that SGI originally used.

This saves me 8s on 'make install' (23s -> 15s).

But one problem with this is that after every 'make', install-sh is
overwritten & modified by 'libtoolize -cfi', and git diff complains
about the change.

I think we could follow what xfsprogs does on this, that puts install-sh
in include dir and copy it from there after it's overwritten by
libtoolize.

> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/setup-buildchroot
> 
> 
>  .gitignore |   1 -
>  install-sh | 351 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100755 install-sh
> 
> diff --git a/.gitignore b/.gitignore
> index 192ca35e..dfd3da7d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -24,7 +24,6 @@
>  
>  # libtool
>  /libtool
> -/install-sh

Then we don't need this change.

So the patch would be like:

diff --git a/Makefile b/Makefile
index d97385f90142..1064984573be 100644
--- a/Makefile
+++ b/Makefile
@@ -80,6 +80,7 @@ endif
 
 configure: configure.ac
        libtoolize -cfi
+       cp include/install-sh .
        aclocal -I m4
        autoheader
        autoconf
diff --git a/include/install-sh b/include/install-sh
new file mode 100755
index 000000000000..06d8aa9b6b9c
--- /dev/null
+++ b/include/install-sh
<new file content here>

This looks like a straightforward change, I can fix it on commit if the
change looks sane to you.

Thanks,
Eryu
