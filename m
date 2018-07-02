Received: from mail-wm0-f66.google.com ([74.125.82.66]:50232 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeGBFF4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jul 2018 01:05:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so6522964wmc.0
        for <fstests@vger.kernel.org>; Sun, 01 Jul 2018 22:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
 <20180627101854.13158-4-lufq.fnst@cn.fujitsu.com> <20180629064602.GV2780@desktop>
 <20180629075026.GA557@fnst.localdomain> <20180630040211.GW2780@desktop>
 <20180702012353.GB557@fnst.localdomain> <5B3996F6.4000208@cn.fujitsu.com>
In-Reply-To: <5B3996F6.4000208@cn.fujitsu.com>
From: Lu Fengqi <curiouslfq@gmail.com>
Date: Mon, 2 Jul 2018 13:05:43 +0800
Message-ID: <CALS+E5DOsL7xVvcKM+UnupkOL2TNGWNW2jf0tdy2fHn0+G7zGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] build: remove <attr/xattr.h> check
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: yangx.jy@cn.fujitsu.com
Cc: lufq.fnst@cn.fujitsu.com, guaneryu@gmail.com, fstests@vger.kernel.org, zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

Xiao Yang <yangx.jy@cn.fujitsu.com> =E4=BA=8E2018=E5=B9=B47=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2018/07/02 9:23, Lu Fengqi wrote:
> > On Sat, Jun 30, 2018 at 12:02:11PM +0800, Eryu Guan wrote:
> >> On Fri, Jun 29, 2018 at 03:50:26PM +0800, Lu Fengqi wrote:
> >>> On Fri, Jun 29, 2018 at 02:46:02PM +0800, Eryu Guan wrote:
> >>>> On Wed, Jun 27, 2018 at 06:18:54PM +0800, Lu Fengqi wrote:
> >>>>> Since fsstress and src/t_immutable don't need attr/xattr.h, just re=
move
> >>>>> <attr/xattr.h>  check.
> >>>>>
> >>>>> Signed-off-by: Lu Fengqi<lufq.fnst@cn.fujitsu.com>
> >>>>> ---
> >>>>>   configure.ac          |  1 -
> >>>>>   m4/package_attrdev.m4 | 11 -----------
> >>>>>   2 files changed, 12 deletions(-)
> >>>>>
> >>>>> diff --git a/configure.ac b/configure.ac
> >>>>> index 57092f1c484b..63ea032dc564 100644
> >>>>> --- a/configure.ac
> >>>>> +++ b/configure.ac
> >>>>> @@ -51,7 +51,6 @@ AC_PACKAGE_NEED_XFSCTL_MACRO
> >>>>>   AC_PACKAGE_NEED_XFS_HANDLE_H
> >>>>>
> >>>>>   AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
> >>>>> -AC_PACKAGE_NEED_ATTR_XATTR_H
> >>>>>   AC_PACKAGE_NEED_ATTRIBUTES_H
> >>>>>   AC_PACKAGE_WANT_ATTRLIST_LIBATTR
> >>>>>   AC_PACKAGE_NEED_GETXATTR_LIBATTR
> >>>>> diff --git a/m4/package_attrdev.m4 b/m4/package_attrdev.m4
> >>>>> index 12251ceb63c3..6bf21b1799e5 100644
> >>>>> --- a/m4/package_attrdev.m4
> >>>>> +++ b/m4/package_attrdev.m4
> >>>>> @@ -1,14 +1,3 @@
> >>>>> -AC_DEFUN([AC_PACKAGE_NEED_ATTR_XATTR_H],
> >>>>> -  [ AC_CHECK_HEADERS([attr/xattr.h])
> >>>>> -    if test "$ac_cv_header_attr_xattr_h" !=3D "yes"; then
> >>>>> -        echo
> >>>>> -        echo 'FATAL ERROR: attr/xattr.h does not exist.'
> >>>>> -        echo 'Install the extended attributes (attr) development p=
ackage.'
> >>>>> -        echo 'Alternatively, run "make install-dev" from the attr =
source.'
> >>>>> -        exit 1
> >>>>> -    fi
> >>>>> -  ])
> >>>>> -
> >>>> Looks like we could remove the check for getxattr too.
> >>>>
> >>>> AC_DEFUN([AC_PACKAGE_NEED_GETXATTR_LIBATTR],
> >>>> ...
> >>> You're right. I will resend the patch.
> >> It's a straightforward change, I can fix it on commit, no need to rese=
nd :)
> > Sorry, but I have to say we have missed AC_PACKAGE_NEED_GETXATTR_LIBATT=
R
> > in configure.ac. So need I send a separate fix to remove it?
> Hi FengQi, Eryu
>
> Building src/ and ltp/ still failed  due to undefined LIBATTR variable
> even if we remove
> AC_PACKAGE_NEED_GETXATTR_LIBATTR  from configure.ac.
>
>   AC_PACKAGE_NEED_GETXATTR_LIBATTR is to check if attr library instead
> of getxattr is available,
> and building src/ and ltp/ depends on attr library.
>
> It is sane to keep this
> function(AC_DEFUN([AC_PACKAGE_NEED_GETXATTR_LIBATTR]).
>

I also found this problem, so we do need to set LIBATTR. Since getxattr is =
no
longer owned by libattr, we still should remove
AC_PACKAGE_NEED_GETXATTR_LIBATTR. However, we can check the function
provided by libattr(such as attr_set, attr_remove...) to determine whether =
to
set LIBATTR. Patch is coming.

-------------------------------------------------------------
Thanks,
Lu

> Thanks,
> Xiao Yang
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
