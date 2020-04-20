Return-Path: <SRS0=ARln=6E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D96C3815B
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC78720722
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 13:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgDTN74 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:59:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49516 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726006AbgDTN74 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Apr 2020 09:59:56 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03KDxe2Y022489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 09:59:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DA04742013B; Mon, 20 Apr 2020 09:59:39 -0400 (EDT)
Date:   Mon, 20 Apr 2020 09:59:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     jack@suse.cz, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/456: document the other kernel commit
Message-ID: <20200420135939.GB1080594@mit.edu>
References: <1587370697-13249-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370697-13249-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 20, 2020 at 04:18:17PM +0800, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Thanks for adding the documentation for the needed commit.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


> ---
>  tests/generic/456 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/456 b/tests/generic/456
> index 434a0ffa..b588fc07 100755
> --- a/tests/generic/456
> +++ b/tests/generic/456
> @@ -10,6 +10,10 @@
>  # Fixed by commit 51e3ae81ec58 ("ext4: fix interaction between i_size,
>  # fallocate, and delalloc after a crash")
>  #
> +# This is also a regression test for ext4 bug that zero range can beyond
> +# i_disksize and fixed by commit 801674f34ecf ("ext4: do not zeroout extents
> +# beyond i_disksize").
> +#
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
>  echo "QA output created by $seq"
