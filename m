Received: from mail-pl0-f67.google.com ([209.85.160.67]:40652 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeF2GqI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Jun 2018 02:46:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so3991511plo.7
        for <fstests@vger.kernel.org>; Thu, 28 Jun 2018 23:46:08 -0700 (PDT)
Date: Fri, 29 Jun 2018 14:46:02 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 3/3] build: remove <attr/xattr.h> check
Message-ID: <20180629064602.GV2780@desktop>
References: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
 <20180627101854.13158-4-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627101854.13158-4-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 06:18:54PM +0800, Lu Fengqi wrote:
> Since fsstress and src/t_immutable don't need attr/xattr.h, just remove
> <attr/xattr.h> check.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
> ---
>  configure.ac          |  1 -
>  m4/package_attrdev.m4 | 11 -----------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 57092f1c484b..63ea032dc564 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -51,7 +51,6 @@ AC_PACKAGE_NEED_XFSCTL_MACRO
>  AC_PACKAGE_NEED_XFS_HANDLE_H
>  
>  AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
> -AC_PACKAGE_NEED_ATTR_XATTR_H
>  AC_PACKAGE_NEED_ATTRIBUTES_H
>  AC_PACKAGE_WANT_ATTRLIST_LIBATTR
>  AC_PACKAGE_NEED_GETXATTR_LIBATTR
> diff --git a/m4/package_attrdev.m4 b/m4/package_attrdev.m4
> index 12251ceb63c3..6bf21b1799e5 100644
> --- a/m4/package_attrdev.m4
> +++ b/m4/package_attrdev.m4
> @@ -1,14 +1,3 @@
> -AC_DEFUN([AC_PACKAGE_NEED_ATTR_XATTR_H],
> -  [ AC_CHECK_HEADERS([attr/xattr.h])
> -    if test "$ac_cv_header_attr_xattr_h" != "yes"; then
> -        echo
> -        echo 'FATAL ERROR: attr/xattr.h does not exist.'
> -        echo 'Install the extended attributes (attr) development package.'
> -        echo 'Alternatively, run "make install-dev" from the attr source.'
> -        exit 1
> -    fi
> -  ])
> -

Looks like we could remove the check for getxattr too.

AC_DEFUN([AC_PACKAGE_NEED_GETXATTR_LIBATTR],
...

Thanks,
Eryu

>  AC_DEFUN([AC_PACKAGE_NEED_ATTR_ERROR_H],
>    [ AC_CHECK_HEADERS([attr/error_context.h])
>      if test "$ac_cv_header_attr_error_context_h" != "yes"; then
> -- 
> 2.18.0
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
