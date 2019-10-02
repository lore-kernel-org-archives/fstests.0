Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA16C352AA
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 11:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A2720700
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 11:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itG7mWnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfJBLCK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:02:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39361 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJBLCK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Oct 2019 07:02:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so10139552pff.6
        for <fstests@vger.kernel.org>; Wed, 02 Oct 2019 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6o4yPi8TFZlClyYCLPHHBwXitDVfUmizCEZ+a1ceTo=;
        b=itG7mWnbepx82cVwNHzqDoi5psu+n6GHUlPPhkhAmRBGVzTxA6oHSF/KuvHFDdWeK3
         eu2ydoFAJFozQlWgUNpmC31IRr/N81vvfRuLzoAuKNjbGZbVToGs/e0ynVL8GONTv06u
         6utHXsnIeg8OfRM+VZNuw786KGkHX2YbjJiQPMcYi8o4g4J4h3xTAqtqQwdFJHMgnleA
         +IM7IvEdaeZyarI9b/5sowyEJlt1yG+eBQVontAK8hb4vteEVBMLgP/U/d4rWlPD42uF
         WPBcf4mylQuwtz2LyiR5cOH4v5qBoOS611PN1OpzYbednrngbJWvN3DLxXh/agSzMeGD
         QxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6o4yPi8TFZlClyYCLPHHBwXitDVfUmizCEZ+a1ceTo=;
        b=FPjbdTC9qVFeeB/asB3TAK7CSOAcxdRaWHZbtx3Nvz6q+G6WCFSzeDod6URolvn9E3
         sYkJonAC/OTSO6L5bBE+U/TwZzgy5Ug99Ex3dsisKV3v5kVn7FbBu4ZJfHvtB1V24Auc
         Gnv8gaa0oH6KvqiwGzwOqh7Q6IpQd0gst+d2TuJGF7bFT221IoYeR1rYlxb6bqP0aTnj
         SIPeMxKc5BkUpF8FrDmppiiynP54LDV3nDomO1c1kCgv2jEJUtTtthVi3XLJ+EluPOnZ
         SzhVi/DoKtc78MfnLSQcaYzkMojjR5b39P0h9XcUN9LgOKyrzMS02aItHq0lkU+OZ7k9
         dIAw==
X-Gm-Message-State: APjAAAVj5awRvoI2/NjzyntScYft7n+PcJlQ2l25JggY1XVumgeFx6gV
        hnobKxHoGJVm8D9M+EaUh+Q=
X-Google-Smtp-Source: APXvYqyiNBAGa4Ary9vzGlmDT2vxi02JK7mrDeXly6cLc3pyIaMAybPINpr95R1gM7FQsk+eONZo3Q==
X-Received: by 2002:a63:1f23:: with SMTP id f35mr2926384pgf.298.1570014129301;
        Wed, 02 Oct 2019 04:02:09 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id l6sm10707315pje.28.2019.10.02.04.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:02:08 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:02:02 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/rc: generalize _get_filesize()
Message-ID: <20191002110200.GA2622@desktop>
References: <20190927100742.9266-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927100742.9266-1-yuchao0@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 27, 2019 at 06:07:42PM +0800, Chao Yu wrote:
> There are some testcases use below command to get file size, generalize
> it as global function _get_filesize()
> 
> ls -l $1 | $AWK_PROG '{print $5}'
> 
> - adjust common/defrag, generic/275 and generic/315 to use it
> - remove unused _filesize in generic/013
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  common/defrag     | 2 +-
>  common/rc         | 5 +++++
>  tests/generic/013 | 5 -----
>  tests/generic/275 | 2 +-
>  tests/generic/315 | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/common/defrag b/common/defrag
> index 9866d3da..50596f70 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -145,7 +145,7 @@ _defrag()
>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
>  
>  	if [ $FSTYP == "f2fs" ]; then
> -		_filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
> +		_filesize=`_get_filesize $1`
>  		$DEFRAG_PROG 0 $_filesize $1 >> $seqres.full 2>&1
>  	else
>  		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> diff --git a/common/rc b/common/rc
> index 66c7fd4d..69735ae6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -165,6 +165,11 @@ if [ ! -z "$REPORT_LIST" ]; then
>  	_assert_report_list
>  fi
>  
> +_get_filesize()
> +{
> +    echo `ls -l $1 | $AWK_PROG '{print $5}'`

Ah, you could update _get_filesize to use "stat -c %s" version then.

Thanks,
Eryu

> +}
> +
>  _mount()
>  {
>      $MOUNT_PROG `_mount_ops_filter $*`
> diff --git a/tests/generic/013 b/tests/generic/013
> index 9e533ee8..bc596102 100755
> --- a/tests/generic/013
> +++ b/tests/generic/013
> @@ -24,11 +24,6 @@ _cleanup()
>      rm -rf $TEST_DIR/fsstress.$$.*
>  }
>  
> -_filesize()
> -{
> -    ls -l $1 | $AWK_PROG '{print "    filesize = " $5}'
> -}
> -
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/filter
> diff --git a/tests/generic/275 b/tests/generic/275
> index a934c19c..adc82856 100755
> --- a/tests/generic/275
> +++ b/tests/generic/275
> @@ -73,7 +73,7 @@ echo "Bytes written until ENOSPC:" >>$seqres.full
>  du $SCRATCH_MNT/tmp1 >>$seqres.full
>  
>  # And at least some of it should succeed.
> -_filesize=`ls -l $SCRATCH_MNT/tmp1 | awk '{print $5}'`
> +_filesize=`_get_filesize $SCRATCH_MNT/tmp1`
>  [ $_filesize -lt $((128 * 1024)) ] && \
>  	_fail "Partial write until enospc failed; wrote $_filesize bytes."
>  
> diff --git a/tests/generic/315 b/tests/generic/315
> index fd49b579..808d7d74 100755
> --- a/tests/generic/315
> +++ b/tests/generic/315
> @@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c 'falloc -k 0 $(($avail_begin/2))' \
>  	$TEST_DIR/testfile.$seq >>$seqres.full 2>&1
>  
>  # Verify the file size, it should keep unchanged as 0 in this case
> -fsize=`ls -l $TEST_DIR/testfile.$seq | awk '{print $5}'`
> +fsize=`_get_filesize $TEST_DIR/testfile.$seq`
>  [ "$fsize" -eq 0 ] || _fail "File size is changed to ($fsize Bytes)"
>  
>  # Truncate the file size back to 0
> -- 
> 2.18.0.rc1
> 
