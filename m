Return-Path: <SRS0=ooC1=BT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2231CC433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Aug 2020 17:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D813E206B5
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Aug 2020 17:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JdJ7J5GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHIRvu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIRvs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Aug 2020 13:51:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A092C061756
        for <fstests@vger.kernel.org>; Sun,  9 Aug 2020 10:51:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so3901204pfl.11
        for <fstests@vger.kernel.org>; Sun, 09 Aug 2020 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=20HS+caHKeu9Iu8fm58ujpO+36FJL4cghPYNh95fEpc=;
        b=JdJ7J5GBx0A0H/89DvDGeDtZt1Otjei7Qd98WyxJ/FCdlp5nPrsDvRT9gfsHBQN4GO
         mWkQDUPocH67Pyw6SvD5R58PF0W6/2sxhrqOxb9Mm2D4AWj2enyO9UMmA5c9pjk71af4
         r6tclNpvaXmeOewADMOkUiwj2FjQ9WTPjJe3JnKarSe48BcPnZOfeLDQJHswusEiisQg
         pP7ZnTNGxJmL+jNgMPFlTi+F+5dRGABbCBgp0gtKDJ/0taS4pyGiiUB1Ooa5w0eJdj0e
         N3ZB3/RDS1W+CAPFS1aDIBbG2CFpGmOGFtw/AguvBOCFq1twDdCYZ5sW5mhDZmOmYrbo
         YCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=20HS+caHKeu9Iu8fm58ujpO+36FJL4cghPYNh95fEpc=;
        b=OQGhMGfo01QVFUUfdhNAxJcF3cOhbKWaItkn4bYpysInaAK9aGD2g0KTmbRmTe8DoW
         bsACV8CFd0m6SXLvlFMDWndWsHlpvy57kXKjGvSgvLJuM7j37/wONa9ML0t5lx6Zl80P
         gmTiF2cDuZ09cUupRCdZfxodhLb1IS/Js8Cprqo61FU33IXXIQD0C4PlX6mBcAizm1Hd
         gQoFsYzFmXysXCuPAZ6KnlZ/G29INCEZt1HcrDhrGvpbIbeRhytXnyu+XJHOPX5+K0F7
         TIL1245tg/K4N7MJtN7zVJSqPnL4Sdir6Hnj8Mi2hten5bOkh8Nq/7pSVc+C9AN/teqr
         Ugdg==
X-Gm-Message-State: AOAM531xz4R68fe1XLIkDlMBZcWuGFn4EFpMbjMN7TrC+m9xjOGlK3yE
        IIBEY2Na+D9Vjq3yH3nhtWOp5eUI5iQ=
X-Google-Smtp-Source: ABdhPJyigKeyJoKUtt7iXKTBAy8LPHN5US/HnSela1UdacXTjF0xf2oPEWFIrl6ZUvUL419v5VlLYw==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr23197126pfm.34.1596995507644;
        Sun, 09 Aug 2020 10:51:47 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e125sm19546799pfh.69.2020.08.09.10.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 10:51:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fsstress: add IO_URING read and write operations
To:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc:     io-uring@vger.kernel.org, jmoyer@redhat.com
References: <20200809063040.15521-1-zlang@redhat.com>
 <20200809063040.15521-2-zlang@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01c7353f-338b-99cd-d7d1-fe92b0badd84@kernel.dk>
Date:   Sun, 9 Aug 2020 11:51:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809063040.15521-2-zlang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/9/20 12:30 AM, Zorro Lang wrote:
> @@ -2170,6 +2189,108 @@ do_aio_rw(int opno, long r, int flags)
>  }
>  #endif
>  
> +#ifdef URING
> +void
> +do_uring_rw(int opno, long r, int flags)
> +{
> +	char		*buf;
> +	int		e;
> +	pathname_t	f;
> +	int		fd;
> +	size_t		len;
> +	int64_t		lr;
> +	off64_t		off;
> +	struct stat64	stb;
> +	int		v;
> +	char		st[1024];
> +	struct io_uring_sqe	*sqe;
> +	struct io_uring_cqe	*cqe;
> +	struct iovec	iovec;
> +	int		iswrite = (flags & (O_WRONLY | O_RDWR)) ? 1 : 0;
> +
> +	init_pathname(&f);
> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - no filename\n", procid, opno);
> +		goto uring_out3;
> +	}
> +	fd = open_path(&f, flags);
> +	e = fd < 0 ? errno : 0;
> +	check_cwd();
> +	if (fd < 0) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - open %s failed %d\n",
> +			       procid, opno, f.path, e);
> +		goto uring_out3;
> +	}
> +	if (fstat64(fd, &stb) < 0) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - fstat64 %s failed %d\n",
> +			       procid, opno, f.path, errno);
> +		goto uring_out2;
> +	}
> +	inode_info(st, sizeof(st), &stb, v);
> +	if (!iswrite && stb.st_size == 0) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - %s%s zero size\n", procid, opno,
> +			       f.path, st);
> +		goto uring_out2;
> +	}
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - io_uring_get_sqe failed\n",
> +			       procid, opno);
> +		goto uring_out2;
> +	}
> +	lr = ((int64_t)random() << 32) + random();
> +	len = (random() % FILELEN_MAX) + 1;
> +	buf = malloc(len);
> +	if (!buf) {
> +		if (v)
> +			printf("%d/%d: do_uring_rw - malloc failed\n",
> +			       procid, opno);
> +		goto uring_out2;
> +	}
> +	iovec.iov_base = buf;
> +	iovec.iov_len = len;
> +	if (iswrite) {
> +		off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
> +		off %= maxfsize;
> +		memset(buf, nameseq & 0xff, len);
> +		io_uring_prep_writev(sqe, fd, &iovec, 1, off);
> +	} else {
> +		off = (off64_t)(lr % stb.st_size);
> +		io_uring_prep_readv(sqe, fd, &iovec, 1, off);
> +	}
> +
> +	if ((e = io_uring_submit(&ring)) != 1) {
> +		if (v)
> +			printf("%d/%d: %s - io_uring_submit failed %d\n", procid, opno,
> +			       iswrite ? "uring_write" : "uring_read", e);
> +		goto uring_out1;
> +	}
> +	if ((e = io_uring_wait_cqe(&ring, &cqe)) < 0) {
> +		if (v)
> +			printf("%d/%d: %s - io_uring_wait_cqe failed %d\n", procid, opno,
> +			       iswrite ? "uring_write" : "uring_read", e);
> +		goto uring_out1;
> +	}

You could use io_uring_submit_and_wait() here, that'll save a system
call for sync IO. Same comment goes for 4/4.

Apart from that, looks pretty straight forward to me.

-- 
Jens Axboe

