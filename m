Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50EC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726FD6124D
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhIWTyj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242954AbhIWTyj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Sep 2021 15:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 757BC61107;
        Thu, 23 Sep 2021 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426787;
        bh=mXcxsevWpereslJ21H6cIcxfhNvHTalLQvO15Cl+Shc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1bwJWoKjDtHNJBTJxepv/qMRfZPK5BAjzKOxgMVRTP0LCkmdTAWnz5W7QyyC00eW
         n7WjMIvp0yC3fn/AFEUMYCRhXlpFaV0sPQTihX5l28DAaqwyDtFJpGr/qesqlbkIDC
         yIJdzVaz7WS3FLKEJM0zf5CpLIb78q7ahgJI9TSxi6KF5E5uyPE6gWHOHqbwSJTWbl
         cxoYa0KS2W5foTUOHa2rvR/K8AxiRGXpo7wlCLb1IYSzbU/tVBSdybyztIByDfPv4b
         vrJR+XeoiZ1ehd0dePHzV8i9z0U0QSZlx0anafmZ1bDXiRs6pvuw5WMBm0lLMktlh7
         OQfCF7IlrQp9w==
Date:   Thu, 23 Sep 2021 12:53:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/2] common/rc: add _require_user_exists() to check if a
 user exists
Message-ID: <YUzbIiGwx3ng/4Jd@sol.localdomain>
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

Please make "user" a local variable so that it doesn't overwrite another
variable with the same name.

- Eric
