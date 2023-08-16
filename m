Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8CC41513
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Aug 2023 19:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjHPTkq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345840AbjHPTkS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Aug 2023 15:40:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F61FE1
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 12:40:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E21131F86C;
        Wed, 16 Aug 2023 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692214811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yxRmOnoegHg1YACTNg8XJKxxiizD6lgO1BrvCGzzos=;
        b=k7OgY6p5TE5MxUHAclpqpoi0FMdRXSzIDhNnF1N3Qs0imxtQfBt806J506cxwvXq2tsrig
        drxApZsYeQEffyqUk7WipSbCF3oH9sywUMZom74GQHk38ZFVuafgvYhBmouHDmuz2J7USs
        m6//bBukn+/RCjCF9t7LoJaoAsbd1xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692214811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yxRmOnoegHg1YACTNg8XJKxxiizD6lgO1BrvCGzzos=;
        b=2kHs/QE8vmAQtpvItyhWGG0OOcExSx/wfG5p3O5puiN9zD2s4TvZ9yTTR8eSo9HDlOT+/j
        /T8+5TIlicb1ebCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC6481353E;
        Wed, 16 Aug 2023 19:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hBx5LBsm3WQjDwAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 16 Aug 2023 19:40:11 +0000
Date:   Wed, 16 Aug 2023 21:42:54 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] common/rc: drop 'fsck -f' parameter from
 _repair_test_fs
Message-ID: <20230816214254.4fc968c2@echidna.fritz.box>
In-Reply-To: <20230816145543.ic73cnwhzayuivag@zlang-mailbox>
References: <20230816103330.961-1-ddiss@suse.de>
        <20230816145543.ic73cnwhzayuivag@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 16 Aug 2023 22:55:43 +0800, Zorro Lang wrote:

> On Wed, Aug 16, 2023 at 12:33:30PM +0200, David Disseldorp wrote:
> > The '-f' parameter is fsck.ext# specific, where it's documented to:
> >   Force checking even if filesystem is marked clean
> > 
> > _repair_test_fs() is only called on _check_test_fs() failure, so
> > dropping the parameter should be possible without changing ext#
> > behaviour.
> > Doing so fixes _repair_test_fs() on exfat, where fsck.exfat doesn't
> > support '-f'.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> > v2: drop -f from default case instead of splitting out exfat case  
> 
> This version is good to me.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks.

> I remembered you hope to add a btrfs branch to _repair_scratch_fs and
> _repair_test_fs [1]. Is that still in your plan? Anand, could you provide
> more suggestions about that?

Yes, that's still my plan, but I was hoping to get some more input on
whether "btrfs check --repair ..." is sufficient before proposing the
change.

Cheers, David
