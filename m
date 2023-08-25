Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB6C71133
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Aug 2023 14:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHYOOG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Aug 2023 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbjHYONu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2023 10:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6292718
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692972697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=iNtGcFkLVYafpyDKO+8TuFmvc9GpPjyubPpnsjM3cYpUmoHA4nJvAWzWHo1r9a66pCApqh
        SppeXvPZ9G4N4/wSKUuJ1qa3rc2Ue/Qy4QhaoNgweqCkLBHw1K3k0lIG/kxuctYqpL1Q4f
        pj2x17Vh3Ud57rK4P7xFQbDQwIbdtEc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-EKHQaSbxNU6I48c-r7sjUQ-1; Fri, 25 Aug 2023 10:11:34 -0400
X-MC-Unique: EKHQaSbxNU6I48c-r7sjUQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso2302681a91.1
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972694; x=1693577494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=aCEib7VUq+/NoqyC2w95BbMJJnxZEKfppcyYEz5rsrCJ/V3s6PpAGqsaPgYWRJ3T5G
         k7/nYd2rb1FTvSt2mCU6eFEYad0Yih/fSbSRLerEBOtqV4q6z819k19cdUufPLa6FDMI
         fKkUL+jwIzOnAeB6GuUrAB9+MqUD10V8fwjn1WI0XY7NzLXX5GhiqhE1CE5uNeEsLkuv
         kUerLauZAg5FDbEDMrmF9PnwXDVAIVPM3khn96kX4BxEDXX3l5mni1C+7M+Va9Z1DXPb
         L2fUCuuL0ZlogVsRxhB2UDcafnrblV9kok7o9zIKPBgjHF0tOMmJBKA0qL83wjk7FHD3
         25VA==
X-Gm-Message-State: AOJu0Yz8NGWfxz/fUGpEh2SQ55/Ns57LkMaNJYRancCQa4qN7B2Ko1aV
        gLBDQUHAubUY+z+uuv2CTJtaZRef243AzvJCRCNIOysFpsmMP2yCTV+jxPb5W2RW/vp0f+5mUse
        dmvENI52PEfJE4WqChA==
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27791225pjb.6.1692972691185;
        Fri, 25 Aug 2023 07:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Zc5uEZF4xZ2onoUZA2BvHZjsLlVtg14k+brKht9HvqHaz/Zv4GjWBRyj/R5XzcIugOYQqg==
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27790951pjb.6.1692972687482;
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00263ba6a248bsm3563040pjx.1.2023.08.25.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:11:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
Message-ID: <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> This test requires being able to set file capabilities which some
> filesystems (namely NFS) do not support. Add a _require_setcap test
> and only run it on filesystems that pass it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/513 |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed0425..33e74d20c28b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5048,6 +5048,19 @@ _require_mknod()
>  	rm -f $TEST_DIR/$seq.null
>  }
>  
> +_require_setcap()
> +{
> +	local testfile=$TEST_DIR/setcaptest.$$
> +
> +	touch $testfile
> +	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1

Actually we talked about the capabilities checking helper last year, as below:

https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/

As you bring this discussion back, how about the _require_capabilities() in
above link?

Thanks,
Zorro

> +	if grep -q 'Operation not supported' $testfile.out; then
> +	  _notrun "File capabilities are not supported on this filesystem"
> +	fi
> +
> +	rm -f $testfile $testfile.out
> +}
> +
>  _getcap()
>  {
>  	$GETCAP_PROG "$@" | _filter_getcap
> diff --git a/tests/generic/513 b/tests/generic/513
> index dc082787ae4e..52f9eb916b4a 100755
> --- a/tests/generic/513
> +++ b/tests/generic/513
> @@ -18,6 +18,7 @@ _supported_fs generic
>  _require_scratch_reflink
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
> +_require_setcap
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> 
> -- 
> 2.41.0
> 

