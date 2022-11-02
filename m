Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF094C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Nov 2022 22:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKBWlp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBWlo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2022 18:41:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A164AF2A
        for <fstests@vger.kernel.org>; Wed,  2 Nov 2022 15:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16C9ECE2265
        for <fstests@vger.kernel.org>; Wed,  2 Nov 2022 22:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E70C433D6;
        Wed,  2 Nov 2022 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428900;
        bh=yE0ff4POLhh5vOIM9ErowUcsAUCihcLcJQceuwqiais=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcDzYsKz9VaM4pwkSa2+OLejoCwQQmdnpK6b44DcfxgzMCF1gF/braPl0A41/6FZD
         +Cf6ph4dh4wjTXa4uN2BXLNvO4wpdDJlugkr8w9ltw8fFD91/F4FFkUa5NLprBXmPL
         pu4QbIOzpDRdVbGEMoKetum/hNsV/BaC/qNZzGpJDyzXepROQtnqbV2gknIWa05NPJ
         IGEUDUddojRCuv5nbasp9X/9fAuRTOHhG9Zm0trxqnal69y9npIMYUGwdKZLSkZKiE
         iBTqHmLKlyggqQ3Xg60ybDLYPGHEhvS6/KBH8q/WR269NBNP0L7/jVl52BU0WtPK2c
         /2kk69Ksday/A==
Date:   Wed, 2 Nov 2022 15:41:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/577: add missing fsverity metadata cleaning
Message-ID: <Y2LyIiDDR9/RS773@sol.localdomain>
References: <20221102165134.169135-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102165134.169135-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 02, 2022 at 05:51:34PM +0100, Andrey Albershteyn wrote:
> When fs-verity is enabled on the file, file becomes read-only. In last
> check, test tries to empty the file. However, fs-verity denies
> opening/writing to file.
> 
> Remove file beforehand as in other checks.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  tests/generic/577 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/577 b/tests/generic/577
> index 98c3888f..916f3be3 100755
> --- a/tests/generic/577
> +++ b/tests/generic/577
> @@ -121,6 +121,7 @@ if _fsv_have_hash_algorithm sha512 $fsv_file; then
>  fi
>  
>  echo -e "\n# Testing empty file"
> +reset_fsv_file
>  echo -n > $fsv_file
>  _fsv_sign $fsv_file $sigfile.emptyfile --key=$keyfile --cert=$certfile | \
>  		_filter_scratch

Thank you for reporting this.  How did you notice this?  This test actually is
currently passing, because there is another test bug that makes
_fsv_have_hash_algorithm always return false here.  That really needs to be
fixed first, as otherwise your fix doesn't really do anything.

- Eric
