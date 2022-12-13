Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB8C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiLMTHt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiLMTHq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 14:07:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB226E0
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 11:07:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C06AD1FDD9;
        Tue, 13 Dec 2022 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670958461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFS9mKcusTfY8MPt4VPU7BUErjsqx2H88N1Y4yLdaaw=;
        b=KdWiosMZpk8slF19QF7pv++y1sjtLSMe25+KHQJ4GGqJ4Wjxs2X5v5/hDbc9MRZ79u4bwY
        5cJ1M/Xa/z9CgfqPMIksj/40d+nMGnJQbvG+wzeFqQUr7LHcpEwGdPMU1MZfuBcO1dxE8X
        bey1aQeOw0h3cD+FpFM7VZusE/Ob9wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670958461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFS9mKcusTfY8MPt4VPU7BUErjsqx2H88N1Y4yLdaaw=;
        b=HWM2wv1bcSX5/GrfSfABEEi5FWNCwQB/sOnmVGDXtm31ozWC7fI54Stfs9pox6rtsMCJLD
        cNykFfAbIULQr1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94097138F9;
        Tue, 13 Dec 2022 19:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3Jd9In3NmGNVBwAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 13 Dec 2022 19:07:41 +0000
Date:   Tue, 13 Dec 2022 20:08:31 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/3] common/attr: require xfs_spaceman for xfs
 acl_get_max
Message-ID: <20221213200831.427fb98a@echidna.fritz.box>
In-Reply-To: <20221213182531.3aqgjfzhjoaomy2k@zlang-mailbox>
References: <20221212230820.3466-1-ddiss@suse.de>
        <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
        <20221213163234.5ed9cfec@echidna.fritz.box>
        <20221213182531.3aqgjfzhjoaomy2k@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 14 Dec 2022 02:25:31 +0800, Zorro Lang wrote:

> We should let xfsprogs decide how xfs_info works. xfs_info doesn't always
> depends on xfs_spaceman, old xfs_info might use xfs_db or other things to
> get xfs info, and I don't know if it'll be changed to use other command in
> the future again.
> 
> So this change will cause all cases which call _require_acl_get_max will notrun
> on old (maybe future) xfsprogs which doesn't has xfs_spaceman "info" command.
> I think that's not what we want, so I'd like to drop this patch. Thanks for
> your understanding.

I wasn't aware that the xfs_info->xfs_spaceman call path was a new
change. With that in mind, I agree it makes sense to drop this patch.

Cheers, David
