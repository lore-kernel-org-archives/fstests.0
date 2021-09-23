Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE1FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15156124E
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhIWTsm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242885AbhIWTsm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Sep 2021 15:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A814A60F6F;
        Thu, 23 Sep 2021 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426430;
        bh=feVTZqQ7voDFHj1H/8tEvXqXxEW/Vz8029BLRnzAD68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwW81AaAX0ehwTffpCjWgvHRnC7X9Tf+UXvFP9kQLAncRlPz1pdoOPjNyGqXHV/Hv
         WQtPk/IHVDA+BRj+N+o1rgNuXuG1bpzSp2tfpJFKbVXf+5mTl1yUjQxul2NBVdHxJj
         mn9xsjsYqqSxNSul+yBaTclJg7Vp/SBdR6RRjjD8XvDo9jCWky1CCBwlFFMO07v/8j
         WBR1MRW90BjYpy9U5CER8XkxWQaI3UC0w/UOS3+mEUBqTPb249MShXlr8hybnQAbQy
         cjg+YQ0xiC7GMvc9J9IulXYLcXY3tdxHqQLLTKTNEvqrfmONdos8txOzwB/JHnLtyf
         AsXm3eugv1zeg==
Date:   Thu, 23 Sep 2021 12:47:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/2] common/rc: add _require_user_exists() to check if a
 user exists
Message-ID: <20210923194710.GA570597@magnolia>
References: <20210923104123.29878-1-lhenriques@suse.de>
 <20210923104123.29878-2-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923104123.29878-2-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 23, 2021 at 11:41:22AM +0100, Luis Henriques wrote:
> Function _require_user() does check if a user exists *and* if it is able
> to execute commands.  Add a new function to simply check if a user exists.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Looks like a simple enough hoist.

You /could/ streamline the bash constructs too, but ... fmeh.  This is
easy to review, at least.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 154bc2dd7e94..c7e77c0e26dc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2289,18 +2289,27 @@ _cat_group()
>  	cat /etc/group
>  }
>  
> -# check for a user on the machine, fsgqa as default
> +# check if a user exists in the system
> +#
> +_require_user_exists()
> +{
> +	user=$1
> +	_cat_passwd | grep -q $user
> +	[ "$?" == "0" ] || _notrun "$user user not defined."
> +}
> +
> +# check if a user exists and is able to execute commands.
> +# Uses 'fsgqa' user as default.
>  #
>  _require_user()
>  {
> -    qa_user=fsgqa
> -    if [ -n "$1" ];then
> -        qa_user=$1
> -    fi
> -    _cat_passwd | grep -q $qa_user
> -    [ "$?" == "0" ] || _notrun "$qa_user user not defined."
> -    echo /bin/true | su $qa_user
> -    [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
> +	qa_user=fsgqa
> +	if [ -n "$1" ];then
> +		qa_user=$1
> +	fi
> +	_require_user_exists $qa_user
> +	echo /bin/true | su $qa_user
> +	[ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
>  # check for a chown support
