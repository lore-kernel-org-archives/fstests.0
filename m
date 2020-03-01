Return-Path: <SRS0=Ppg5=4S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB6C3F2CD
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Mar 2020 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEA8214DB
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Mar 2020 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgkiT4Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAOcg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:32:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40924 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCAOcg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Mar 2020 09:32:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3134873plp.7
        for <fstests@vger.kernel.org>; Sun, 01 Mar 2020 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7TdYTQRsr0Sh0r1qmrmkLs4I3Br1sZPGBdDUy6DUkO0=;
        b=qgkiT4KeauoHWKrTw7vxAf4wtuakCyyhTEjesr39LmRAcyRmXCY7JIrqbIlJAjp4GG
         2ILOVpFo/7935QLCZB/6CeKKuQtQHzQduPOiph9V0JJs5Ns2YNKbUjLZpB/A4kt+Cjb0
         gJ4w+6//tSKl3dNlRIf5yG0LAWIwp4MITh99NWpmavifnOFj0jTvi5diwNUvVIZpd1K7
         G4eQ61naGXDC+caj7+2cpDrN2mgNRnOc4pnEgSBNdu8fPHNgdkMqcbwW+pdMtE9FR5Px
         qbpF2jO2hMSPSBXEMqQkytU5v2sAfTdlwqzngca3YYmpfbr7TzYYVwAo5tcMAhbXCxaj
         cXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7TdYTQRsr0Sh0r1qmrmkLs4I3Br1sZPGBdDUy6DUkO0=;
        b=PiFSUNNMx199W2ElCowWaFZWL+IbjRHqYPTR1+s10Ix8R766T4prgBHFOTe/eWnLS2
         d29KospTt0utfyByFYZsqSYMAvEfC5cP4KJehoe/Mwna/2MyPm81FSnbJ3Jo72wyHyp7
         cBF406q8svT9UK5/XqgYj6+zmcueJf0wXZWGtBWubTtDP9K5bmY9M7LWnoz5chsnmsgP
         KOK/QwFS5KcOKi24NjFlNVASqw1ueRG9QEZv+G3MPAEcdLNRTyEfaBRnMtSDYmzCyno/
         rB7y3AmaFPXBFYlnZEtMBfaqcXJe4dzh4MSS5ykI0o/rR+NxXINCt/7zxrV0Ktsa5sOV
         A3zA==
X-Gm-Message-State: APjAAAVviEGyYvIPIjeZwo30pLKJg0r3kEM5ZOGBBCM06EfSZcAVIRlF
        aDrAngChvFCfyfGdEpdRwQ4=
X-Google-Smtp-Source: APXvYqws/hr5ZVOnIVrJ5HE6gWO53ezbU8ZuivlHgD6cF8XWphETaLzXcNVrPiYP//z/8Zm1yOI3eA==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr13030239plp.339.1583073155087;
        Sun, 01 Mar 2020 06:32:35 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r9sm17864209pfl.136.2020.03.01.06.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 06:32:34 -0800 (PST)
Date:   Sun, 1 Mar 2020 22:32:26 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH] xfstests: remove generic/484
Message-ID: <20200301143222.GL3840@desktop>
References: <20200224222926.694991-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224222926.694991-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:26PM -0800, Christoph Hellwig wrote:
> Generic/484 tests functionality that isn't really related to file
> systems, and has failed every since it was added.  Remove it as it
> serves no puropse in xfstests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I also removed src/t_locks_execve.c which is used only by this test, and
its entries in src/Makefile & .gitignore file.

Thanks,
Eryu
