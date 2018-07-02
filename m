Received: from mail-pg0-f65.google.com ([74.125.83.65]:38609 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeGBITB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jul 2018 04:19:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so6797254pgf.5
        for <fstests@vger.kernel.org>; Mon, 02 Jul 2018 01:19:01 -0700 (PDT)
Date: Mon, 2 Jul 2018 16:18:56 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] build: fix possibly undefined macro:
 AC_PACKAGE_NEED_GETXATTR_LIBATTR
Message-ID: <20180702081856.GZ2780@desktop>
References: <20180702070001.1973-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702070001.1973-1-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com, yangx.jy@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 02, 2018 at 03:00:01PM +0800, Lu Fengqi wrote:
> Because the macro AC_PACKAGE_NEED_GETXATTR_LIBATTR was removed by
> the following commit specified by fixes tag, we also need remove
> AC_PACKAGE_NEED_GETXATTR_LIBATTR from configure.ac.
> 
> In addition, the libattr will not be set, after the macro was be
> removed. This cause gcc can't link the libattr for fsstress correctly.
> The macro AC_PACKAGE_NEED_ATTRGET_LIBATTR has been obsoleted, so change
> it to AC_PACKAGE_NEED_ATTRSET_LIBATTR and add it to configure.ac. It can
> help me check libattr and set libattr variable.
> 
> Fixes: 42b851446ff1 ("build: remove <attr/xattr.h> check")
> Reported-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
> ---
> Hi, Eryu
> 
> I apologize for the previous patch about the build infrastructure that
> caused the master branch to not be compiled.

That's my fault, I didn't test the latest patch but a stale one, your
original patch worked fine. Sorry about that!

> 
> Spoiler:
> Regarding the following deprecated functions, I want to replace them
> with the glibc version. And, I will carefully confirm the correctness
> before send patches. Any suggestions?
> 
> fsstress.c:762:2: warning: 'attr_list' is deprecated: Use listxattr or
> llistxattr instead [-Wdeprecated-declarations]
> fsstress.c:781:2: warning: 'attr_remove' is deprecated: Use removexattr
> or lremovexattr instead [-Wdeprecated-declarations]
> fsstress.c:801:2: warning: 'attr_set' is deprecated: Use setxattr or
> lsetxattr instead [-Wdeprecated-declarations]

IMHO, replacing the deprecated attr functions looks fine to me. But I'm
not sure if there's any historical reason behind this.

> 
>  configure.ac          | 2 +-
>  m4/package_attrdev.m4 | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 63ea032dc564..aede4f59a060 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -53,7 +53,7 @@ AC_PACKAGE_NEED_XFS_HANDLE_H
>  AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
>  AC_PACKAGE_NEED_ATTRIBUTES_H
>  AC_PACKAGE_WANT_ATTRLIST_LIBATTR
> -AC_PACKAGE_NEED_GETXATTR_LIBATTR
> +AC_PACKAGE_NEED_ATTRSET_LIBATTR
>  
>  AC_PACKAGE_NEED_SYS_ACL_H
>  AC_PACKAGE_NEED_ACL_LIBACL_H
> diff --git a/m4/package_attrdev.m4 b/m4/package_attrdev.m4
> index 9a82f241de3a..d994cfc23c25 100644
> --- a/m4/package_attrdev.m4
> +++ b/m4/package_attrdev.m4
> @@ -26,8 +26,8 @@ AC_DEFUN([AC_PACKAGE_WANT_ATTRLIST_LIBATTR],
>      AC_SUBST(have_attr_list)
>    ])
>  
> -AC_DEFUN([AC_PACKAGE_NEED_ATTRGET_LIBATTR],
> -  [ AC_CHECK_LIB(attr, attr_get,, [
> +AC_DEFUN([AC_PACKAGE_NEED_ATTRSET_LIBATTR],
> +  [ AC_CHECK_LIB(attr, attr_set,, [

Looks fine to me as a hotfix. Thanks!

Eryu

>          echo
>          echo 'FATAL ERROR: could not find a valid Extended Attributes library.'
>          echo 'Install the extended attributes (attr) development package.'
> -- 
> 2.18.0
> 
> 
> 
