Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A8C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 04:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiCVE7O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 00:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiCVE7N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 00:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE051C133
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647925063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYVK7GUco8u1z+nbvIUDn7D1LBdX+dFnmPGapwkkTZM=;
        b=Mefho2FAXpR69UNbBOzIiqHBSk1c1EuC50ccT4Bx/HSG17MRCVHwQKy1xPofxJv0MutV9E
        peoQqM/tyMtzTEIha47sY7FHcp6SPA74E1x3GDyPXsRxhL11UUdt7L7PUscNyItLeaQS7w
        ZTb4LMz97QzBUiCfxvv45DHXomNTkD8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-d5xWAlJrO7ark1pRzdkJDA-1; Tue, 22 Mar 2022 00:57:42 -0400
X-MC-Unique: d5xWAlJrO7ark1pRzdkJDA-1
Received: by mail-pj1-f72.google.com with SMTP id q71-20020a17090a17cd00b001c653c3b564so7567329pja.9
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 21:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NYVK7GUco8u1z+nbvIUDn7D1LBdX+dFnmPGapwkkTZM=;
        b=6iaVbnLoIuW9ixkg5U1V83bku7OAv50psB0l5zpoiVslexTyz3BMfB/EXG7hfMif25
         zWhReq4S1zBdLAlOTPPqi5Aima32stXJHZBSEtaK8tLUV/0jryCfcu6cDjyqdHV98E8n
         2qORlOF2FzROydrtpWWovNyVaUicX33xqbUhJEIrH+OztdSXV/EstBQMTK1RZRaUgKWd
         3uwzn5wrCioSIQYk0dljedbE/vd6iy5V9P1Yvyt/29+ToNODnuJYhMhLV8QHlbVhReSP
         QxxsrFrLbh/nkyG/oqY5ewigBnRWwIsGmx6ZBFtNMj64mdZEWQFb7RgwGaEbmDw7kALA
         9EGQ==
X-Gm-Message-State: AOAM532IKtMOo0v85k5X6QyHxp5keZBSLiEH2G/YTO7l1UvN0OjPS77F
        shvs0vje//KBzHwa8y/OyoltOM/ryKxjDWVk/jNMkxa3WOlbxHxrIfAa4KySPhGeOrAyLDI91rx
        ZNV7DrjU27VGzRt0+Uw==
X-Received: by 2002:a05:6a00:1341:b0:4fa:a3af:6ba3 with SMTP id k1-20020a056a00134100b004faa3af6ba3mr7938163pfu.51.1647925061099;
        Mon, 21 Mar 2022 21:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuMUkx3a9whxFypKlbdnTAOAwQ1XqoymV8zDMYm/3cM2Ng4jZ70KcXblvMY6YLl+5/HwPKTA==
X-Received: by 2002:a05:6a00:1341:b0:4fa:a3af:6ba3 with SMTP id k1-20020a056a00134100b004faa3af6ba3mr7938147pfu.51.1647925060728;
        Mon, 21 Mar 2022 21:57:40 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i15-20020a63b30f000000b003803aee35a2sm16324655pgf.31.2022.03.21.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 21:57:40 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:57:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] common/xfs: fix broken code in _check_xfs_filesystem
Message-ID: <20220322045736.rdjxmbfaquz6byn4@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164740140348.3371628.12967562090320741592.stgit@magnolia>
 <164740141477.3371628.6804259397500636490.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164740141477.3371628.6804259397500636490.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 15, 2022 at 08:30:14PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Fix some problems with undefined variables in the scrub control code.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Actually from the beginning I don't know what's the $scrubflag used for, due
to it never be used in any other place of xfstests. I thought you left it for
personal debug reason, or even thought you'd like to make it as XFS_SCRUB_FLAG
to be a global parameter. Anyway I'm good if you'd like to remove it now.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/common/xfs b/common/xfs
> index 053b6189..ac1d021e 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -568,12 +568,12 @@ _check_xfs_filesystem()
>  		# before executing a scrub operation.
>  		$XFS_IO_PROG -c syncfs $mntpt >> $seqres.full 2>&1
>  
> -		"$XFS_SCRUB_PROG" $scrubflag -v -d -n $mntpt > $tmp.scrub 2>&1
> +		"$XFS_SCRUB_PROG" -v -d -n $mntpt > $tmp.scrub 2>&1
>  		if [ $? -ne 0 ]; then
>  			_log_err "_check_xfs_filesystem: filesystem on $device failed scrub"
> -			echo "*** xfs_scrub $scrubflag -v -d -n output ***" >> $seqres.full
> +			echo "*** xfs_scrub -v -d -n output ***" >> $seqres.full
>  			cat $tmp.scrub >> $seqres.full
> -			echo "*** end xfs_scrub output" >> $serqres.full
> +			echo "*** end xfs_scrub output" >> $seqres.full
>  			ok=0
>  		fi
>  		rm -f $tmp.scrub
> 

