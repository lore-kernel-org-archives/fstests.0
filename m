Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC44C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Dec 2021 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhLYNkk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Dec 2021 08:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhLYNkk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Dec 2021 08:40:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718AC061401
        for <fstests@vger.kernel.org>; Sat, 25 Dec 2021 05:40:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o30so4404040wms.4
        for <fstests@vger.kernel.org>; Sat, 25 Dec 2021 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/+UBZRxb8+emhUV2y/ktpl+7+CGz9iTi1KhOhYDLNw=;
        b=qr8p10wiqMK/vwbEg/QA1zOP14g5cihP40WNBbxYXfTWIwFf5DdMlzRIo+wTaV2m2t
         0Fh/6mjZw6XYEqUbQElEfjt8EVc263AazseGI2HXBhLhpoYop10nkRKyr7xPs3d2AT7t
         yUc/2qJoU7MLnWYNkdS7tNeqSUoJ+H3p1WKQb8nYbJBugT5VpAXFuYs2tq0gUB+a1FdC
         TJQ30bkDwG6zt54AfN8psILGXY/SYM+joO1OfV/UIX7pfNPAcbkBvckhIG9BCJRh46bG
         UjCH00udmxnx8yK7jvrIvAVVbU+TxO0g4jSGERrWwbKxyWRNXSWCsiVYsi3SMwitPcY6
         4uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/+UBZRxb8+emhUV2y/ktpl+7+CGz9iTi1KhOhYDLNw=;
        b=19oeNrkG0Q0QwN0HaMxy1+BOPdfDb2IO6cL29/xaDp/y4Kd5dbSq8s8SWyPK+gDr3e
         fa4vnQKAKsFOATDPZKWNJoEDdhles9GJR1WGcE5FOtRcRTv8OHLQhHayfEGNhn1aVvPX
         S5t1zsUoptezw/pS5c1Xh+0Y1G5gZCho7bIzMnHFVqJwVeyM9g3huty6PCYCIqssRFHa
         GMRz9rF/x/LQ89h1Ekeb4ekKCMsaUZdQNpS89ooYCSjwAM4Xk1386Cu3MYvOcrl3J78O
         bbiwMYGoUS+SD0Vx9jc3EIGRRjlZQC9vNj+TjEhP+cGvPNt1lOR3MWd3X4mAA/1kzjdW
         +/Gw==
X-Gm-Message-State: AOAM530wnudV6b/o37SP2NtMDsAM4nAmzJ1eahxu8TPcdzHd/WFbxkb9
        4gmzCcsd3PaZx2QJSoXcmhNlO4klQBg=
X-Google-Smtp-Source: ABdhPJw/DKVZLG9LsnSN+DYDMjBccP4M3g3i25/HeofbuzKN46ria48NcqUAtJ5lr+m556cLMr6iAw==
X-Received: by 2002:a1c:9856:: with SMTP id a83mr7657794wme.157.1640439636091;
        Sat, 25 Dec 2021 05:40:36 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id d2sm10166412wrw.26.2021.12.25.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 05:40:35 -0800 (PST)
From:   Eryu Guan <guaneryu@gmail.com>
X-Google-Original-From: Eryu Guan <guan@eryu.me>
Date:   Sat, 25 Dec 2021 21:40:31 +0800
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 0/2] Add support for using liburing xattr
Message-ID: <YccfLmipMtygxja9@desktop>
References: <20211220181540.1557109-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220181540.1557109-1-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 20, 2021 at 10:15:38AM -0800, Stefan Roesch wrote:
> This adds support for using the xattr implementation in liburing.
> 
> Patch 1: fstress: add suport for using liburing setxattr
>   Uses the liburing setxattr implementation in fsstress.
> 
> Patch 2: fstress: add suport for using liburing getxattr
>   Uses the liburing getxattr implementation in fsstress.
> 
> There are two additional patch series related to this:
> - io_uring: add xattr support
> - liburing: add xattr support

I think it may take some time for distributions to pick up this liburing
xattr support, and before that we fail to compile fsstress due to
undefined functions as io_uring_prep_setxattr(). Maybe we should check
if current liburing supports xattr and otherwise use our local
implementation? So this patchset won't be blocked.

Thanks,
Eryu

> 
> ---
> V5: - fix some whitespace issues, order enum definition in correct
>       position and rebase
> V4: - fix a whitespace/tab issue
> V3: - Rebased patch series.
> V2: - Introduce dedicated functions for uring getxattr and
>       uring setxattr, so they are not automatically linked
>       in if liburing is available.
> 
> Stefan Roesch (2):
>   fstress: add suport for using liburing setxattr
>   fstress: add suport for using liburing getxattr
> 
>  ltp/fsstress.c | 244 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 177 insertions(+), 67 deletions(-)
> 
> 
> base-commit: 58e358032ac1f50acdb66615c04875d5375a6053
> -- 
> 2.30.2
