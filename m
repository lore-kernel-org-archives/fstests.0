Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F8C43334
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Jul 2022 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiGGMZh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiGGMZg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 08:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DD68112B
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657196734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MyfM9qcxAgXPM/LZ2WgeXI48hqTj0++nO4aSqorrYk=;
        b=IPzDnNsb0s9MUaNgdFbGm87ZSCQK9ERC4EEc3ZjyZtZB4jjuFYre0LT0BEryhLgNXqdp/E
        Kug1bR3xLk/n59GkyqwMgMA8Jg57G57CcvjGIPdMtr7C1Z3YWGreWvSFUEqRfxZAxi7Yw8
        jZiIpc1sk7sBm/JE4BGWS473mqvnS1w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-2DdXRqDtPvu4CqoIam_2bA-1; Thu, 07 Jul 2022 08:25:32 -0400
X-MC-Unique: 2DdXRqDtPvu4CqoIam_2bA-1
Received: by mail-qt1-f197.google.com with SMTP id cr13-20020a05622a428d00b0031d3463f241so15121885qtb.8
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2022 05:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MyfM9qcxAgXPM/LZ2WgeXI48hqTj0++nO4aSqorrYk=;
        b=nmQKGg3Qv5Nc8/y2a92L4tNgq5OHK805kohPMlvSNp5dG7kvko1RS6lK+AYfIPj0uL
         Qx6A4la5fgng63zfz1rKL7c7Ii9vZx2Wk94N5CMo+mrmPI+6CuTiigLOIzq98PTRI4zA
         pDWk9V00u3Kx9x0TsEmBe2LpGKQmq83tU67NQuTehnlrEmArPZ7IBccex8bjMIIkcdzb
         Qjymlvsc2YNIRuN4qcodphriarBKP+Vx+zlZTPjP21pe0cQC39j4ut+mKMHgsFACdkmH
         9suDeuElrrPTx4BXlktXBNM+Lu9/r3woYQ/ezb6aC2FvVkt66he36W5J9d4ZK1J6QQWf
         BOCA==
X-Gm-Message-State: AJIora//uY03YGO/PMvTTTCL2QBGXLukWb8oWkseQhPa62GCkRj6mDmc
        lzosxjzMWDJeReOVTC/re6gLGZWwLvlCe1sSNLi9o4Emyjn2atL5a4I6NJLeioaoLrEsqPcQKuP
        Tcw8Z5d4ia4M73BUodA==
X-Received: by 2002:a05:6214:2521:b0:472:f72b:a58f with SMTP id gg1-20020a056214252100b00472f72ba58fmr17194583qvb.97.1657196732167;
        Thu, 07 Jul 2022 05:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v1UUPZO/w2xjODdcL29icXgd/Wfw8e+dD7N6bCNS5kBW1qjSxCqQCuot6xKuqOTqOXL1b4qA==
X-Received: by 2002:a05:6214:2521:b0:472:f72b:a58f with SMTP id gg1-20020a056214252100b00472f72ba58fmr17194568qvb.97.1657196731937;
        Thu, 07 Jul 2022 05:25:31 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ea2-20020a05620a488200b006a79d8c8198sm22058719qkb.135.2022.07.07.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:25:31 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:25:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/288: skip repair -n when checking empty root
 leaf block behavior
Message-ID: <20220707122525.so6alaa63hdz3bbx@zlang-mailbox>
References: <165705854325.2821854.10317059026052442189.stgit@magnolia>
 <165705855433.2821854.6003804324518144422.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165705855433.2821854.6003804324518144422.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 03:02:34PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update this test to reflect the (once again) corrected behavior of the
> xattr leaf block verifiers.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/288 |   32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> 
> diff --git a/tests/xfs/288 b/tests/xfs/288
> index e3d230e9..aa664a26 100755
> --- a/tests/xfs/288
> +++ b/tests/xfs/288
> @@ -8,7 +8,7 @@
>  # that leaf directly (as xfsprogs commit f714016).
>  #
>  . ./common/preamble
> -_begin_fstest auto quick repair fuzzers
> +_begin_fstest auto quick repair fuzzers attr
>  
>  # Import common functions.
>  . ./common/filter
> @@ -50,25 +50,19 @@ if [ "$count" != "0" ]; then
>  	_notrun "xfs_db can't set attr hdr.count to 0"
>  fi
>  
> -# make sure xfs_repair can find above corruption. If it can't, that
> -# means we need to fix this bug on current xfs_repair
> -_scratch_xfs_repair -n >> $seqres.full 2>&1

So we drop the `xfs_repair -n` test.

Will the latest xfs_repair fail or pass on that? I'm wondering what's the expect
result of `xfs_repair -n` on a xfs with empty leaf? Should it report errors,
or nothing wrong?

Thanks,
Zorro

> -if [ $? -eq 0 ];then
> -	_fail "xfs_repair can't find the corruption"
> -else
> -	# If xfs_repair can find this corruption, then this repair
> -	# should junk above leaf attribute and fix this XFS.
> -	_scratch_xfs_repair >> $seqres.full 2>&1
> +# Check that xfs_repair discards the attr fork if block 0 is an empty leaf
> +# block.  Empty leaf blocks at the start of the xattr data can be a byproduct
> +# of a shutdown race, and hence are not a corruption.
> +_scratch_xfs_repair >> $seqres.full 2>&1
>  
> -	# Old xfs_repair maybe find and fix this corruption by
> -	# reset the first used heap value and the usedbytes cnt
> -	# in ablock 0. That's not what we want. So check if
> -	# xfs_repair has junked the whole ablock 0 by xfs_db.
> -	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" | \
> -		grep -q "no attribute data"
> -	if [ $? -ne 0 ]; then
> -		_fail "xfs_repair didn't junk the empty attr leaf"
> -	fi
> +# Old xfs_repair maybe find and fix this corruption by
> +# reset the first used heap value and the usedbytes cnt
> +# in ablock 0. That's not what we want. So check if
> +# xfs_repair has junked the whole ablock 0 by xfs_db.
> +_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" | \
> +	grep -q "no attribute data"
> +if [ $? -ne 0 ]; then
> +	_fail "xfs_repair didn't junk the empty attr leaf"
>  fi
>  
>  echo "Silence is golden"
> 

