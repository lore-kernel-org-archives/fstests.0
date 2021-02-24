Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F0C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDC464F06
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhBXQwU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235738AbhBXQvs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Feb 2021 11:51:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8303064EBA;
        Wed, 24 Feb 2021 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614185458;
        bh=KWM1ivJqtm1fHlItfbBOhYn0/KJ/mmmhGw0xP60eLdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdUV2/fUTU8G+uKWxa57hzTvHxVmMo1RUF5JYSMR7j5d8Heguw0P2AeQicP7uq1HM
         TPT+iND2DnmpV8I/eE2EwohqRa8G2geDqCgHcDM8IHXzwhtOgMf3rIBhIQEP3hx5Eb
         e9tQrMUuaNtO0O0KU5DOdWOLpfjjLE5JPcZZTR5w71A0LUi0Q/K62JB3nnePJJyUF7
         BQRIhdiTHivZ+74lqcDwdu2iVxbpFAuX4ogu2oIPmGY35eVZpq2UryPBXE1phEZclu
         vmXBvkWuuB9gZ7MUsp3SFAdfvFPGiAwcd/tKBSpxY+qhxmILSfXL03wwCtQCoY8v9a
         LBW6UOk9kRdjQ==
Date:   Wed, 24 Feb 2021 08:50:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/473: fix expectation properly in out file
Message-ID: <20210224165057.GB7269@magnolia>
References: <20210223134042.2212341-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223134042.2212341-1-cgxu519@mykernel.net>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 23, 2021 at 09:40:42PM +0800, Chengguang Xu wrote:
> It seems the expected result of testcase of "Hole + Data"
> in generic/473 is not correct, so just fix it properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  tests/generic/473.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/473.out b/tests/generic/473.out
> index 75816388..f1ee5805 100644
> --- a/tests/generic/473.out
> +++ b/tests/generic/473.out
> @@ -6,7 +6,7 @@ Data + Hole
>  1: [256..287]: hole
>  Hole + Data
>  0: [0..127]: hole
> -1: [128..255]: data
> +1: [128..135]: data

This again.  While the FIEMAP documentation allows the call to return
file mapping data outside the requested range, it doesn't require it,
and neither XFS nor ext4 have ever done so.

This test *enforces* that the FIEMAP implementation provide data outside
the requested range, which means it has never passed on xfs/ext4.  This
is no surprise, since it's enforcing one behavior where the spec allows
for two behaviors.  The only fs I know of where it passes is btrfs.

Delete this test or move it to tests/btrfs/, because it should not have
been added in the first place.

--D

>  Hole + Data + Hole
>  0: [0..127]: hole
>  1: [128..255]: data
> -- 
> 2.27.0
> 
> 
