Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A96C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D98610C7
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhJLPlt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237462AbhJLPlt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Oct 2021 11:41:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40E8061076;
        Tue, 12 Oct 2021 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634053187;
        bh=Uqlc5XT4ijx2OIz5wyqOq86obzkWkVgTsaE/DXwd/zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQhwwL+WtNeLDCl6IzWUKakiDh8d09+dZaA+LUu2zllcAG1lOelI0ejMNwAaiHEZC
         Tt8JeEiM3L9C2djtslu+UkN69JAjNEXZ++mTZYxyB0XekyfARHsDdeO2p7JdXd2tga
         QRVKR4RAiXbf7lWkUhI5sFedVppIEbmOEaLD8zyjjwS1s/71UthzELotFANLywBG4y
         1cZg1BBw4f4RwRhSV0DBrOU3FefM38eJzpeDloVoUDSLngXe5SKmaoIJG8QOVjgmGa
         x3V0MS4kKe/YdVfT2idCZLyzTHjLnnrSDseCgZOa7TRpJqfK70ckS2+DPdgFPw+7m6
         uaqzntxqYi/XQ==
Date:   Tue, 12 Oct 2021 08:39:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] build: remove unused AC_PACKAGE_NEED_OPEN_BY_FSHANDLE
 macro
Message-ID: <20211012153946.GH24282@magnolia>
References: <20211012135057.25689-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012135057.25689-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 12, 2021 at 03:50:57PM +0200, Anthony Iliopoulos wrote:
> Commit 5868405dce1d ("Sync up different copies of the m4 macros, noop
> change for this package.") introduced this macro, by the function was
> never really used by any test, remove it.

If we're not going to keep this in sync (with what I have no idea) then
why not remove the other unused macros?

--D

> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  m4/package_xfslibs.m4 | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/m4/package_xfslibs.m4 b/m4/package_xfslibs.m4
> index 9be56e1103ac..1bfd955479b8 100644
> --- a/m4/package_xfslibs.m4
> +++ b/m4/package_xfslibs.m4
> @@ -64,20 +64,6 @@ AC_DEFUN([AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS],
>      AC_SUBST(libxfs)
>    ])
>  
> -AC_DEFUN([AC_PACKAGE_NEED_OPEN_BY_FSHANDLE],
> -  [ AC_CHECK_LIB(handle, open_by_fshandle,, [
> -        echo
> -        echo 'FATAL ERROR: could not find a current XFS handle library.'
> -        echo 'Install or upgrade the XFS library package.'
> -        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
> -        exit 1
> -    ])
> -    libhdl="-lhandle"
> -    test -f ${libexecdir}${libdirsuffix}/libhandle.la && \
> -	libhdl="${libexecdir}${libdirsuffix}/libhandle.la"
> -    AC_SUBST(libhdl)
> -  ])
> -
>  AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
>    [ AC_CHECK_LIB(handle, attr_list_by_handle,, [
>          echo
> -- 
> 2.33.0
> 
