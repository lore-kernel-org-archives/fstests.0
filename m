Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3264EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 04:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiFUE2k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbiFUE2Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 00:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9393C63BB
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655785698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AX0MakS0IcTWBTzGIycUIcpbWwDZXgDpWGfkwzQQevk=;
        b=Mtvv0ktL2uG7iCIo2k8IWdETsXXsRuB86+8zDGYq4YtfXoW8H68jN30QTrX0DRBGQ/SjiK
        ensuq/47Wk03vEDuC6nE++4X53NydrSuVebEPAkr5EHs9+t8l1oSnx2LoIGWdm3Sle3Dga
        5ZFTvcEKYpn2icmzefO5l2TVpE34Pkg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-A_DPS0tXPhOr4U2gCgImeA-1; Tue, 21 Jun 2022 00:28:08 -0400
X-MC-Unique: A_DPS0tXPhOr4U2gCgImeA-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so15080854qkb.23
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AX0MakS0IcTWBTzGIycUIcpbWwDZXgDpWGfkwzQQevk=;
        b=W570GDmNy0VGjBhDk49V/XdzDbcljcbqKxkbBD1CnU4+O6W/5EK8yXiD2QqnG8ASjo
         k5fWcldFu9Y8dlKS2E52zNwZaIJDrH9wsEbNkGXKCyYuRR3FZ943AvAx+0mGbb1gMW/H
         M0YNGETHJgj9hJYTvZkYF3XfRDAoRUAYTPGneHOme+Lql+PszDKtC9H2xv+P9ItLng+g
         VVL5k42X40IZM5qE2LG3YkIBovC7386z+VC3XVBXMbrpqLu0VI63ooCvHEixYLPWlv3b
         TW4gdq6TPB+WoHk5s5lY/LhVQRSHTf/gflpFQfDP2HBGFOerPGe1F5xhKwVmtsEfHC1S
         965A==
X-Gm-Message-State: AJIora9p8HY6Efco4ywCXTsiUMP4oCWaqGfgXGmScGTiLFjMSzEn6UGb
        yhFvcZGZXDijgfJJpTrt0Sdq9mWy6UcC+1NG91nTD7yY+w1+tNFROaaqAqrNS/0hrlusx2zlLVo
        EF5h6jJid/OXbyUu2rw==
X-Received: by 2002:ac8:5783:0:b0:305:32:700d with SMTP id v3-20020ac85783000000b003050032700dmr22415866qta.31.1655785673181;
        Mon, 20 Jun 2022 21:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAvwYEsrRM8EqSfCE79iV16z4OO+cMwGaJylBEc5Zw0TVhWlT+GG3UYc7BhQMwnLoXugUN2w==
X-Received: by 2002:ac8:5783:0:b0:305:32:700d with SMTP id v3-20020ac85783000000b003050032700dmr22415860qta.31.1655785672909;
        Mon, 20 Jun 2022 21:27:52 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a000500b006a74458410csm13621270qki.123.2022.06.20.21.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 21:27:52 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:27:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs/122: escape %zu in printf with %% not \\%
Message-ID: <20220621042747.2i3gu7rlazfw6xud@zlang-mailbox>
References: <1655761411-11698-1-git-send-email-sandeen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655761411-11698-1-git-send-email-sandeen@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 04:43:31PM -0500, Eric Sandeen wrote:
> The standard way to escape % in a printf is with %%; although \\%zu
> seems to have worked in awk until recently, an upgrade on Fedora 36
> has started failing:
> 
> awk: cmd. line:1: (FILENAME=- FNR=1) fatal: not enough arguments to satisfy format string
>         'printf("sizeof(%s) = \%zu\n", sizeof(%s));
>     '
>                                               ^ ran out for this one
> Switching the escape to "%%" fixes this for me, and also works
> on my very old RHEL7 mcahine.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Make sense, thanks for fixing this.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/122 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index 5200615..18748e6 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -186,7 +186,7 @@ egrep '(} *xfs_.*_t|^struct xfs_[a-z0-9_]*$)' |\
>  egrep -v -f $tmp.ignore |\
>  sed -e 's/^.*}[[:space:]]*//g' -e 's/;.*$//g' -e 's/_t, /_t\n/g' |\
>  sort | uniq |\
> -awk '{printf("printf(\"sizeof(%s) = \\%zu\\n\", sizeof(%s));\n", $0, $0);}' |\
> +awk '{printf("printf(\"sizeof(%s) = %%zu\\n\", sizeof(%s));\n", $0, $0);}' |\
>  cat >> $cprog
>  
>  #
> @@ -199,7 +199,7 @@ awk '
>     /typedef struct xfs_sb/ { structon = 1; next }
>     structon && $2 ~ /^sb_/ { sub(/[;,]/,"",$2)
>                               sub(/XFSLABEL_MAX/,"12",$2)
> -                             printf("printf(\"offsetof(xfs_sb_t, %s) = \\%zu\\n\", offsetof(xfs_sb_t, %s));", $2, $2); next}
> +                             printf("printf(\"offsetof(xfs_sb_t, %s) = %%zu\\n\", offsetof(xfs_sb_t, %s));", $2, $2); next}
>     structon && /}/ { structon = 0; next}
>  '>>$cprog
>  
> -- 
> 1.8.3.1
> 

