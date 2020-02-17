Return-Path: <SRS0=4lTT=4F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449ACC35254
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195DD20578
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhKdg0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgBQMxa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:53:30 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41142 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBQMxa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 07:53:30 -0500
Received: by mail-pg1-f172.google.com with SMTP id 70so9092614pgf.8
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2020 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GzEkpFGHtoG4Jx2OPIZQeOeRmaWK9hTv6RfIrxoyULo=;
        b=DvhKdg0hHnP7XHxsHG1r3pIFeLLYReNkwU2HGOb2Fz2XPZz7zcb1BbZoAyQqHFHJLl
         0bpEhFDjjXzhK7qCEg4d95TQsh68PCVMntifLkHvsHC8MrnbW2pV42fIDNjSvrAFkeV4
         sYK+Wq9hnpx1q+McP5jjooMnuUD4P+MAfZRKJ5kibFVB7ZFZ8oo3t42JDenz2j1NxeVU
         IxtH6BdfFEjzw0bM8Z2BlqGwS/QDbDrUujGN5HhJ7+q63n5s8FvU+5RtNzLJz7YRQ9RR
         V7z+sltQJp3QiV9WIqwkBIluPDpV+S6d+hCBsTCEy9x/1t1EwQLm3PVFFSlCEl5mrerT
         XDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GzEkpFGHtoG4Jx2OPIZQeOeRmaWK9hTv6RfIrxoyULo=;
        b=onZlQg/QSBP+VgY45FPAlVIO1qVOo43xKntnEykWwFZMbAAL6628TOk2BYysOm0oJJ
         zCwa/5IVdxNs8ho/Z0k5/aZgftaA3ooKJYa1Qcq0cZSPyaOpz4YP5NWx4gRNG4K5uxKp
         kQVLS054LG+kXYAuuzcBnX6kPNGNWhrZ/7kEEZlPotbxL1QK8uSN8wJhL1kC8Sq+N5ug
         YtogcZliIqvhaV8bOednDiK3WoMlSCvau6vY8JzERFLnYeIGvv7ihYNDigEeGhEKBdqk
         TeeFzgXmDCerL4CZ7eOLBN4kIavifmNc8G0tizyUj7KP0erltVZv+ZK86bYuvF8fNoCW
         A4pA==
X-Gm-Message-State: APjAAAWt2UU3vaK1/tFI2jDCQVXsbI0wT0I9Z4TA7RwLzpZISSyCmYmX
        f7fhFsx6+bZFjas8127J4MS0HlKj
X-Google-Smtp-Source: APXvYqz3/UoLOpHorGggyZBn7f8d9ZKZvFxxjb0n+ZMtQbP+j3KGIwuRPJ2cxiYxsNBTO7mhiHgSOg==
X-Received: by 2002:a62:382:: with SMTP id 124mr17038483pfd.11.1581944008634;
        Mon, 17 Feb 2020 04:53:28 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id z64sm472350pfz.23.2020.02.17.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:53:28 -0800 (PST)
Date:   Mon, 17 Feb 2020 20:53:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     fstests@vger.kernel.org
Subject: Re: README: fsgqa needs a home directory too
Message-ID: <20200217125323.GL2697@desktop>
References: <alpine.DEB.2.22.395.2001311318390.2831@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.395.2001311318390.2831@trent.utfs.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 31, 2020 at 01:22:49PM -0800, Christian Kujau wrote:
> generic/128 whould fail with:
> 
>      QA output created by 128
>     +su: warning: cannot change directory to /home/fsgqa: No such file or directory
> 
> Adjust README to create a home directory too. And (totally unrelated), 
> fix the 404 for the udf_test tool.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>

Ok, your patch is missing the "---" below Signed-off-by line

---

above dashes make the patch appliable.

Thanks,
Eryu

> 
> --- README.orig	2020-01-12 08:43:34.000000000 -0800
> +++ README	2020-01-31 13:18:12.494026480 -0800
> @@ -19,7 +19,7 @@
>  	(Note that for RHEL and CentOS, you may need the EPEL repo.)
>  - run make
>  - run make install
> -- create fsgqa test user ("sudo useradd fsgqa")
> +- create fsgqa test user ("sudo useradd -m fsgqa")
>  - create fsgqa group ("sudo groupadd fsgqa")
>  - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
>  
> @@ -33,7 +33,7 @@
>      - install administrative tools specific to the filesystem you wish to test
>      - If you wish to run the udf components of the suite install
>        mkudffs. Also download and build the Philips UDF Verification Software
> -      from http://www.extra.research.philips.com/udf/, then copy the udf_test
> +      from https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
>        binary to xfstests/src/. If you wish to disable UDF verification test
>        set the environment variable DISABLE_UDF_TEST to 1.
>  
> 
> -- 
> BOFH excuse #220:
> 
> Someone thought The Big Red Button was a light switch.
