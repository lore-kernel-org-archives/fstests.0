Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E0FC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F0E6103B
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhIXJUs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:20:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47844 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhIXJUs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Sep 2021 05:20:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 961FC22413;
        Fri, 24 Sep 2021 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632475154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QF1OrmDHsN8AuKmcemEBIErH9IP7wL5Vc7V6rLSacdg=;
        b=J7Cugs4BfrOOYg3hHYXd+F6LuS+VLeYCOGyxd74a+dyEuik14X+dey3ItZAyxcx/V6ZfPx
        ++AG7Z7nC2qaiQ86xpqQVm/F+ps10W0jjv2NkXbYpkZAFbbyzwaA9eFoVmHhKyQABjw+D8
        zzrwr8UYAt9YXXP9KynZzOHLlB3QzFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632475154;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QF1OrmDHsN8AuKmcemEBIErH9IP7wL5Vc7V6rLSacdg=;
        b=hCbzngBexJyPiQOzp6fMrZHzS7XvqARKBChkmtCdulPAW29FyKe5F6Pm6nfDCv1vGrTuXO
        pMAOMWFZbvt/XCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2059B13AB3;
        Fri, 24 Sep 2021 09:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M37ABBKYTWFoLAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 24 Sep 2021 09:19:14 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id c94ad1fd;
        Fri, 24 Sep 2021 09:19:13 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2 0/2] generic/079 test fails if 'nobody' and 'daemon' don't exist
Date:   Fri, 24 Sep 2021 10:19:09 +0100
Message-Id: <20210924091911.19413-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

Here's v2 of this humble patchset.  Here's what changed since v1:

- 'user' variable in _require_user_exists() is now local, as suggested
  by Eric Biggers.

(I've also added Darrick's Reviewed-by tag to the 2nd patch only.)

Original cover-letter:

Test generic/079 currently fails if for some reason the 'nobody' or
'daemon' users don't exist:

*** starting up
add_acl(/mnt/scratch/079/immutable.f) did not set errno == EPERM
add_acl(/mnt/scratch/079/immutable.d) did not set errno == EPERM
add_acl(/mnt/scratch/079/append-only.f) did not set errno == EPERM
add_acl(/mnt/scratch/079/append-only.d) did not set errno == EPERM
testing immutable...FAILED! (2 tests failed)
testing append-only...FAILED! (2 tests failed)
*** cleaning up

The first patch that follows adds a new function _require_user_exists()
that will verify a user exists in the system (and refactors existent
_require_user() to use the new function).

The second patch is the actual test fix.

Luis Henriques (2):
  common/rc: add _require_user_exists() to check if a user exists
  generic/079: make sure users 'nobody' and 'daemon' exist

 common/rc         | 27 ++++++++++++++++++---------
 tests/generic/079 |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

