Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E578C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 15:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiLMPbr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiLMPbq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 10:31:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5213F6A
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 07:31:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4C1822B6D;
        Tue, 13 Dec 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670945504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqLoxTuwyBPQtTar7Nqj+Mp5Uy4Gwvw0BnMj0w9la5E=;
        b=RK6GY5Fbv9IiL5j9VLNYNS4qQBfdbwT48a5gMc3mOP8Y1e3wPueVH2Sgns33xFW/7u7rrK
        2+iHZ5J43vmb3fUddmzd+1V8qFT8ebqWwVA21KBC2QD7V+dUHSIt6GdsdlTuhJIFGme5QT
        XnM9pG9hL2EwFYA+NP7PbpEdfMsS2qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670945504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqLoxTuwyBPQtTar7Nqj+Mp5Uy4Gwvw0BnMj0w9la5E=;
        b=I5z6mYdlPB+cHDrAssOtHK5NvFG4E792atAlc7+s21XxM/gIiC1uIH6bafLJT7eKcYhNOR
        H7STyzCdcjMqX0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ADED138EE;
        Tue, 13 Dec 2022 15:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LSNjJOCamGPRGAAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 13 Dec 2022 15:31:44 +0000
Date:   Tue, 13 Dec 2022 16:32:34 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/3] common/attr: require xfs_spaceman for xfs
 acl_get_max
Message-ID: <20221213163234.5ed9cfec@echidna.fritz.box>
In-Reply-To: <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
References: <20221212230820.3466-1-ddiss@suse.de>
        <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 13 Dec 2022 22:41:52 +0800, Zorro Lang wrote:

> Hmm.. That's weird, both xfs_info and xfs_spaceman are from xfsprogs
> package. If someone xfsprogs version doesn't hasve provide xfs_spaceman,
> why its xfs_info would like to call that? What xfsprogs do you use?

I have a hacky bunch of scripts that use Dracut to generate an
initramfs image with minimal dependencies for xfstests alongside the
test kernel: https://github.com/rapido-linux/rapido

The rapido dependency list is now fixed, but I figured that this change
makes sense given the other scattered _require_X checks for xfsprogs
binaries. Feel free to drop this change if you don't agree.

Cheers, David
