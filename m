Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6852CDB465
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Oct 2023 18:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPShg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Oct 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPShg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Oct 2023 14:37:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E695
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 11:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B4AC433C7;
        Mon, 16 Oct 2023 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481454;
        bh=fJHb/HQyTdBzzWmB3JoZFNX9zK1+Pd0usqRp7/7My0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhXjoKam1Wuf9+xIAY+hax+LzUzc3ilW+QccE+uKMubv9exS9uhrXijito0mGb3NH
         rmXS4qjY2iCCqKDvmhvjIPfeSP/hieiQgcEs+Clf6ixIMvyShGAfxRju1IQdLPeyTP
         BSjJNJNjDje/MJsYnbVQrEh7ff1uUPzkn3SHh7o1BY7wqUSlz12VFV1i0ZA530BmEm
         yqZ2/PN5VKonv7QwPFJ6oKYXyi8JlXi2D24CE1pD9turosY5R1fkJgW2ISdKVVQ66/
         vRvolgP7KkiSbj4N3/Xfb7QticQeafzZE62Cud6NLm03EqEwfRoZWhVkgzDLQDnPLA
         a/wTxur8WSlbQ==
Date:   Mon, 16 Oct 2023 11:37:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs/556: call _require_dm_target later
Message-ID: <20231016183733.GA11391@frogsfrogsfrogs>
References: <20231016131103.966920-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016131103.966920-1-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 16, 2023 at 03:11:02PM +0200, Christoph Hellwig wrote:
> _require_dm_target tries to use $SCRATCH_DEV, so move it after we've
> established that the configuration has a valid $SCRATCH_DEV.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops, thanks for catching that.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/556 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/556 b/tests/xfs/556
> index 66908a54..061d8d57 100755
> --- a/tests/xfs/556
> +++ b/tests/xfs/556
> @@ -25,10 +25,10 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs xfs
> -_require_dm_target error
>  _require_scratch
>  _require_scratch_xfs_crc
>  _require_scrub
> +_require_dm_target error
>  
>  filter_scrub_errors() {
>  	_filter_scratch | sed \
> -- 
> 2.39.2
> 
