Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6322FC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiCaIan (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiCaIam (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 04:30:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3B11CABEE
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 01:28:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9FDCA1F869;
        Thu, 31 Mar 2022 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648715332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=9bdJsvoNC8w16LL4Ycs7EqaaZkcAwZeuEvFt/OjT1fE=;
        b=2E0UTBsyfyZzFu5WCB2QVBvPD2zERlCPnzFRwFi7et2rQYNGI0oRmySw7NvTOIy8jVF2Mo
        JH13c8dlIpMYTSqMLfUmncFQEKQMyDGav+g5wIWI28+QEdZYByGEmiwuKzTw6cI5hLC9sW
        B/4Pctw2sfjA7o9cBn1RFic2urg/zWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648715332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=9bdJsvoNC8w16LL4Ycs7EqaaZkcAwZeuEvFt/OjT1fE=;
        b=+jlInOcX2R0O4nVtPUI6VgIvLOCYKUSh23AQkIWLx9aT/602KlE57X/eHADapkwoc6jCSY
        JRZhbVY9uoZhFVAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 92490A3B8A;
        Thu, 31 Mar 2022 08:28:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AF74EA0610; Thu, 31 Mar 2022 10:28:46 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:28:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     fstests@vger.kernel.org
Subject: generic/633 failing without CONFIG_USER_NS
Message-ID: <20220331082846.b4vccc3rb7lmojxs@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

I have noticed that when I build a kernel without CONFIG_USER_NS,
generic/633 is failing. This is because despite it properly detects
idmapped mounts are not supported, it still tries to execute some tests
(such as fscaps test) and they rely on bits of user namespace support (e.g.
/proc/<pid>/ns/user existing). I could hack some additional support check
into the test but then I figured I'm not sure whether all the tests are OK
to skip without CONFIG_USER_NS or whether there are not some more subtle
dependencies... So I'm asking here :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
