Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28074C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C28560F6F
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhIWTtk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243060AbhIWTth (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B00D960F6F;
        Thu, 23 Sep 2021 19:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426485;
        bh=ThNlI+F4pX8F4PRwzwa3dCCVrIV9QWjeMpQaHIPJmfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MARAuiyyHp3J3pNFnBe4+/g8tHVKhZxLVPJiopHTh/cc3GTgkAfKIla8Ztl7NHVWp
         m/tpa6tzEeBa15hHx6w3Dt7tU57l06wCz0ecPbNUE+uvaAu0WqKddleMLvz4I4zuTG
         iPXBuIKPbAY4CKjE274yv2kKkv0cyPBOKTjUCcnzV/tsX7bsXO8pA7+DFj+iCxHJVF
         2yoaF1rObSObDvre5rrbgkrU8+8TXtfEKO/QXKMC6mWn5EHrZyvJxOLKI7CHeER7r/
         rzvnGTPH7AFF1p4ZP9kL1MRshYPUhLeTgWN/dG3krNh9PNE5jfnVUPAShhQnXcmJOh
         rAk0IDGlQXgDg==
Date:   Thu, 23 Sep 2021 12:48:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/2] generic/079: make sure users 'nobody' and 'daemon'
 exist
Message-ID: <20210923194805.GB570597@magnolia>
References: <20210923104123.29878-3-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923104123.29878-3-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 23, 2021 at 11:41:23AM +0100, Luis Henriques wrote:
> Test 'src/t_immutable' assumes the existence of users 'nobody' and
> 'daemon' on the system.  If any of these users don't exist, the test will
> fail with:
> 
>   add_acl(/media/scratch/079/immutable.f) did not set errno == EPERM
>   ...
> 
> because it tries to set ACLs such as:
> 
>   u::rwx,g::rwx,o::rwx,u:daemon:rwx,m::rwx
> 
> Use the new _require_user_exists() function to ensure these users exist.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Looks correct.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/079 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/079 b/tests/generic/079
> index 829275db8cdf..9e7ccd31c8e2 100755
> --- a/tests/generic/079
> +++ b/tests/generic/079
> @@ -26,6 +26,8 @@ _cleanup()
>  _supported_fs generic
>  
>  _require_chattr ia
> +_require_user_exists "nobody"
> +_require_user_exists "daemon"
>  _require_test_program "t_immutable"
>  _require_scratch
>  
