Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EECC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEF860C51
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 13:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJXOAP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 10:00:15 -0400
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:50210 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJXOAP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Oct 2021 10:00:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1045319|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.108627-0.00457303-0.8868;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Lh0Ap8W_1635083872;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lh0Ap8W_1635083872)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 24 Oct 2021 21:57:53 +0800
Date:   Sun, 24 Oct 2021 21:57:52 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] build: remove unused AC_PACKAGE_NEED_OPEN_BY_FSHANDLE
 macro
Message-ID: <YXVmYJdOHSRTB6wz@desktop>
References: <20211012135057.25689-1-ailiop@suse.com>
 <20211012153946.GH24282@magnolia>
 <YWW1esouYFRcbuHf@technoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWW1esouYFRcbuHf@technoir>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 12, 2021 at 06:19:06PM +0200, Anthony Iliopoulos wrote:
> On Tue, Oct 12, 2021 at 08:39:46AM -0700, Darrick J. Wong wrote:
> > On Tue, Oct 12, 2021 at 03:50:57PM +0200, Anthony Iliopoulos wrote:
> > > Commit 5868405dce1d ("Sync up different copies of the m4 macros, noop
> > > change for this package.") introduced this macro, by the function was
> > > never really used by any test, remove it.
> > 
> > If we're not going to keep this in sync (with what I have no idea) then
> > why not remove the other unused macros?
> 
> This was standing out as I was looking specifically into fstests
> dependencies to libhandle, but I didn't make a full pass through the
> rest. Indeed at least AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS seems also
> unused.
> 
> From looking at earlier commits, I think sync was referring to bringing
> the m4 macros up to date with the rest of the packages (xfsprogs,
> xfsdump at least). Commit c1ef92a938a1 ("Updates to QA scrdiff script to
> keep package configure macros in sync.") includes the following comment:

Wow, that was more than 18 years ago, and I don't think we've kept the
m4 files in sync after that.

So I tend to agree with Darrick that it'd be better to removing other
unused macros all together. And I did a quick search[1] and it looked like
the following macros are only defined but not used anywhere:

AC_HAVE_FADVISE
AC_HAVE_MADVISE
AC_HAVE_MINCORE
AC_HAVE_SENDFILE
AC_HAVE_GETMNTENT
AC_HAVE_GETMNTINFO
AC_PACKAGE_NEED_NCURSES_H
AC_PACKAGE_WANT_WORKING_LIBNCURSES
AC_PACKAGE_NEED_PTHREAD_H
AC_PACKAGE_NEED_PTHREADMUTEXINIT
AC_TYPE_PSINT
AC_TYPE_PSUNSIGNED
AC_SIZEOF_POINTERS_AND_LONG
AC_PACKAGE_NEED_UUID_H
AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS
AC_PACKAGE_NEED_OPEN_BY_FSHANDLE
AC_FUNC_GCC_VISIBILITY

Thanks,
Eryu

P.S.
[1] the script to do the search
for m in `git grep AC_DEFUN | grep -o AC_[PHTSF].*[A-Z]`; do
	cnt=`git grep $m | wc -l`
	if [ $cnt -lt 2 ]; then
		echo $m
	fi
done
> 
>   "xfstests directory m4 directory is a repository of all of the custom
>   m4 macros used in the packages we look after."
> 
> I just checked xfsdump and most of the macros in package_xfslibs.m4 are
> indeed unused.
> 
> Regards,
> Anthony
