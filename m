Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06334C2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27376199B
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 15:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhF1Pin (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234958AbhF1Phu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 28 Jun 2021 11:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE5C861465;
        Mon, 28 Jun 2021 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624894525;
        bh=GK5nuON5ph+S1jmaYkls4r+AaC6Bb1PnEnKYgtbO7R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDWRBPZybH8AwvRa/7B+WPxNkD6XWdq6Pdvjjs2FcHdtvTqxGnIJu1LlR7hnjc8Dq
         P78TX9s9i+R5EwpQxPR0hyIhrWuD+K1WGpxNPPpNXlhmgMrf9+lASUYGmsy6NQ9Dga
         NuByy1NR61Z+Hy59f/JVG2mPrYiDeUUU5XvMxBBO7LK6vFlTD2C1SPNwf8ow9A+VVz
         x5Y0LvKG3gVD+cXtDSd8JRnF9aTKYzTrOS71zhRT0Hyv6j+IaVtzeb1+cCSA7Ge+ws
         QayYgFLoV3g82J98dFE6kO9TdmHica2qfmCcAYpU0OorgFUVBO6weTOMjbPO6BGUTK
         LIOEWsnrGhtYw==
Date:   Mon, 28 Jun 2021 08:35:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/514: Check xfsprogs version for verifying the
 xfs_db commands
Message-ID: <20210628153524.GB13767@locust>
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
 <20210628085259.120666-3-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628085259.120666-3-anju@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 28, 2021 at 02:22:58PM +0530, Anju T Sudhakar wrote:
> xfs_db commands like `attr_remove, attr_set, btheight, and logformat`,
> are documented only in xfsprogs version v5.5 and later. So skip checking
> for these commands in xfs_db manpage,if the test is running with
> xfsprogs version less than v5.5.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
> Query: The reason to add this check is, while running xfstest with an         
> older version of xfsprogs, this test case flags as failure, though         
> xfs_db is not expected to have those commands. Otherwise upon failure we   
> should ask the user to use the latest version of xfsprogs.                 
> OR is there any better solution for this?     

If you're shipping xfsprogs 5.5 in a product, why not update the manpage
to document the functionality that's in your product?  If you aren't
shipping 5.5, then why run such an old version?

--D

> 
>  tests/xfs/514 | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/514 b/tests/xfs/514
> index a9c67645..8da66f41 100755
> --- a/tests/xfs/514
> +++ b/tests/xfs/514
> @@ -27,6 +27,11 @@ _require_test
>  echo "Silence is golden"
>  
>  MANPAGE=$($MAN_PROG --path xfs_db)
> +# xfs_db commands - attr_remove, attr_set, btheight, and logformat
> +# are documented in 5.5.0 and later versions only. So skip checking for
> +# those commands if the version is less than 5.5.0.
> +command_list="attr_set attr_remove btheight logformat"
> +req_version=$($XFS_DB_PROG -V | cut -d" " -f3)
>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> @@ -41,7 +46,12 @@ truncate -s 128m $file
>  $MKFS_XFS_PROG $file >> /dev/null
>  
>  for COMMAND in `$XFS_DB_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
> -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> +	if [ "$req_version" \< "5.5.0" ]; then
> +		if (echo $command_list | tr ' ' '\n' | grep -F -x -q "$COMMAND");then
> +			continue
> +		fi
> +	fi
> +	$CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_db manpage"
>  done
>  
> -- 
> 2.31.1
> 
