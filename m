Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E9C61DA4
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Feb 2023 14:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBVOgD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjBVOgD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2023 09:36:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7493A3B0FB
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 06:35:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC71F33855;
        Wed, 22 Feb 2023 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677076545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjmM4G2VAeiSFwToGq2BcYtad60tv2rv6/prs7/4sQU=;
        b=Zv0RO5/LEvBOWt9hIChx9CZdRiJ0KvUgZufj4YNM3zPqJIlj3H9K4Ga4EoHvDEVaz/XIDL
        dHzIhN59elLw63phjf4h1kFnOwqGT4GJIdwr51LyVasrPEme5E3bnmKlAyePzvYUXW8LXu
        v9HHLiTVBio2+Pc8LZVnUGdg3fPYn0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677076545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjmM4G2VAeiSFwToGq2BcYtad60tv2rv6/prs7/4sQU=;
        b=vXDjnnZuT5UlgyHFf+JofWzU0qZfAmI3AcqJDnMZFTSvvl49GaPqI8Wdxednuwx3rH9XoU
        1RscpF7xZy6LVZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E74C133E0;
        Wed, 22 Feb 2023 14:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vrV9HUEo9mOqDAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 22 Feb 2023 14:35:45 +0000
Date:   Wed, 22 Feb 2023 15:37:09 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, djwong@kernel.org,
        amir73il@gmail.com
Subject: Re: [PATCH v3] selftest: add tests for debugging testing setup
Message-ID: <20230222153709.1ac846a5@echidna.fritz.box>
In-Reply-To: <20230221223649.3616254-1-leah.rumancik@gmail.com>
References: <20230221223649.3616254-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 21 Feb 2023 14:36:49 -0800, Leah Rumancik wrote:

> Many people have developed infrastructure around xfstests. In order to
> test a setup, it would be helpful to have dummy tests that have
> consistent test outcomes. Add a new test folder with the following
> tests:
> 
> selftest/001 pass
> selftest/002 fail from output mismatch
> selftest/003 fail via _fail
> selftest/004 skip
> selftest/005 crash
> selftest/006 hang
> 
> Also, create two new groups: 'selftest' which includes tests 001-004 and
> 'dangerous_selftest' which includes tests 005-006. The selftests will
> not run unless explicitly specified.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
> v2 -> v3:
> - remove selftest folder from SRC_GROUPS
> - add README.selftest
> - remove trailing blank lines from tests

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

Some sort of meta-check to confirm that the selftest results match
expectations would be IMO helpful, but that can come later.
