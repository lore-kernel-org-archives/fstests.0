Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3DEB64D7
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jun 2023 13:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF3NfR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jun 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjF3Neo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jun 2023 09:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25566359E
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688132037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oC6nldo55CeAMc/7ZA0Xl/wynbOxyjOq9rqWCzC0+MA=;
        b=KqnUKmhDtrWZA3Mk66nHEWaDVWODxxDQK8TK9U8SaGExm67LjGJ7PzUybQive9Abn+QnkH
        hGEnkGFNuJqFqbXOW/Y5pszgCFxCEWZNUn9a0Ae3BD7DpgJhX/5ova+r+RcKFeKoXNJ89h
        x0VKUvsMVDVFvr/ruuALaj9HL0jgI3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-Wq2DEO_iP8GttW4G9jF2ww-1; Fri, 30 Jun 2023 09:33:56 -0400
X-MC-Unique: Wq2DEO_iP8GttW4G9jF2ww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACAE3185A791;
        Fri, 30 Jun 2023 13:33:55 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82662492B02;
        Fri, 30 Jun 2023 13:33:55 +0000 (UTC)
Date:   Fri, 30 Jun 2023 08:33:53 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     yuezhang.mo@foxmail.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix excluded tests are only expunged in the first
 iteration
Message-ID: <ZJ7ZwfwSG+dYp4ai@redhat.com>
References: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 30, 2023 at 08:28:29PM +0800, yuezhang.mo@foxmail.com wrote:
> From: Yuezhang Mo <yuezhang.mo@foxmail.com>
> 
> If iterating more than once and excluding some tests, the
> excluded tests are expunged in the first iteration, but run in
> subsequent iterations. This is not expected.
> 
> The problem was caused by the temporary file saving the excluded
> tests being deleted at the end of the first iteration.
> 
> This commit saves the excluded tests into a variable instead of a
> temp file.
> 
> Signed-off-by: Yuezhang Mo <yuezhang.mo@foxmail.com>

Makes sense.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

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

