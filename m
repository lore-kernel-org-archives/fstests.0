Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC653C433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DB4650BC
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhCARkB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:40:01 -0500
Received: from verein.lst.de ([213.95.11.211]:54900 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238476AbhCARdg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 1 Mar 2021 12:33:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C2C9E68BEB; Mon,  1 Mar 2021 18:32:51 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:32:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic/624: add fstests for idmapped mounts
Message-ID: <20210301173251.GA5375@lst.de>
References: <20210301151712.1994033-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301151712.1994033-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> +# Modify as appropriate.
> +_supported_fs ext4 xfs

I think this should be

_supported_fs generic

now that we do the probing for the actual support, and any file system
not supporting it will just do a _notrun from _require_idmapped_mounts.

Also the comment above this line should be dropped.
