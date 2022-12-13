Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A1C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 08:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiLMIzx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 03:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiLMIzw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 03:55:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE14237
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 00:55:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C8951FDCF;
        Tue, 13 Dec 2022 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670921749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bZ4LY1/hIZ//Qsh+Ng/+eWosFhbP9mY9iKT3DfmITM=;
        b=EKMVxA5t8nZdNdYeoeNecbylHynXmFx7X42m5PeV4YJPvQAkZo6PKyG14Tl4QN5D6EZWfv
        0UdHsuvE8CuvFephApmB1cvud/rH83f4UMUPYdk5YMCYp7FGLIy/xn6LbYnp6fL9lfpvSm
        n/cuuuhCx/uClicFkYNpGWY8wRpVG7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670921749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bZ4LY1/hIZ//Qsh+Ng/+eWosFhbP9mY9iKT3DfmITM=;
        b=gOvuwKpL+mPwbZQzu1iKOvHCCDHt73Zn5CSWJduN9FERs5Dw7CgV3ItCzxtPnseNz3q1TA
        1QAWrqIDUBEsRxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C47138EE;
        Tue, 13 Dec 2022 08:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LgkhBBU+mGPjLgAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 13 Dec 2022 08:55:49 +0000
Date:   Tue, 13 Dec 2022 09:56:39 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] tests/generic/027: use c-style for loops
Message-ID: <20221213095639.4e98895d@echidna.fritz.box>
In-Reply-To: <Y5gSzdGm2et5E1r+@sol.localdomain>
References: <20221212230820.3466-1-ddiss@suse.de>
        <20221212230820.3466-2-ddiss@suse.de>
        <Y5gSzdGm2et5E1r+@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 12 Dec 2022 21:51:09 -0800, Eric Biggers wrote:

> > -while [ $i -le $loop ]; do
> > +for ((i = 1; i < loop; i++)); do  
> 
> This does one fewer iteration than before.

Gah you're right. I'll drop this patch as it was only intended as a
readability clean-up. Thanks for the review.

Cheers, David
