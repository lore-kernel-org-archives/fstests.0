Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD7EB64DC
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Jul 2023 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGCOwX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCOwX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Jul 2023 10:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE3E6A
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688395886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkK4auV1MbsSz0FqNvzz5TPL43s7j3tKege3sPCH+gg=;
        b=XonBYjDVkfawR4KO7znHYpmPh5ukb7iuwQCnsBunvnU9tb2QqfUXnq9YeBnwW4wi9BQ6DJ
        TriNAhaEmiOPhHOWaol0pdUEG88uHWs3Hk0/euRDyvEoH0FCaBNvTNqpDBDj5iyCP+ujN4
        4WsChM7p0TJddzO7TtEygEa6riNEjhE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-IquGbvizOe62l0LzZ1bSlw-1; Mon, 03 Jul 2023 10:51:25 -0400
X-MC-Unique: IquGbvizOe62l0LzZ1bSlw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso4619451a12.0
        for <fstests@vger.kernel.org>; Mon, 03 Jul 2023 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395884; x=1690987884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkK4auV1MbsSz0FqNvzz5TPL43s7j3tKege3sPCH+gg=;
        b=GV4G4XzqElzhMnxfFWWZ1lnvicbbxCnNGTm84XWZXcrVQFpeK2gMQEYXryDqC5emQR
         4uLPhBGazfdjanrIqmedR6/p+ycBK0YDBQz0OmbyRNxVmuCDJT+kfYJUgrHYwZp6tTrR
         UOgCoHGsgs5ErGX/IWB0SuKUKVXdGsmbyDHQQnSJZg74aN1QvwIlR+yRUvvA375Layn/
         Zfexu82pUtotLupD3/CBlsYPABYBBhdpcwfw1EgvRljeEvccoSbCGja8NSQPHt4tZ8hn
         KLvWSXJpo4syAOBVNsJsgK52yepkGO+awiq9AuWfiU73i4ePLBCiYvFuya0vrEO3A5Nm
         wAzA==
X-Gm-Message-State: ABy/qLZJ5U2b7IZ9s99tSbjp3iZ8VnsfrEqGYcnOYJPwBdQjl2/uNSn5
        q/U3H1xW2pTGQKHfjHHJbkwhsrq87vF8Bo1jXrSvfjtzxTV2Pck+8LlP/fEoqKZsg7h1tXawlJo
        FTr1NLbbiov1xqx/SK6anPUPEQU6U/VU=
X-Received: by 2002:a17:902:ec88:b0:1b7:fef7:d578 with SMTP id x8-20020a170902ec8800b001b7fef7d578mr9300659plg.41.1688395884482;
        Mon, 03 Jul 2023 07:51:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFldUsMIxgOO3Y0JErkRzNen3IqdGAIbXb2ND4jgehnadMiKYNPOkAuzWfYbkyyw44z95Dnjw==
X-Received: by 2002:a17:902:ec88:b0:1b7:fef7:d578 with SMTP id x8-20020a170902ec8800b001b7fef7d578mr9300645plg.41.1688395884141;
        Mon, 03 Jul 2023 07:51:24 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d2d100b001b8953365aesm2204036plc.22.2023.07.03.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:51:23 -0700 (PDT)
Date:   Mon, 3 Jul 2023 22:51:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     yuezhang.mo@foxmail.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix excluded tests are only expunged in the first
 iteration
Message-ID: <20230703145120.evwr45jftcd6wl62@zlang-mailbox>
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

Can you provide an example about how to reproduce the issue you metioned above.

> 
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

If print to a file, I don't mind above way. But if to an array, how about:

  read -a tmpxlist < <(echo "$xfile" | tr ',' ' ')
  exclude_tests+=(${tmpxlist[@]})

>  		;;
>  
>  	-E)	xfile=$2; shift ;
>  		if [ -f $xfile ]; then
> -			sed "s/#.*$//" "$xfile" >> $tmp.xlist
> -	        fi
> +			exclude_tests+=($(sed "s/#.*$//" "$xfile"))
> +		fi

Similar as above, how about:

  readarray tmpxlist < <(sed "s/#.*$//" $xfile)
  exclude_tests+=(${tmpxlist[@]})

Feel free to provide better methods if anyone has.

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

How about using the "-w" option to grep. Due to the number of fstests' cases
will out of 999 (I'm thinking about how to deal with it), we might have
generic/1000 in one day. If so "grep generic/100" will match generic/1000 and
generic/100 both.

Thanks,
Zorro

> +		echo "       [expunged]"
> +		return 1
>  	fi
>  	return 0
>  }
> -- 
> 2.25.1
> 

