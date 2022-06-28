Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA9FC43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 22:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiF1WgY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiF1WgX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 18:36:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72253A70F
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 15:36:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB4C1F977;
        Tue, 28 Jun 2022 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656455781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kdCjV5f0/Oy2LotdIkdGBBFkh70EEnOQ3dTX7HR2OU=;
        b=2aFjBpPY/JmPYng5k9BaEOLe4Dfb0CGRIn8+XIa3Bay8Obhxvv3HAvzFCvAv6P9JUAGFSw
        LPXCARHhDT31OT+kgHfS7Ao+rOpX1P8vLF6V7LaRWpV5tFY0vJsPQrjoLOmXPfX5A+pRpX
        HvHLx8laN9UHqEfZKu8CI+2pW6YUlZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656455781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kdCjV5f0/Oy2LotdIkdGBBFkh70EEnOQ3dTX7HR2OU=;
        b=JutW5ezdnFaqA9tDWaxCD9fMMZQ3adZrjuVw5vdLi5JkmlDSMvHAQXKW3TxZoiI7b6SOk/
        EacebDrAeWmlrTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FDD713ACA;
        Tue, 28 Jun 2022 22:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id smUMFmWCu2K3GQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 28 Jun 2022 22:36:21 +0000
Date:   Wed, 29 Jun 2022 00:36:20 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 6/6] check: stash full/dmesg/out.bad files on
 rerun
Message-ID: <20220629003620.5b892ae3@suse.de>
In-Reply-To: <YrsbOCcAA5+dDjdl@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
        <20220627222256.14175-7-ddiss@suse.de>
        <YrsbOCcAA5+dDjdl@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 28 Jun 2022 08:16:08 -0700, Darrick J. Wong wrote:

> On Tue, Jun 28, 2022 at 12:22:56AM +0200, David Disseldorp wrote:
> > These files would otherwise be overwritten.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>  
> 
> Why not fold this into the previous patch?

Gladly. Will do so in a subsequent round.

Cheers, David
