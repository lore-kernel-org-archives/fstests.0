Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F177C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF56109E
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 14:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhJLOaY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:30:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhJLOaY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Oct 2021 10:30:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59DB0221AA;
        Tue, 12 Oct 2021 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634048891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7rzgBoDd9669Tf6AFwWQEzH3g29Eiw5qpX/Qr4I+dA=;
        b=WrV6tNZNcmrJEpIKjYl6qCH8SEqGY8vjj5ZNT+2fojpBTP7eUb7E4cuw6AGHytqG1eEgpG
        hqomkQTSS8Om33sSrpqQj0yduKhXj52zifLhGubCGfN16LHpxoZa2v/Wn/GzRa4QKkoqv7
        ZDBZGkDoUV/p4au7N4VkF1uZ6dkL+xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634048891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7rzgBoDd9669Tf6AFwWQEzH3g29Eiw5qpX/Qr4I+dA=;
        b=CoYNq9HTa17/PMJ472LgnpNIaMXv2xw56IieyOrHvdQ08xMHUgZwFOHDEJc7MwJapgYPO0
        7V4C8o2+Lyh4LNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3365113BEC;
        Tue, 12 Oct 2021 14:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L8VSC3ubZWFvBwAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 12 Oct 2021 14:28:11 +0000
Date:   Tue, 12 Oct 2021 16:28:10 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] build: remove unused AC_PACKAGE_NEED_OPEN_BY_FSHANDLE
 macro
Message-ID: <20211012162810.2e6b05c6@suse.de>
In-Reply-To: <20211012135057.25689-1-ailiop@suse.com>
References: <20211012135057.25689-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 12 Oct 2021 15:50:57 +0200, Anthony Iliopoulos wrote:

> Commit 5868405dce1d ("Sync up different copies of the m4 macros, noop
> change for this package.") introduced this macro, by the function was
Nit: s/by the/but the/ above. Looks fine otherwise...
> never really used by any test, remove it.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>
