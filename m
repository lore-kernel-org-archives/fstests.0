Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63059C6FD1A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCGQ5Y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCGQ5D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:57:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C967B985
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66217B81985
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3200DC433EF;
        Tue,  7 Mar 2023 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207990;
        bh=w3131T5pAnU7IGW7oKhN/3jrpZnkdXZxPfvIkuE/tP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBoPkNnwhFUlQ1Ogfa45hrFNpCJeg5YFcCkoMTiNn0dfVhP0jss0zh0sQVv8Sr1OT
         tjjLPQ9klxIFd69TvavGa7FvCuY6K86bK1JfmfCOdYog7UDmrLQoK2lxxzXkMWYl8w
         finiJIem88t4j6w3/PUEugPO4Q85Jwz9bY1sowDFqehXUA0ZfS3HwTaxIEsoh4DcwM
         V2aA7doJ8QT95MFy2TeYlgCEfXJJsaSQ6ZJrLYn67Oqr8M6w+MSLDkWbabFBMU2xkj
         25Pl7pFsOGXvazSw/eQqX25IDll2xi4+WRocqYH5ufnok5bRO0XYPNtWANHOR3YPX8
         MYERZSweCRqyA==
Date:   Tue, 7 Mar 2023 17:53:06 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 09/11] vfs: Add DIR0 constant
Message-ID: <20230307165306.2mvrdu4qlor7n56w@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-10-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-10-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:05PM +0100, Rodrigo Campos wrote:
> This will be used by tests that call other tests within themselves.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  src/vfs/utils.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git src/vfs/utils.h src/vfs/utils.h
> index 4c796559..c52a0738 100644
> --- src/vfs/utils.h
> +++ src/vfs/utils.h
> @@ -45,6 +45,8 @@
>  #define DIR2 "dir2"
>  #define DIR3 "dir3"
>  #define DIR1_RENAME "dir1_rename"
> +// This directory may be used by tests that call another test.
> +#define DIR0 "dir0"

I think you can fold that into whatever patch is using this, same for
the addition of t->in_user_ns thing...
