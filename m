Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF9C41513
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjHOOmk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbjHOOmL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 10:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229E93
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 07:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720FF624E1
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 14:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4A6C433C7;
        Tue, 15 Aug 2023 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692110528;
        bh=aSjxi5hURcUfPqDq3pn+4muayqq5KRCqYsZBuQpdWTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3BxE1yA+BTJjpjLnvNMaJdwP6HBkKj3Wp9awBSnUhORPpaaNI8Apbu5BNovy0K7R
         9SJY4R6QAqfJI9dEU04jILRk/yXUPvAw5f+PGaT4jqjMPtVyv6SxwAtGN0oVGCnxKW
         59mVGSUduWByws0jLYaQ1YMECErEYM0vLbwB4A/5TbNL1mQGx2pHPLwKBGpTeJswOP
         XCkkQPqtkCw7UBtg2AWmm5oJtIp6aCes3R0qKdfBGdTkt2Y5DumP8Dg6Cp+PkEH+tv
         UWbrOUhN2RJxFQMVqKMl5oIHK/OrRd/B3wCL5SVXlprtfU8IMtcmU50ZQnWXFDU/M2
         28IaxgrzviTVA==
Date:   Tue, 15 Aug 2023 07:42:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/{175,297,298}: fix use of uninitialized var
Message-ID: <20230815144208.GQ11340@frogsfrogsfrogs>
References: <20230815082835.790906-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815082835.790906-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 15, 2023 at 11:28:35AM +0300, Amir Goldstein wrote:
> The truncate command in those tests use an uninitialized variable i.
> in kdevops, i must contain some leftover, so we get errors like:
> /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
>            syntax error: operand expected (error token is "/dev/loop12)")
> 
> Apparently, noone including the author of the tests knows why this
> truncate command is in the test, so remove the wrong truncate command.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM! :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> Changes since v1:
> - Remove the unneeded truncate command instead of fixing it
> 
>  tests/generic/175 | 1 -
>  tests/generic/297 | 1 -
>  tests/generic/298 | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 07af2199..f827beb6 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -33,7 +33,6 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
>  
>  fnr=19
>  echo "Create extents"
> -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/297 b/tests/generic/297
> index 6bdc3e1c..54c2ac21 100755
> --- a/tests/generic/297
> +++ b/tests/generic/297
> @@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/298 b/tests/generic/298
> index 95d4c02b..115a9bf7 100755
> --- a/tests/generic/298
> +++ b/tests/generic/298
> @@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> -- 
> 2.34.1
> 
