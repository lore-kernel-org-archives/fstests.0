Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0AC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiDKJAL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiDKJAJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 05:00:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBE63ED08
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 01:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4C93210ED;
        Mon, 11 Apr 2022 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649667474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rw3yYNpEbEt2TTqQAgc8Oyb1NbTun5B1UTfDIQaBZ/4=;
        b=A5oCPoT6jhULWJ1lJpP4kmOGkRXcAi5cxpvrQNp4LwXSv5grvmkswJoFY1MSeD0l2SA5Ah
        32sK7Krgy+eb/IvAn/dplX41ZCvb+9/2Q8b6nQfO43f25nzwOEgxQuc57CEevjetmy56zh
        m3k3IQ1ScfhNn+Hx0Q4CoP1Y5E1/hPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649667474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rw3yYNpEbEt2TTqQAgc8Oyb1NbTun5B1UTfDIQaBZ/4=;
        b=vCCaA2+4SsvamHSYManR+oF4V/Uul56iIwoWaJI+gq9Ij/aqOS6QrA5oEcQF8i28R1Ayce
        TbX9W24PlUF4fMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A4513AB5;
        Mon, 11 Apr 2022 08:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3WZyLpLtU2KSOgAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 11 Apr 2022 08:57:54 +0000
Date:   Mon, 11 Apr 2022 10:57:52 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/attr: reduce MAX_ATTRVAL_SIZE for NFS
Message-ID: <20220411105752.2b11cb15@suse.de>
In-Reply-To: <20220411054714.GI1609613@dread.disaster.area>
References: <20220408191943.27655-1-ddiss@suse.de>
        <20220411054714.GI1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the review, Dave...

On Mon, 11 Apr 2022 15:47:14 +1000, Dave Chinner wrote:

> > This is due to the MAX_ATTRVAL_SIZE=65536 setting for NFS, which exceeds
> > the Btrfs (and XFS) limit of MAX_ATTRVAL_SIZE=64. Change NFS to use this
> > lower bound value.  
> 
> I think that what XFS/UDF/BTRFS set here is bogus.
> 
> There is *one* test - generic/020 - that uses MAX_ATTRS and
> MAX_ATTRVAL_SIZE, and  it uses MAX_ATTRVAL_SIZE as a byte count.
> 
> Which means for those 3 filesytems, the correct value for them is
> 65536, not 64....
> 
> This looks like it was broken back when the test was made generic
> - the dd command before this used a bs=1024, so a maz size of 64
> would have been correct. Except the dd command also go changed to
> use bs=1, which meant 64 bytes....
> 
> So, yeah, the test got "broken" for XFS back in 2012 and so the
> correct fix here is to change (at least) XFS and btrfs to have a
> MAX_ATTRVAL_SIZE=65536....

I'll change XFS over to use a 64K bytes limit. It looks like we'll need
a separate special case for Btrfs, as the size limit also takes the attr
name length into account:

 79 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 80                    const char *name, const void *value, size_t size, int flags)
 81 {
 ...
 91         if (name_len + size > BTRFS_MAX_XATTR_SIZE(root->fs_info))
 92                 return -ENOSPC;

BTRFS_MAX_XATTR_SIZE() is also 16K by default on my test system. Given
that this is for generic/020 only, my plan is to turn the existing
MAX_ATTRVAL_SIZE logic into a helper function.

Cheers, David
