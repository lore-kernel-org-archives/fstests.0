Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E672EC83F01
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbjH3SxC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbjH3NSK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2023 09:18:10 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9BA137
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2023 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nIo1A1xYFMsZfVxmBZB4DNRX4hpKcowLMVuUYzC1IqM=; b=Hq+rbcyXZabjzM6h7OnDyWZM42
        ffx2xc7eAQM2/RTqKXPE2JHH7qz9BapC6mLOQeR5gEeX1cGpNZWevHxh1D7tNwxKeb+tMmB90HWzR
        6hX8GiOmAln3VMNoVasFZwQCHcRcYceDBNFSBcdz/0oWKPgu45vFF8H3KEZ7Y/bkCxri80QNVyLwl
        WlqU5eiGcjl3HJZb8w8KQj7+zlIWetWGb0WnW3bGdPA6etUzW/z8nCyhpR4+jqqX4ixxbKNJBRWoS
        +BPKxjJ/op93gHcB3m9ni9dssZhJl/EFW2UkZNVSEX0g7Mg27JO2sCf8ZRxRwtNUeSrv3JTep6jxc
        iUxgLpCw==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qbL58-00HOLm-Sy
        for <fstests@vger.kernel.org>; Wed, 30 Aug 2023 15:18:03 +0200
Message-ID: <5ac92006-6f06-196b-1acc-7380d8ca4a86@igalia.com>
Date:   Wed, 30 Aug 2023 10:18:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     fstests@vger.kernel.org
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Question about multiple scratch mount points
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks, I am new at fstests development so I have a question
that...might be silly, apologies in advance!

How should I require to have 2 scratch mnt points for some test? I'm not
sure if necessary: what I'd like to accomplish is to mount the same
filesystem (present in the scratch device) twice, in different mount
points. One idea would be to just mkdir 2 folders under $SCRATCH_MNT/,
but I'm not sure if it's guaranteed to be writable before any mounts happen.

Suggestions are appreciated! Also, sent here since I don't really know
other forms of seeking help, tried IRC before without success.
Thanks in advance,


Guilherme
