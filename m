Return-Path: <SRS0=4lTT=4F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB5CC35254
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A92072C
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgxoC5rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgBQMrr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:47:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgBQMrr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 07:47:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id v23so5700669pgk.2
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2020 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KZni8Pe7xXJkd+075dL1zMr21+ZRDZ3BhF9EBUCWZA=;
        b=BgxoC5rPh0BLwLVqur1qeL/7zzHzWzsZbES1tC3OzBkZ6otNdvWcxfHK9LA0bfukBv
         yiNrSAfREkOU58tOAOm6+e+jHEwblGfPGnAvY3g0rv0wFaMQ92ntUijGlp4CmtKmM3a7
         qidktqVZE5h26lCQCHTUQvM39GoTEKewk0mMSryDaCFPovyIwUwoPmph63nRabGmHnMP
         6uh9IOtW0aK0pz+gg5ovIL3vH2ejL/Od/aNJTc+PHxqAhEMVL8A2+CLevK3N9hTh9JoI
         Kr6+JjdwKMGjDYxly5CTMVtvQ3GeGu7gJp2yJQU/xglZ42wpjY0kgs5XqZJ6QGyHhbFY
         fbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KZni8Pe7xXJkd+075dL1zMr21+ZRDZ3BhF9EBUCWZA=;
        b=LQ2addIVfJY1UGYu9D2zeiPDNRbZi7HII76vEpbLbNX4H+BsWQb4G77UyTXT1mkKll
         cp1ZVQhD1kd89ktIO2HTrSLl9rC+JpGxGhut0SM6QQ96dMF6SdoxXMFXix84KTYJkqkH
         X+JMlI9d67alMfOwljpgWCYX8b4F8GLG1nqP95mCZAvqU/R2PoDPaS9jOYyrMNMGFrNF
         CVlG9GCJRraUElTLRvkqCj79feIjesSzaLQKJkpo5yMqUBADc9dnNCPl1eb9lpuBdiXk
         ykP7v/IVZ8pmvQ2cv7Ocg6o9qR8obcIoxpYvEhGkgEMXcf3qROLpaf7RJWntAegri6Nj
         hEXA==
X-Gm-Message-State: APjAAAXke4neuuyx1j5dQkPEuUlk4omc7X4H9kKZOTiu+IRB/Chee76z
        t9OchYkBVfFzLXMpjAjyczI=
X-Google-Smtp-Source: APXvYqxpo443U79XzmCFYgr3pJRfkTvMaKIkMlJOa0zzZ3+gqIml6QXo9Q5hrqnxy7b0gwG2txsHGg==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr16223265pfi.129.1581943667058;
        Mon, 17 Feb 2020 04:47:47 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id u3sm479506pjv.32.2020.02.17.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:47:46 -0800 (PST)
Date:   Mon, 17 Feb 2020 20:47:41 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     fstests@vger.kernel.org
Subject: Re: shared/032: add options for reiser4
Message-ID: <20200217124738.GK2697@desktop>
References: <alpine.DEB.2.22.395.2001311244100.2831@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.395.2001311244100.2831@trent.utfs.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 31, 2020 at 12:55:47PM -0800, Christian Kujau wrote:
> Last night I had xfstests running and after a while it hung at shared/032 
> because I had reiser4progs installed and it was waiting for input:
> 
> -----------------------------------------------------------------
> mkfs -t reiser4 /dev/ram0
> mkfs.reiser4 1.2.1
> Format release: 4.0.2
> Copyright (C) 2001-2005 by Hans Reiser, licensing governed by 
> reiser4progs/COPYING. 
> 
> Block size 4096 will be used.                                                                                                                                                                         
> Linux 5.5.0-rc5-amd64 is detected.                                                                                                                                                                    
> Uuid 2006a590-832a-49f5-9317-cf91bf866dd7 will be used.                                                                                                                                               
> Reiser4 is going to be created on /dev/ram0.                                                                                                                                                          
> (Yes/No): 
> -----------------------------------------------------------------
> 
> The patch below adds an option (cf. reiserfs the line above) so that the 
> test continues.
> 
> Curiously enough the test still "succeeds" for reiser{fs,4} (and jfs too) 
> because the userspace tools don't appear to have a routine to check for 
> "contains an existing filesystem", but that could be addressed in a 
> different patch.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>

Thanks for the patch! But This patch cannot be applied, seems the format
is wrong.

But it's easy enough to apply manually, just please make sure the patch
format is correct next time.

Thanks,
Eryu

> 
> --- tests/shared/032.orig	2020-01-12 08:43:34.000000000 -0800
> +++ tests/shared/032	2020-01-31 12:30:27.158763104 -0800
> @@ -49,6 +49,7 @@
>  	[ $fs = gfs ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
>  	[ $fs = gfs2 ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
>  	[ $fs = reiserfs ] && preop="echo y |" && preargs="-f"
> +	[ $fs = reiser4 ] && preop="echo y |" && preargs="-f"
>  	# cramfs mkfs requires a directory argument
>  	[ $fs = cramfs ] && preargs=/proc/fs
>  	[ $fs = ext2 ] && preargs="-F"
> 
> -- 
> BOFH excuse #164:
> 
> root rot
