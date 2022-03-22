Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF10C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiCVIco (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCVIcm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 04:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A621426AFF
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647937874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oBxhg8aIAR2ARBpYoSCpoyNGBILORRZh8hHyLPMtaE=;
        b=YypGqln4F6xfIDqn7Xzy0rC2fgvsQnzKbxpyAg+squvg8alVXCOqmArri6FnU+QqDYcRyv
        EiSMyf/pyvKaYbYkKoMbOasxDiEY5GRu08XSKtYAbo5WRIZscnNZGBBLjXKvOZEgYHg+/W
        hMyDY4UwW4GpPVdu72kjneHJM5qzzcA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-2UhqhxlnMHeS7OWdO_xrBA-1; Tue, 22 Mar 2022 04:31:13 -0400
X-MC-Unique: 2UhqhxlnMHeS7OWdO_xrBA-1
Received: by mail-qk1-f200.google.com with SMTP id f11-20020a05620a20cb00b0067b3fedce10so11324833qka.15
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 01:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7oBxhg8aIAR2ARBpYoSCpoyNGBILORRZh8hHyLPMtaE=;
        b=4fCHraFFOifMJFt1RqMCcet2QfUv7ZvOYgeuvxcTwz4m6jBDHIPVSFPiKc6IPIF36U
         jG9be1D8pjqI4C/RNEnV2UMaeb061I19z39+dij5+g6eK1+EKZ5tJvy04WcPW4xmm6/b
         HMblZpbxRa9HuAAkHfhR0v9awQ3xX2H5LTOHj9musq9amvV4g8boX9ER10YGXjAYBWl6
         4fKRcawq/k2eKd0eOoOpRSYK0Q8sspuYY33jTWb9V/CkSgOtpenoCmUek1U4t2Yx+AgF
         +TiKZ9LvBcGERIfH9Ij7PtP9kGXHs3jSvahzGiWWjeaWdvP3H+JICSKfljtXR+3ONjdy
         Q9jg==
X-Gm-Message-State: AOAM532hjGFdm6WYooYy5Jz8sCUDdLsing/b6zA0RXNxUjwcmDRWEvuE
        qEFurqLyE1IwMlVgEQ0YB01qz5Kz9RVnE0/CLIkyG5R4bXSZg/oEVh7Au3NpIWtAYIost7miHLo
        vfy+7ZuccLJt7PZXXRQ==
X-Received: by 2002:ac8:5894:0:b0:2e1:c997:a61e with SMTP id t20-20020ac85894000000b002e1c997a61emr19089555qta.388.1647937872715;
        Tue, 22 Mar 2022 01:31:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Mv04gNlalayh5uzmjWMTDVoEos4zzLcNCEsG1/nOpq2iBwMbdw8BxKQZUuCfPVtTpptO4w==
X-Received: by 2002:ac8:5894:0:b0:2e1:c997:a61e with SMTP id t20-20020ac85894000000b002e1c997a61emr19089547qta.388.1647937872475;
        Tue, 22 Mar 2022 01:31:12 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm13588073qtg.0.2022.03.22.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:31:11 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:31:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 5/4] xfs/076: only create files on the data device
Message-ID: <20220322083104.nh7uqcrm2fgbuycl@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164740140348.3371628.12967562090320741592.stgit@magnolia>
 <20220316221232.GE8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316221232.GE8200@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 16, 2022 at 03:12:32PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test checks that filesystems with sparse inode support can continue
> to allocate inodes when free space gets fragmented.  Inodes only exist
> on the data device, so we need to ensure that realtime is not enabled on
> the filesystem so that the rt metadata doesn't mess with the inode usage
> percentage and cause a test failure.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/076 |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/076 b/tests/xfs/076
> index eac7410e..8eef1367 100755
> --- a/tests/xfs/076
> +++ b/tests/xfs/076
> @@ -55,12 +55,21 @@ _alloc_inodes()
>  
>  # real QA test starts here
>  
> -_require_scratch
> +if [ -n "$SCRATCH_RTDEV" ]; then
> +	# ./check won't know we unset SCRATCH_RTDEV
> +	_require_scratch_nocheck
> +else
> +	_require_scratch
> +fi
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  _require_xfs_sparse_inodes
>  
> -_scratch_mkfs "-d size=50m -m crc=1 -i sparse" |
> +# Disable the scratch rt device to avoid test failures relating to the rt
> +# bitmap consuming all the free space in our small data device.
> +unset SCRATCH_RTDEV
> +
> +_scratch_mkfs "-d size=50m -m crc=1 -i sparse" | tee -a $seqres.full |
>  	_filter_mkfs > /dev/null 2> $tmp.mkfs
>  . $tmp.mkfs	# for isize
>  
> 

