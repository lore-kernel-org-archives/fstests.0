Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98598C432BE
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 05:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768FD60FED
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 05:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHLFQH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 01:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231250AbhHLFQG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Aug 2021 01:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628745341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16AuHIc1bmCXRfuNPgiSwAfN/GfDROQFYiJHXcAW1mg=;
        b=IsF4iFYFm/T0UFsA6e6NpmnBpAaTPu5e8WWyxwEvOrCS/gE+jNjQbN/EVLUpk3NRZSO85M
        a/iXtr2zBINsJ40DX7Rqjh5TfzG+y25qoSJZ/Xihl++tLoXrkIEoeYKURN3yxGrMJy1xx+
        QE4+XB8gHz7b9Ow41miRaK40FXUjW2g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-sgxzCD1JNHGLFIk2hTSdHw-1; Thu, 12 Aug 2021 01:15:38 -0400
X-MC-Unique: sgxzCD1JNHGLFIk2hTSdHw-1
Received: by mail-pl1-f197.google.com with SMTP id g12-20020a1709026b4cb029012c0d2e483cso2962372plt.5
        for <fstests@vger.kernel.org>; Wed, 11 Aug 2021 22:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=16AuHIc1bmCXRfuNPgiSwAfN/GfDROQFYiJHXcAW1mg=;
        b=P1ynVsgms6fPNwHoIzR6FQsMwSLJQqkV9edMSRW5smHWS3FtHKlJussWgtjJq7lNur
         Ft3el141XdLcsbAJDM1iVIRAU2CSqniA7XmbEJB74LK8D0tIRDDk0/hPs1ykmldFrDBU
         zIgHdkrlxEWJCWfkZdWroaPiLVu5CJ3Ehc7ocamLwtBXniWzeWVPpiFEZDWVvVQnh5z1
         ZSviQOI9XhZtK3e6E+7X+imC6wRj17Sv0KD3ATOpTR6J9pkRDWU5XDUTVXTI58uoZ+Ip
         qLEPBi7L3OCfLubVVqoj/FOwmQdcWfWpKGAUliKF8tfX9Ce4VsqJx6g/X3vXvm5TtO+O
         0rXw==
X-Gm-Message-State: AOAM532i+cGpSS6bWvyas+uPq0fM+vHSHOmKWelObHDRUYljZeoRVnQU
        NIfy0fE1bNYay9CQ2BS1etvoMK4UY8zwzUYRltweh3KvCQ9sbFL6gBODWhXd1JlzAk0XvfSmBpi
        mQwsDywvX3H6XRh1EkA==
X-Received: by 2002:a17:90a:7848:: with SMTP id y8mr2374955pjl.223.1628745337701;
        Wed, 11 Aug 2021 22:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnKlbDDTcsbKGAYT1CJ31uy3bBooP2Q5c4Bdmf7TjKWiQThJ+t7g4TwKfD7k+UJcJp//WwRA==
X-Received: by 2002:a17:90a:7848:: with SMTP id y8mr2374934pjl.223.1628745337444;
        Wed, 11 Aug 2021 22:15:37 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l11sm1479689pfd.187.2021.08.11.22.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 22:15:36 -0700 (PDT)
Date:   Thu, 12 Aug 2021 13:34:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 1/3] generic: test xattr operations only
Message-ID: <20210812053452.7bz2qgnuhhgj7gl3@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, guaneryu@gmail.com,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me
References: <162743101932.3428896.8510279402246446036.stgit@magnolia>
 <162743102476.3428896.4543035331031604848.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162743102476.3428896.4543035331031604848.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 27, 2021 at 05:10:24PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Exercise extended attribute operations.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/724     |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/724.out |    2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/generic/724
>  create mode 100644 tests/generic/724.out
> 
> 
> diff --git a/tests/generic/724 b/tests/generic/724
> new file mode 100755
> index 00000000..b19f8f73
> --- /dev/null
> +++ b/tests/generic/724
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Oracle, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 724
> +#
> +# Run an extended attributes fsstress run with multiple threads to shake out
> +# bugs in the xattr code.
> +#
> +. ./common/preamble
> +_begin_fstest soak attr long_rw stress

Should we add this test into 'auto' group too?

> +
> +_cleanup()
> +{
> +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1

Can a "wait" command help more at here?

Others looks good to me.

Thanks,
Zorro

> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +
> +_require_scratch
> +_require_command "$KILLALL_PROG" "killall"
> +
> +echo "Silence is golden."
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((70000 * nr_cpus * TIME_FACTOR))
> +
> +args=('-z' '-S' 'c')
> +
> +# Do some directory tree modifications, but the bulk of this is geared towards
> +# exercising the xattr code, especially attr_set which can do up to 10k values.
> +for verb in unlink rmdir; do
> +	args+=('-f' "${verb}=1")
> +done
> +for verb in creat mkdir; do
> +	args+=('-f' "${verb}=2")
> +done
> +for verb in getfattr listfattr; do
> +	args+=('-f' "${verb}=3")
> +done
> +for verb in attr_remove removefattr; do
> +	args+=('-f' "${verb}=4")
> +done
> +args+=('-f' "setfattr=20")
> +args+=('-f' "attr_set=60")	# sets larger xattrs
> +
> +$FSSTRESS_PROG "${args[@]}" $FSSTRESS_AVOID -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus >> $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/724.out b/tests/generic/724.out
> new file mode 100644
> index 00000000..164cfffb
> --- /dev/null
> +++ b/tests/generic/724.out
> @@ -0,0 +1,2 @@
> +QA output created by 724
> +Silence is golden.
> 

