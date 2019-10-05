Return-Path: <SRS0=KtmJ=X6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26999C4740A
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Oct 2019 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2221222CB
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Oct 2019 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiCDdDpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfJETHw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:07:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44412 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJETHw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Oct 2019 15:07:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so5898751pfn.11
        for <fstests@vger.kernel.org>; Sat, 05 Oct 2019 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djdMH5GaLBUctsqFiVphAGq64s7l+iDu5SpEiRynbDw=;
        b=oiCDdDpbtwVPCGtjENL1MsfEjQOvp3U5NZoN5zfti2JxGXZNEzPDEosBHXusH3sHi3
         M8LYgWsxiM5YOfLdQPvItM6Ur1if0ugEDwoC9FfczGlw8NDtmUComldrE4Es+37H/Iz9
         7aJgDnYSdVENBYhrPDczCkjSqTNC5feqehoJDEaGMielWUbdzrvwrN1YR9p/TsIFkDiK
         0zkm+RzkDKQo1Zys2UTnd0W+WZvg+Yd2xaMdjUPklkf5BX8aYi4hM0wYWKD9oWFJgMl+
         TADSc1h7UsbujJ6DFRCO0zcBTThnLaCrSDyVPm/gmS/MVnlxg4AOEC4hRh0GJvkkUNdG
         swOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djdMH5GaLBUctsqFiVphAGq64s7l+iDu5SpEiRynbDw=;
        b=BlGnQTbqHGf4XLhjoM20NtdBLig2gWF0yBJmR67YZAX6LoXd0znkFk55OhMKkHsI7O
         DnbwBptYqp1/BCEdwanjlbUYEXcAJ6E5hWUXa5EVp/WHEtalhzL99o73Zm5NHz2Faadm
         LwKgxys2OFmuWL/v5l0sHNYMWFpBp2JHWpMEylretHX6WHT9TsqPMjOffWf58dDqwbGY
         d/Xdzhx24Fun1mlvV6sZXDGwev1WCo1RYo91QZHknLTY2Gx8QVIasYRIVeFfop48n65e
         LvJ73WL434PZyxou5Kjb9b/3ilOAyu40zJbsUDe5StG3tfZnSCRu7Zm2b3rwziUDHLJk
         ofWA==
X-Gm-Message-State: APjAAAX5GrOjYEirbtfHbPiCXBqGhUjXU6e+VXwbcc8KFXgETpjvfBb9
        AXpDdbm8yteEItnJkz2YYz8=
X-Google-Smtp-Source: APXvYqwgUDAwD3Iqz/77j6sPT7GSuqpDFrMQx2aD9fQ96PC1gjotNJ8L+gO/FwDEAU8sN3IKAgrhjQ==
X-Received: by 2002:a63:c904:: with SMTP id o4mr9786887pgg.388.1570302471366;
        Sat, 05 Oct 2019 12:07:51 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r28sm11613007pfg.62.2019.10.05.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 12:07:49 -0700 (PDT)
Date:   Sun, 6 Oct 2019 03:07:44 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] fsx: add more check for copy_file_range
Message-ID: <20191005190741.GF2622@desktop>
References: <1569549234-13096-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569549234-13096-1-git-send-email-suyj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 27, 2019 at 09:53:54AM +0800, Su Yanjun wrote:
> On some linux distros(RHEL7, centos 7) copy_file_range uses
> general implementation (splice interface). splice interace
> uses pipe_to_file. pipe_to_file only work for different page.
> The userspace cant's be  aware of such error because copy_file_range
> returns ok too.
> So for such case when copy_file_range return we read back data
> then check it.
> 
> Also add check for do_clone_range following Eryu's advice.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
> v2:
> - Use check_buffers instead memcmp code
> - Add check for do_clone_range
> - Fix return unique error number for the check code

I just noticed that fsx already has an option (-X) to control check file
content or not after each test, which calls check_buffers().

Would you please check if adding '-X' option to fsx could reproduce the
copy_file_range bug on RHEL7? If so, perhaps we should add a new test
which is similar to generic/522 but does content check. Or just add '-X'
to generic/52[12]?

/me copies Darrick and hopes he could share his thoughts.

Thanks,
Eryu

> ---
>  ltp/fsx.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4..714bebc 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1378,6 +1378,7 @@ test_clone_range(void)
>  void
>  do_clone_range(unsigned offset, unsigned length, unsigned dest)
>  {
> +	int ret = 0;
>  	struct file_clone_range	fcr = {
>  		.src_fd = fd,
>  		.src_offset = offset,
> @@ -1429,6 +1430,23 @@ do_clone_range(unsigned offset, unsigned length, unsigned dest)
>  		memset(good_buf + file_size, '\0', dest - file_size);
>  	if (dest + length > file_size)
>  		file_size = dest + length;
> +
> +	ret = lseek(fd, (off_t)dest, SEEK_SET);
> +	if (ret == (off_t)-1) {
> +		prterr("do_clone_range: lseek");
> +		report_failure(162);
> +	}
> +	ret = fsxread(fd, temp_buf, length, dest);
> +	if (ret != length) {
> +		if (ret == -1)
> +			prterr("do_clone_range: read");
> +		else
> +			prt("short read: 0x%x bytes instead of 0x%x\n",
> +				ret, length);
> +		report_failure(163);
> +	}
> +	check_buffers(temp_buf, dest, length);
> +
>  }
>  
>  #else
> @@ -1602,6 +1620,7 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>  	size_t olen;
>  	ssize_t nr;
>  	int tries = 0;
> +	int ret = 0;
>  
>  	if (length == 0) {
>  		if (!quiet && testcalls > simulatedopcount)
> @@ -1665,6 +1684,22 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>  		memset(good_buf + file_size, '\0', dest - file_size);
>  	if (dest + length > file_size)
>  		file_size = dest + length;
> +
> +	ret = lseek(fd, (off_t)dest, SEEK_SET);
> +	if (ret == (off_t)-1) {
> +		prterr("do_copy_range: lseek");
> +		report_failure(162);
> +	}
> +	ret = fsxread(fd, temp_buf, length, dest);
> +	if (ret != length) {
> +		if (ret == -1)
> +			prterr("do_copy_range: read");
> +		else
> +			prt("short read: 0x%x bytes instead of 0x%x\n",
> +				ret, length);
> +		report_failure(163);
> +	}
> +	check_buffers(temp_buf, dest, length);
>  }
>  
>  #else
> -- 
> 2.7.4
> 
> 
> 
