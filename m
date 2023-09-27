Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE98E80AB3
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Sep 2023 14:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjI0ObJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Sep 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjI0ObI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2023 10:31:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DFCE8
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 07:30:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCC3C433C8;
        Wed, 27 Sep 2023 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825054;
        bh=by+QWaO+9ZvCcB2QzKuozRechZIRl+dHz1k+3siCXzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiCxws46+Wz6Djzr9Ug3SRuwSG6b+SI0pWReZqas8CR/WHoJJY53PLYQwd1fJoGtE
         xATpNptASozvcxgSXkSjsWWJV7/58721+Ov45f9CZKXXicPan+n+BW4v5hnu/hYful
         uydghD6GKWDCE+ga3TPqxlrg4r1ILZxV7p3tNznppqD/lVp/XQjqPEIw2VUu0ksWcN
         2lUAiY09ApxpYtfrHBRnKqRAtUCmBvTsgI+75f8uYf9bpGo4p8QPRlDXzqoYO0c4mc
         9AQTUWG/q2LKAvdZYY2He7Fqg+IsWolmnW6oJOA2lDFgGVBegOcVnHTjv9LADiBsc3
         xQspUk9sa3gnA==
Date:   Wed, 27 Sep 2023 07:30:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Vyacheslav Yurkov <uvv.mail@gmail.com>
Cc:     fstests@vger.kernel.org, Khem Raj <raj.khem@gmail.com>,
        Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] fsx: Add a return type to aio_rw
Message-ID: <20230927143053.GC11423@frogsfrogsfrogs>
References: <20230927131617.100908-1-uvv.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927131617.100908-1-uvv.mail@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 27, 2023 at 03:16:17PM +0200, Vyacheslav Yurkov wrote:
> From: Khem Raj <raj.khem@gmail.com>
> 
> Compilers complain about the function prototype otherwise
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Vyacheslav Yurkov <uvv.mail@gmail.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Zorro Lang <zlang@redhat.com>

Whoooops, good catch!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  ltp/fsx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index ccb382e7..a30e2a8d 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2592,6 +2592,7 @@ out_error:
>  	return -1;
>  }
>  #else
> +int
>  aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  {
>  	fprintf(stderr, "io_rw: need AIO support!\n");
> -- 
> 2.35.1
> 
