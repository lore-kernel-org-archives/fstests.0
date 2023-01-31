Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BDEC636CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAaMd5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjAaMd4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:33:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB30298F9
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:33:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDA5D22845;
        Tue, 31 Jan 2023 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwsCUYanjYxSks2eN0nU17zcJLzyO2yYTB9EWcFawX4=;
        b=xVW9CKLBeLPpsIZI3A5lc/qvZ9vAHfgqTytv3MJTXedQo8nLqdiPaCxjlsrocx3dcCKy7A
        GZCzqsWPTAo8wMZzGt/eJauBpOXCIYOPEkH7KPrFAthxPcxN1Fe7F0PXTT+Q6mpGCRwYv1
        SgaSNK1k49baj/NCf7av0fKek7wfLig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168432;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwsCUYanjYxSks2eN0nU17zcJLzyO2yYTB9EWcFawX4=;
        b=ldALs+8itbVzRcOI+L1n/M6KlPFDI3VmKJYsZ1avImuZMgicWPHJaJcOOxDnok8pTQDI1O
        epcJYKvZiUkiNMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B13E213585;
        Tue, 31 Jan 2023 12:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NGlcK7AK2WO9DgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:33:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 091FFA06D5; Tue, 31 Jan 2023 13:33:52 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:33:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] common: Improve blocksize support for udf
Message-ID: <20230131123351.tkuauoqt5csockwx@quack3>
References: <20230123093800.3394-1-jack@suse.cz>
 <20230130165423.r2okhrub4mkdhbwx@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130165423.r2okhrub4mkdhbwx@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue 31-01-23 00:54:23, Zorro Lang wrote:
> On Mon, Jan 23, 2023 at 10:38:00AM +0100, Jan Kara wrote:
> > Add better support for blocksize selection in _scratch_mkfs_sized
> > (accept another variant of mkfs options, select correct default block
> > size if not specified). Also add blocksize selection support to
> > _scratch_mkfs_blocksized.
> > 
> > For _check_udf_filesystem to keep working when blocksize is not
> > specified in MKFS_OPTIONS, add detection of blocksize from a mounted
> > filesystem.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Is this patch a replacement of below patch ?
>   [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck

No, it is an addition on top of this - a reaction to your comment that
besides _check_udf_filesystem there are other places that could use better
handling of blocksize in UDF.

> Due to you've sent a patchset, and that 2nd patch has been reviewed but
> not merged:
>   [PATCH 2/2] common: Unmount udf filesystem prior checking
> 
> I'm not sure if you write this one singly to replace the 1st patch, or be a
> supplement. Can you send these 2 or 3 patches in one patchset :)

So all three patches are needed. I can resend them all in one series if it
helps you.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
