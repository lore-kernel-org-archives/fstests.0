Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC4C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Nov 2022 16:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiK1QFP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiK1QFN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2022 11:05:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE71D663
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:05:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id g10so7564735qkl.6
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm82NvcJJ0TxIYxxYEelbagbGPMEJqHr0oesk9tE2nc=;
        b=5VrvLLvjqdFh2WYlS7m/ryvM/KefenAEGp1DPVzuFStoHGqka3L20RfLDZa3RgKIsL
         jwf4LtBpc6MQ/BE6hybtoaIfWSlM04gquWJOjPqmuEQhLNdaIEmu4HY1GKS2YlFwbzvK
         25u9D18BV/+g61wV2aHnSN3cS4hKG4NyI+DpPBFFV5P2hbVxxMW/GtWOKeedm/GJ1W30
         gUjb8GCpG6uIj+eCNvvNt0Z8Mc00aquN2pDO9+5TDHMCUU+v/h8625yjZFDYZ3FlZ3NW
         1IlJESnUhoPcfCLR2bC5NjPKQSsn7g1UAttz2fXCIRLpiK0esbtC4S/iqrSbjwB6Gsd6
         9RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm82NvcJJ0TxIYxxYEelbagbGPMEJqHr0oesk9tE2nc=;
        b=ClmE5vvG4d3nnr8G73hdzcjr+SWj33Sa1TP9oZWIaQY1eXpAcwFTiDdUi3BnlKWN3L
         6C/X+3+nheB9XiRmcw0+YBSRdBTdI+fv8U170W9pCM9sSOR7JJyl7ZcL8P3tnIjTGQBd
         QZJBUjA69I0bLaqq2hL72CZirO85ygYOWxd6h3B/l7fnt+KnxKuwBrwcBa8sOc7S9+ns
         XnLSOdIhsD0MBIN5przYyh89q0Ahb9uS3JE9JZIzoIVQQBUsxXefA7a3K4rCtHheA1Ov
         BaKGjuzDldfg8iACLq1BMtkP+KI1BY8ygunfKliZYBxdvdkI2rVJYBorCdNXCvuPeevW
         y5Rg==
X-Gm-Message-State: ANoB5pncSn457SmdQcouD9MUNvncfT2EnhcpYXcd41f1fKFOhxlHdeEO
        /LX3CHJDlpqhaU4iYNEpcJdjzg==
X-Google-Smtp-Source: AA0mqf40qPHG7nDHyLejwqfBGVWPykNYrd8qg2I2zuEdkHUYsZM8mtoXWflz0H7wWdeORfO0onK47A==
X-Received: by 2002:a37:acd:0:b0:6ee:9097:ccc1 with SMTP id 196-20020a370acd000000b006ee9097ccc1mr46895930qkk.484.1669651511230;
        Mon, 28 Nov 2022 08:05:11 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l18-20020ac848d2000000b0035ce8965045sm7109676qtr.42.2022.11.28.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:05:10 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:05:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] fstests/btrfs: add a test case for send v2 and an
 update
Message-ID: <Y4TcNbwq4DXfP3Ac@localhost.localdomain>
References: <cover.1669636339.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669636339.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 28, 2022 at 12:07:20PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This adds a test case specific for send v2 with some preparatory work in
> order to allow for that. Support for v2 send streams was added in
> btrfs-progs v5.19 and the kernel support introduced with kernel 6.0.
> 
> More send v2 specific tests will be added later.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the whole series, thanks,

Josef
