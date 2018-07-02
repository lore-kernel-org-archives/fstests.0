Received: from mail.cn.fujitsu.com ([183.91.158.132]:17402 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752962AbeGBBYG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jul 2018 21:24:06 -0400
Date: Mon, 2 Jul 2018 09:23:54 +0800
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/3] build: remove <attr/xattr.h> check
Message-ID: <20180702012353.GB557@fnst.localdomain>
References: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
 <20180627101854.13158-4-lufq.fnst@cn.fujitsu.com>
 <20180629064602.GV2780@desktop>
 <20180629075026.GA557@fnst.localdomain>
 <20180630040211.GW2780@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180630040211.GW2780@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jun 30, 2018 at 12:02:11PM +0800, Eryu Guan wrote:
>On Fri, Jun 29, 2018 at 03:50:26PM +0800, Lu Fengqi wrote:
>> On Fri, Jun 29, 2018 at 02:46:02PM +0800, Eryu Guan wrote:
>> >On Wed, Jun 27, 2018 at 06:18:54PM +0800, Lu Fengqi wrote:
>> >> Since fsstress and src/t_immutable don't need attr/xattr.h, just remove
>> >> <attr/xattr.h> check.
>> >> 
>> >> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
>> >> ---
>> >>  configure.ac          |  1 -
>> >>  m4/package_attrdev.m4 | 11 -----------
>> >>  2 files changed, 12 deletions(-)
>> >> 
>> >> diff --git a/configure.ac b/configure.ac
>> >> index 57092f1c484b..63ea032dc564 100644
>> >> --- a/configure.ac
>> >> +++ b/configure.ac
>> >> @@ -51,7 +51,6 @@ AC_PACKAGE_NEED_XFSCTL_MACRO
>> >>  AC_PACKAGE_NEED_XFS_HANDLE_H
>> >>  
>> >>  AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
>> >> -AC_PACKAGE_NEED_ATTR_XATTR_H
>> >>  AC_PACKAGE_NEED_ATTRIBUTES_H
>> >>  AC_PACKAGE_WANT_ATTRLIST_LIBATTR
>> >>  AC_PACKAGE_NEED_GETXATTR_LIBATTR
>> >> diff --git a/m4/package_attrdev.m4 b/m4/package_attrdev.m4
>> >> index 12251ceb63c3..6bf21b1799e5 100644
>> >> --- a/m4/package_attrdev.m4
>> >> +++ b/m4/package_attrdev.m4
>> >> @@ -1,14 +1,3 @@
>> >> -AC_DEFUN([AC_PACKAGE_NEED_ATTR_XATTR_H],
>> >> -  [ AC_CHECK_HEADERS([attr/xattr.h])
>> >> -    if test "$ac_cv_header_attr_xattr_h" != "yes"; then
>> >> -        echo
>> >> -        echo 'FATAL ERROR: attr/xattr.h does not exist.'
>> >> -        echo 'Install the extended attributes (attr) development package.'
>> >> -        echo 'Alternatively, run "make install-dev" from the attr source.'
>> >> -        exit 1
>> >> -    fi
>> >> -  ])
>> >> -
>> >
>> >Looks like we could remove the check for getxattr too.
>> >
>> >AC_DEFUN([AC_PACKAGE_NEED_GETXATTR_LIBATTR],
>> >...
>> 
>> You're right. I will resend the patch.
>
>It's a straightforward change, I can fix it on commit, no need to resend :)

Sorry, but I have to say we have missed AC_PACKAGE_NEED_GETXATTR_LIBATTR
in configure.ac. So need I send a separate fix to remove it?

-- 
Thanks,
Lu

>
>Thanks,
>Eryu
>
>> 
>> -- 
>> Thanks,
>> Lu
>> 
>> >
>> >Thanks,
>> >Eryu
>> >
>> >>  AC_DEFUN([AC_PACKAGE_NEED_ATTR_ERROR_H],
>> >>    [ AC_CHECK_HEADERS([attr/error_context.h])
>> >>      if test "$ac_cv_header_attr_error_context_h" != "yes"; then
>> >> -- 
>> >> 2.18.0
>> >> 
>> >> 
>> >> 
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>> 
>> 
>
>


