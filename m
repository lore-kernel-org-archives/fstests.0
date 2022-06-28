Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E0C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 04:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbiF1Ehz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiF1Ehc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 00:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4421D0C8
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656391045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K0bt4sy19SZKigSvMt2GSFCfJ8WvLpG1zKBgVuSP78=;
        b=R/H+VfjjH3/1ASXSCoUwTLNDhft3wQe7/Ko4PTgbcjUqJ3KsfKRetD9Xzvr573V2mzd53/
        UC1LCkB5zgzunglnusdwdJ2pCtdWYyTzPic6cpOZDWR+TzH4efunECP/LODWs990wPS8sB
        XNhpbeUQECdBw8vBbBqzZD+6b00zUWs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-rxxdY9DxMEqnDkai-Z8yfw-1; Tue, 28 Jun 2022 00:37:23 -0400
X-MC-Unique: rxxdY9DxMEqnDkai-Z8yfw-1
Received: by mail-qk1-f200.google.com with SMTP id r6-20020a05620a298600b006a98e988ba4so12209100qkp.3
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2K0bt4sy19SZKigSvMt2GSFCfJ8WvLpG1zKBgVuSP78=;
        b=qJP49iJe9BznO2oFYE1HSfC9EN/upIwuH3G2P5LG1RJ5Zm7VcxjMYznRFJPB1O0lc1
         vJ1BkPbqUkRVzsnMlnEpHJPu+M+ly3qR5ngAcoDnrsYfV+XQj35YwvTUCW09+9E12/5G
         oGgOx58VXDrb3Mb+dlOah8RSJizP4zlvH993THSFYwS7X5pyh1c90DlG9Stxmaxh2Xqu
         ek6QDsp8OPZtbdEgmjqc6qPYWaaVD/fPekUEtk80DfoL93O4pGz96nwLkrzu873VkgEv
         D1gsctv5f3bp3Ru2xhLd44lF2siq08gwu9uNW2nEtJeUYs7/cSiAw/1dAdaGqc4ls9l1
         XRRQ==
X-Gm-Message-State: AJIora97nMlBZftiwfnf8S3tMfUK2RcOxMTFDvJFCSxeNEoisUCglvbB
        3ean+pmdpDoi+i8lpIT8ot5tf7h6h1+21V/9wohmTwMdU15++fPHfo8Czu03gARWkySGPwV5fXe
        QlXDGtdsAfTh7S246mg==
X-Received: by 2002:ac8:5d87:0:b0:319:31ee:196d with SMTP id d7-20020ac85d87000000b0031931ee196dmr8772610qtx.533.1656391042653;
        Mon, 27 Jun 2022 21:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwgZS2BBbTywhL7rKTgIaN2J3DtJCRyS9F25uH7ZKaciZv2XkOSfYiF7ZN3+VRPa2za2MKDg==
X-Received: by 2002:ac8:5d87:0:b0:319:31ee:196d with SMTP id d7-20020ac85d87000000b0031931ee196dmr8772603qtx.533.1656391042403;
        Mon, 27 Jun 2022 21:37:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v26-20020ac873da000000b00304dec6452csm8330489qtp.78.2022.06.27.21.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:37:21 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:37:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4/045: clean up unnecessary arguments to
 _require_e2fsprogs
Message-ID: <20220628043716.6y667we64rehq5qr@zlang-mailbox>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-4-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625030718.1215980-4-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 11:07:16PM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/045 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/045 b/tests/ext4/045
> index ee7c0de3..4f0ad4aa 100755
> --- a/tests/ext4/045
> +++ b/tests/ext4/045
> @@ -22,7 +22,7 @@ _supported_fs ext4
>  _require_scratch
>  _require_test_program "t_create_short_dirs"
>  _require_test_program "t_create_long_dirs"
> -_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
> +_require_dumpe2fs

Thanks, I think it planned to write "_require_command" :)

This change is good, but the patch subject:
  "ext4/045: clean up unnecessary arguments to _require_e2fsprogs"
is a little weird, dut to it's not changing "_require_e2fsprogs" (and there's
not _require_e2fsprogs).

Thanks,
Zorro

>  
>  echo "Silence is golden"
>  
> -- 
> 2.31.0
> 

