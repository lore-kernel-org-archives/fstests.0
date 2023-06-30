Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2FEB64D7
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jun 2023 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjF3PlX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjF3PlW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jun 2023 11:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1BE5C
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 08:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F1361789
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A819C433C0;
        Fri, 30 Jun 2023 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688139680;
        bh=v5efJtfvnMO98cbY/R2CC9B8jzo2Nwvb5c24w/M6nhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YU5w4iDdA4GYigWy1sULN7YDy6lECCaadfW+pquBvWlSgkSYoq+P1kCFi2dW8Svme
         QSvkbOKSraGjEES7w2rPpJWshZhn9uFMU/9z28QuoXktGtBD8sH7qWF1fgbq/pNWha
         qtnEvEfG3a59Dy4HdEKTybPjbudWJ0FMGWcC/gNtRO86HyIwlKQHcxJD1fSsz6bsMv
         piEgebndRG91syQyKu92unhayU/4n3i21Cpgl03/+QLiUQBLLe3eW1pgu0xUFm8QQN
         tOamfg0/t9Tr9b7f/cjtAUCZVD8Ybc4Dc+XrwCmyi7LAPlLdwhRv95Uf42fd61s6u+
         q4CNte5OW04vQ==
Date:   Fri, 30 Jun 2023 08:41:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     yuezhang.mo@foxmail.comg
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix excluded tests are only expunged in the first
 iteration
Message-ID: <20230630154119.GC11427@frogsfrogsfrogs>
References: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 30, 2023 at 08:28:29PM +0800, yuezhang.mo@foxmail.com wrote:
> From: Yuezhang Mo <yuezhang.mo@foxmail.com>
> 
> If iterating more than once and excluding some tests, the
> excluded tests are expunged in the first iteration, but run in
> subsequent iterations. This is not expected.

I don't get it.  ./check only deletes $tmp.xlist at startup time, not
between iterations.  Is there somewhere that ./check exec's itself when
you run ./check -i 5 ?

> The problem was caused by the temporary file saving the excluded
> tests being deleted at the end of the first iteration.
> 
> This commit saves the excluded tests into a variable instead of a
> temp file.
> 
> Signed-off-by: Yuezhang Mo <yuezhang.mo@foxmail.com>
> ---
>  check | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/check b/check
> index e36978c1..a8071121 100755
> --- a/check
> +++ b/check
> @@ -27,6 +27,7 @@ DUMP_OUTPUT=false
>  iterations=1
>  istop=false
>  loop_on_fail=0
> +exclude_tests=()
>  
>  # This is a global variable used to pass test failure text to reporting gunk
>  _err_msg=""
> @@ -46,7 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
>  
> -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
> @@ -302,13 +303,13 @@ while [ $# -gt 0 ]; do
>  		;;
>  	-e)
>  		xfile=$2; shift ;
> -		echo "$xfile" | tr ', ' '\n\n' >> $tmp.xlist
> +		exclude_tests+=($(echo "$xfile" | tr ', ' '\n\n'))

Please use readarray/mapfile for storing to a bash array, please.

--D

>  		;;
>  
>  	-E)	xfile=$2; shift ;
>  		if [ -f $xfile ]; then
> -			sed "s/#.*$//" "$xfile" >> $tmp.xlist
> -	        fi
> +			exclude_tests+=($(sed "s/#.*$//" "$xfile"))
> +		fi
>  		;;
>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
>  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> @@ -383,7 +384,7 @@ if [ -n "$subdir_xfile" ]; then
>  	for d in $SRC_GROUPS $FSTYP; do
>  		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
>  		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
> -			echo $d/$f >> $tmp.xlist
> +			exclude_tests+=($d/$f)
>  		done
>  	done
>  fi
> @@ -570,11 +571,10 @@ _check_filesystems()
>  _expunge_test()
>  {
>  	local TEST_ID="$1"
> -	if [ -s $tmp.xlist ]; then
> -		if grep -q $TEST_ID $tmp.xlist; then
> -			echo "       [expunged]"
> -			return 1
> -		fi
> +
> +	if echo ${exclude_tests[*]} | grep -q $TEST_ID; then
> +		echo "       [expunged]"
> +		return 1
>  	fi
>  	return 0
>  }
> -- 
> 2.25.1
> 
